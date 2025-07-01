// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:glowup/Repositories/models/appointment.dart';
import 'package:glowup/Repositories/models/availability_slot.dart';
import 'package:glowup/Repositories/models/profile.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Repositories/models/stylist.dart';
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

  late Profile userProfile;
  User? user;

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
    } catch (e) {
      log("Supabase initialization failed: $e");
    }
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
            params: {"p_profile_id": userProfile.id},
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

  void linkData() {
    Stopwatch stopwatch = Stopwatch()..start();

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
  Future<bool?> uploadUserAvatar({
    required String localFilePath,
    required String userId,
  }) async {
    final bucket = supabase.client.storage.from('assets');
    final remotePath = 'users/$userId/avatar.jpg';

    // Delete existing avatar (if any)
    await bucket.remove([remotePath]).catchError((_) {});

    // Upload new file
    try {
      await supabase.client
          .from('profiles')
          .update({'avatar_url': remotePath})
          .eq('id', userId);
      userProfile.avatarUrl = bucket.getPublicUrl(remotePath);
    } catch (e) {
      log('Avatar upload error: $e');
      return false;
    }

    return true;
  }

  /// Deletes the authenticated user’s avatar.
  /// Returns true if deletion succeeded.
  Future<bool> deleteUserAvatar({required String userId}) async {
    final bucket = supabase.client.storage.from('public-assets');
    final remotePath = 'users/$userId/avatar.jpg';

    try {
      await bucket.remove([remotePath]).catchError((_) {});
      await supabase.client
          .from('profiles')
          .update({'avatar_url': null})
          .eq('id', userId);
      userProfile.avatarUrl = null;
    } catch (e) {
      log('Avatar deletion error: $e');
      return false;
    }
    return true;
  }

  /// Uploads or replaces a provider’s banner image.
  /// Returns the public URL of the uploaded banner.
  Future<bool?> uploadProviderBanner({
    required String localFilePath,
    required String providerId,
  }) async {
    final bucket = supabase.client.storage.from('public-assets');
    final remotePath = 'providers/$providerId/banner.jpg';

    // Delete existing banner (if any)
    await bucket.remove([remotePath]).catchError((_) {});

    try {
      await supabase.client
          .from('providers')
          .update({'banner_url': remotePath})
          .eq('id', providerId);
      providers.firstWhere((p) => p.id == providerId).bannerUrl = bucket
          .getPublicUrl(remotePath);
    } catch (e) {
      log('Banner upload error: $e');
      return false;
    }

    return true;
  }

  /// Deletes a provider’s banner image.
  /// Returns true if deletion succeeded.
  Future<bool> deleteProviderBanner({required String providerId}) async {
    final bucket = supabase.client.storage.from('public-assets');
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
    final bucket = supabase.client.storage.from('public-assets');
    final remotePath = 'providers/$providerId/services/$serviceId.jpg';

    // Delete existing service image (if any)
    await bucket.remove([remotePath]).catchError((_) {});

    try {
      await supabase.client
          .from('services')
          .update({'image_url': remotePath})
          .eq('id', serviceId);
      services.firstWhere((s) => s.id == serviceId).imageUrl = bucket
          .getPublicUrl(remotePath);
    } catch (e) {
      log('Service image upload error: $e');
      return false;
    }

    return true;
  }

  Future<bool> signUpNewUser({
    required String email,
    required String password,
  }) async {
    final AuthResponse res = await supabase.client.auth.signUp(
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

    if (session != null) {
      log("User signed up as: ${user.email}");
      return true;
    } else {
      log("Sign in failed");
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

    if (session != null) {
      log("User signed in: ${user.email}");
      return true;
    } else {
      log("Sign in failed");
      return false;
    }
  }
}
