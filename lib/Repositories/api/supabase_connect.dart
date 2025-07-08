// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glowup/Repositories/models/appointment.dart';
import 'package:glowup/Repositories/models/availability_slot.dart';
import 'package:glowup/Repositories/models/profile.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Repositories/models/stylist.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConnect {
  late Supabase supabase;
  List<Provider> providers = [];
  List<Stylist> stylists = [];
  List<Services> services = [];
  List<Appointment> appointments = [];
  List<AvailabilitySlot> availabilitySlots = [];
  List<Map<String, dynamic>> distances = [];
  List<Map<String, dynamic>> serviceStylists = [];
  late Position userLocation;

  Profile? userProfile;
  User? user;
  Provider? theProvider;

  String getEmail() {
    return user?.email?.trim() ?? '';
  }

  Future<void> init() async {
    try {
      supabase = await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL']!,
        anonKey: dotenv.env['ANON_KEY']!,
      );
      await fetchData();
      await isLoggedIn();
    } catch (e) {
      log("Supabase initialization failed: $e");
    }
  }

  Future<void> isLoggedIn() async {
    if (supabase.client.auth.currentUser != null) {
      user = supabase.client.auth.currentUser;
      final resClient = supabase.client;
      final userProfileResponse = await resClient
          .from("profiles")
          .select("*")
          .eq("id", user!.id)
          .single();
      userProfile = Profile.fromJson(userProfileResponse);

      if (userProfile?.role == "customer") {
        await getDistancesFromUser();
        linkData();
      } else if (userProfile?.role == "provider") {
        final providerResponse = await resClient
            .from("providers")
            .select("*")
            .eq("id", user!.id)
            .single();
        theProvider = Provider.fromJson(providerResponse);
        // Fetch provider-specific data if needed
      }
    } else {
      log("No user is currently authenticated");
    }
  }

  bool isConflictingAppointment(
    DateTime date,
    TimeOfDay time,
    Stylist stylist,
  ) {
    for (var appt in appointments) {
      if (appt.stylistId != stylist.id) continue;
      if (appt.status == "rejected") continue;

      // 1. Parse the stored date string into a DateTime:
      //    (handles both "2025-07-30" and full ISO strings)
      final DateTime apptDateTime = DateTime.parse(appt.appointmentDate);
      final DateTime apptDate = DateTime(
        apptDateTime.year,
        apptDateTime.month,
        apptDateTime.day,
      );
      final DateTime selDate = DateTime(date.year, date.month, date.day);

      if (apptDate != selDate) continue;

      // 2. Parse the stored time string "HH:mm:ss" into TimeOfDay:
      final parts = appt.appointmentStart.split(':');
      final int apptHour = int.parse(parts[0]);
      final int apptMinute = int.parse(parts[1]);
      final TimeOfDay apptTime = TimeOfDay(hour: apptHour, minute: apptMinute);

      // 3. Compare TimeOfDay directly:
      if (apptTime == time) {
        return true;
      }
    }
    return false;
  }

  Future<void> fetchData() async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      await Future.wait([
        getStylists(),
        getProviders(),
        getServices(),
        getServiceStylists(),
        getAppointments(),
        getDistancesFromUser(),
        getAvailabilitySlots(),
      ]).then((_) {
        linkData();
        log("Data fetched successfully");
      });
      log("Data fetched in ${stopwatch.elapsedMilliseconds} ms");
      log("Services: ${jsonEncode(services)}");
    } catch (e) {
      log("Error fetching data: $e");
    }
  }

  Future<void> getAppointments() async {
    try {
      final resClient = supabase.client;
      final appointmentsResponse = await resClient
          .from("appointments")
          .select("*");
      if (appointmentsResponse.isEmpty) {
        log("No Appointments found");
        return;
      }
      appointments = appointmentsResponse
          .map((e) => Appointment.fromJson(e))
          .toList();
    } catch (e) {
      log("Error fetching appointments: $e");
    }
  }

  Future<void> getServiceStylists() async {
    try {
      final resClient = supabase.client;
      // Getting the service stylists from supabase
      final serviceStylistsResponse = await resClient
          .from("service_stylists")
          .select("*");
      if (serviceStylistsResponse.isEmpty) {
        log("No Service Stylists found");
        return;
      }
      serviceStylists = List<Map<String, dynamic>>.from(
        serviceStylistsResponse,
      );
    } catch (e) {
      log("Error fetching service stylists: $e");
    }
  }

  Future<void> getServices() async {
    try {
      final resClient = supabase.client;

      // Getting the services from supabase
      final servicesResponse = await resClient.from("services").select("*");
      if (servicesResponse.isEmpty) {
        log("No Services found");
        return;
      }
      services = servicesResponse.map((e) => Services.fromJson(e)).toList();

      //  Parsing the services into a list of Service objects
    } catch (e) {
      log("Error fetching services: $e");
    }
  }

  Future<void> getProviders() async {
    try {
      final resClient = supabase.client;
      // Getting the providers from supabase
      final providersResponse = await resClient.from("providers").select("*");
      if (providersResponse.isEmpty) {
        log("No Providers found");
        return;
      }
      providers = providersResponse.map((e) => Provider.fromJson(e)).toList();
      // getting the distance from each provider to the user
    } catch (e) {
      log("Error fetching providers: $e");
    }
  }

  Future<void> getDistancesFromUser() async {
    final resClient = supabase.client;
    try {
      final distancesRes = await resClient
          .rpc(
            "providers_with_distance",
            params: {"p_profile_id": userProfile?.id},
          )
          .select("*");
      // The above RPC function should return a list of providers with their distances
      distances = List<Map<String, dynamic>>.from(distancesRes);
    } catch (e) {
      log("Error fetching distances from user: $e");
    }
  }

  Future<void> getStylists() async {
    final resClient = supabase.client;
    try {
      final stylistsResponse = await resClient.from("stylists").select("*");
      if (stylistsResponse.isEmpty) {
        log("No Stylists found");
        return;
      }
      stylists = stylistsResponse.map((e) => Stylist.fromJson(e)).toList();
    } catch (e) {
      log("Error fetching stylists: $e");
    }
  }

  Future<void> getAvailabilitySlots() async {
    final resClient = supabase.client;
    try {
      final slotsResponse = await resClient
          .from("availability_slots")
          .select("*")
          .gt("date", DateTime.now().toIso8601String());

      availabilitySlots = slotsResponse
          .map((e) => AvailabilitySlot.fromJson(e))
          .toList();
    } catch (e) {
      log("Error fetching availability slots: $e");
    }
  }

  Future<void> updateEmail(String newEmail) async {
    final resClient = supabase.client;
    try {
      final userRes = await resClient.auth.updateUser(
        UserAttributes(email: newEmail),
      );
      user = userRes.user;
      await resClient
          .from("profiles")
          .update({'email': newEmail})
          .eq("id", userProfile!.id);
      log("Email updated successfully");
    } catch (e) {
      log("Error updating email: $e");
    }
  }

  Future<void> updatePhone(String newPhone) async {
    final resClient = supabase.client;
    try {
      await resClient
          .from("profiles")
          .update({'phone': newPhone})
          .eq("id", userProfile!.id);
      userProfile?.phone = newPhone;
      log("Phone updated successfully");
    } catch (e) {
      log("Error updating phone: $e");
    }
  }

  Future<void> updateUsername(String newUsername) async {
    final resClient = supabase.client;
    try {
      await resClient
          .from("profiles")
          .update({'username': newUsername})
          .eq("id", userProfile!.id);
      userProfile?.username = newUsername;
      log("Username updated successfully");
    } catch (e) {
      log("Error updating username: $e");
    }
  }

  Future<void> updateProviderName(String newName) async {
    final resClient = supabase.client;
    try {
      await resClient
          .from("providers")
          .update({'name': newName})
          .eq("id", theProvider!.id);
      theProvider?.name = newName;
      log("Provider name updated successfully");
    } catch (e) {
      log("Error updating provider name: $e");
    }
  }

  Future<void> updateProviderPhone(String newPhone) async {
    final resClient = supabase.client;
    try {
      await resClient
          .from("providers")
          .update({'phone': newPhone})
          .eq("id", theProvider!.id);
      theProvider?.phone = newPhone;
      log("Provider phone updated successfully");
    } catch (e) {
      log("Error updating provider phone: $e");
    }
  }

  Future<void> bookAppointment({
    required String appointmentDate,
    required String appointmentStart,
    required String appointmentEnd,
    required String stylistId,
    required int serviceId,
    required String providerId,
    required bool atHome,
  }) async {
    final resClient = supabase.client;
    try {
      appointmentDate =
          "${DateTime.parse(appointmentDate).year}-${DateTime.parse(appointmentDate).month.toString().padLeft(2, '0')}-${DateTime.parse(appointmentDate).day.toString().padLeft(2, '0')}";
      appointmentStart =
          "${DateTime.parse(appointmentStart).hour.toString().padLeft(2, '0')}:${DateTime.parse(appointmentStart).minute.toString().padLeft(2, '0')}";
      appointmentEnd =
          "${DateTime.parse(appointmentEnd).hour.toString().padLeft(2, '0')}:${DateTime.parse(appointmentEnd).minute.toString().padLeft(2, '0')}";
      log("Booking appointment for user: ${userProfile?.id}");
      log("Appointment date: $appointmentDate");
      log("Appointment start: $appointmentStart");
      log("Appointment end: $appointmentEnd");
      log("Stylist ID: $stylistId");
      log("Service ID: $serviceId");
      log("Provider ID: $providerId");

      final newAppointment = Appointment(
        customerId: userProfile!.id,
        bookedAt: DateTime.now().toIso8601String(),
        appointmentDate: appointmentDate,
        appointmentStart: appointmentStart,
        appointmentEnd: appointmentEnd,
        stylistId: stylistId,
        serviceId: serviceId,
        providerId: providerId,
        status: "Pending",
        atHome: atHome,
      );
      await resClient.from("appointments").insert(newAppointment.toJson());
      await fetchData();
      log("Appointment booked successfully");
    } catch (e) {
      log("Error booking appointment: $e");
    }
  }

  void linkData() {
    Stopwatch stopwatch = Stopwatch()..start();
    for (var provider in providers) {
      provider.stylists.clear();
    }
    for (var service in services) {
      service.stylists.clear();
    }
    for (var stylist in stylists) {
      stylist.availabilitySlots.clear();
    }
    for (var provider in providers) {
      provider.services.clear();
    }
    // linking providers with stylists
    for (Stylist stylist in stylists) {
      for (Provider provider in providers) {
        if (provider.id == stylist.providerId) {
          provider.stylists.add(stylist);
        }
      }
    }
    //linking providers with distance from user
    for (Map<String, dynamic> distance in distances) {
      for (Provider provider in providers) {
        if (provider.id == distance['provider_id']) {
          provider.distanceFromUser =
              "${(distance['distance_m'] / 1000).toStringAsFixed(2)} km";
        }
      }
    }
    for (Services service in services) {
      for (Provider provider in providers) {
        if (service.providerId == provider.id) {
          provider.services.add(service);
        }
      }
    }
    // linking stylists with services
    for (Services service in services) {
      for (Stylist stylist in stylists) {
        if (serviceStylists.any(
          (e) => e['service_id'] == service.id && e['stylist_id'] == stylist.id,
        )) {
          service.stylists.add(stylist);
        }
      }
    }
    // linking stylists with their availability slots
    for (Stylist stylist in stylists) {
      for (AvailabilitySlot slot in availabilitySlots) {
        if (slot.stylistId == stylist.id) {
          stylist.availabilitySlots.add(slot);
        }
      }
    }
    // linking services with their provider
    for (Services service in services) {
      for (Provider provider in providers) {
        if (service.providerId == provider.id) {
          service.provider = provider;
        }
      }
    }
    // linking appointments with their provider
    for (Appointment appointment in appointments) {
      for (Provider provider in providers) {
        if (appointment.providerId == provider.id) {
          appointment.provider = provider;
        }
      }
      // linking appointments with their stylist
      for (Stylist stylist in stylists) {
        if (appointment.stylistId == stylist.id) {
          appointment.stylist = stylist;
        }
      }
      // linking appointments with their service
      for (Services service in services) {
        if (appointment.serviceId == service.id) {
          appointment.service = service;
        }
      }
    }
    log("Data linked in ${stopwatch.elapsedMicroseconds} µs");
  }

  /// Uploads or replaces the authenticated user’s avatar.
  /// Returns true if the upload was successful.
  Future<bool> uploadUserAvatar({
    required String localFilePath,
    required String userId,
  }) async {
    final bucket = supabase.client.storage.from('assets');
    final remotePath = 'users/$userId/avatar.jpg';

    // Delete existing avatar (if any)
    await bucket.remove([remotePath]).catchError((_) {});

    // Upload new file
    try {
      await bucket.upload(remotePath, File(localFilePath));
      final bustedUrl =
          '${bucket.getPublicUrl(remotePath)}?updated=${DateTime.now().millisecondsSinceEpoch}';

      userProfile?.avatarUrl = bustedUrl;

      await supabase.client
          .from('profiles')
          .update({'avatar_url': userProfile!.avatarUrl})
          .eq('id', userId);
    } catch (e) {
      log('Avatar upload error: $e');
      return false;
    }

    return true;
  }

  /// Deletes the authenticated user’s avatar.
  /// Returns true if deletion succeeded.
  Future<bool> deleteUserAvatar({required String userId}) async {
    final bucket = supabase.client.storage.from('assets');
    final remotePath = 'users/$userId/avatar.jpg';

    try {
      await bucket.remove([remotePath]).catchError((_) {});
      await supabase.client
          .from('profiles')
          .update({'avatar_url': null})
          .eq('id', userId);
      userProfile?.avatarUrl = null;
    } catch (e) {
      log('Avatar deletion error: $e');
      return false;
    }
    return true;
  }

  Future<bool> uploadProviderAvatar({
    required String localFilePath,
    required String providerId,
  }) async {
    final bucket = supabase.client.storage.from('assets');
    final remotePath = 'providers/$providerId/avatar.jpg';

    // Delete existing avatar (if any)
    await bucket.remove([remotePath]).catchError((_) {});

    try {
      await bucket.upload(remotePath, File(localFilePath));

      final bustedUrl =
          '${bucket.getPublicUrl(remotePath)}?updated=${DateTime.now().millisecondsSinceEpoch}';
      await supabase.client
          .from('providers')
          .update({'avatar_url': bustedUrl})
          .eq('id', providerId);
      theProvider!.avatarUrl = bustedUrl;
    } catch (e) {
      log('Avatar upload error: $e');
      return false;
    }
    return true;
  }

  Future<bool> deleteProviderAvatar({required String providerId}) async {
    final bucket = supabase.client.storage.from('assets');
    final remotePath = 'providers/$providerId/avatar.jpg';

    try {
      await bucket.remove([remotePath]).catchError((_) {});
      await supabase.client
          .from('providers')
          .update({'avatar_url': null})
          .eq('id', providerId);
      theProvider!.avatarUrl = null;
      return true;
    } catch (e) {
      log('Avatar deletion error: $e');
      return false;
    }
  }

  /// Uploads or replaces a provider’s banner image.
  /// Returns the public URL of the uploaded banner.
  Future<bool?> uploadProviderBanner({
    required String localFilePath,
    required String providerId,
  }) async {
    final bucket = supabase.client.storage.from('assets');
    final remotePath = 'providers/$providerId/banner.jpg';

    // Delete existing banner (if any)
    await bucket.remove([remotePath]).catchError((_) {});

    try {
      await bucket.upload(remotePath, File(localFilePath));
      final bustedUrl =
          '${bucket.getPublicUrl(remotePath)}?updated=${DateTime.now().millisecondsSinceEpoch}';
      await supabase.client
          .from('providers')
          .update({'banner_url': bustedUrl})
          .eq('id', providerId);
      theProvider!.bannerUrl = bustedUrl;
    } catch (e) {
      log('Banner upload error: $e');
      return false;
    }

    return true;
  }

  /// Deletes a provider’s banner image.
  /// Returns true if deletion succeeded.
  Future<bool> deleteProviderBanner({required String providerId}) async {
    final bucket = supabase.client.storage.from('assets');
    final remotePath = 'providers/$providerId/banner.jpg';

    try {
      await bucket.remove([remotePath]).catchError((_) {});
      await supabase.client
          .from('providers')
          .update({'banner_url': null})
          .eq('id', providerId);
      providers.firstWhere((p) => p.id == providerId).bannerUrl = null;
      return true;
    } catch (e) {
      log('Banner deletion error: $e');
      return false;
    }
  }

  /// Uploads an image for a specific service.
  /// Returns the public URL of the uploaded service image.
  Future<bool?> uploadServiceImage({
    required String localFilePath,
    required int providerId,
    required int serviceId,
  }) async {
    final bucket = supabase.client.storage.from('assets');
    final remotePath = 'providers/$providerId/services/$serviceId.jpg';

    // Delete existing service image (if any)
    await bucket.remove([remotePath]).catchError((_) {});

    try {
      final bustedUrl =
          '${bucket.getPublicUrl(remotePath)}?updated=${DateTime.now().millisecondsSinceEpoch}';
      await supabase.client
          .from('services')
          .update({'image_url': bustedUrl})
          .eq('id', serviceId);
      theProvider!.services.firstWhere((s) => s.id == serviceId).imageUrl =
          bustedUrl;
    } catch (e) {
      log('Service image upload error: $e');
      return false;
    }

    return true;
  }

  Future<bool> signUpNewUser({
    required String email,
    required String password,
    required String username,
    required LatLng position,
  }) async {
    try {
      final resClient = supabase.client;
      final AuthResponse res = await resClient.auth.signUp(
        email: email,
        password: password,
      );
      final User? user = res.user;
      this.user = user;
      userProfile = Profile(
        id: user!.id,
        fullName: "",
        role: "customer",
        latitude: position.latitude,
        longitude: position.longitude,
        phone: null,
        username: username,
      );
    } catch (e) {
      log("Error signing up user: $e");
      return false;
    }

    try {
      final resClient = supabase.client;
      await resClient.from("profiles").upsert(userProfile!.toJson());
      return true;
    } catch (e) {
      log("Error creating user profile: $e");
      return false;
    }
  }

  Future<bool> signUpNewProvider({
    required String email,
    required String password,
    required String number,
    required String username,
    required String address,
    required LatLng position,
  }) async {
    try {
      final resClient = supabase.client;
      final AuthResponse res = await resClient.auth.signUp(
        email: email,
        password: password,
      );
      final User? user = res.user;
      this.user = user;
      userProfile = Profile(
        id: user!.id,
        fullName: "",
        role: "provider",
        phone: number,
        username: username,
      );
      final newProvider = Provider(
        id: user.id,
        name: "",
        phone: number,
        address: address,
        latitude: position.latitude,
        longitude: position.longitude,
        createdAt: DateTime.now().toIso8601String(),
        avgRating: null,
        ratingCount: 0,
      );

      await resClient.from("profiles").upsert(userProfile!.toJson());
      await resClient.from("providers").upsert(newProvider.toJson());
      return true;
    } catch (e) {
      log("Error signing up provider: $e");
      return false;
    }
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final AuthResponse res = await supabase.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;
    this.user = user;

    final resClient = supabase.client;
    final userProfileResponse = await resClient
        .from("profiles")
        .select("*")
        .eq("id", user!.id)
        .single();
    userProfile = Profile.fromJson(userProfileResponse);

    if (userProfile?.role == "customer") {
      await getDistancesFromUser();
      linkData();
    } else if (userProfile?.role == "provider") {
      final providerResponse = await resClient
          .from("providers")
          .select("*")
          .eq("id", user.id)
          .single();
      theProvider = Provider.fromJson(providerResponse);
      // Fetch provider-specific data if needed
    }
    if (session != null) {
      log("User signed in: ${user.email}");
      return true;
    } else {
      log("Sign in failed");
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await supabase.client.auth.signOut();
      user = null;
      userProfile = null;
      theProvider = null;
      log("User signed out successfully");
      return true;
    } catch (e) {
      log("Error signing out: $e");
      return false;
    }
  }
}
