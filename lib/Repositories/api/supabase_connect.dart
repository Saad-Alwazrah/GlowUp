import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:glowup/Repositories/models/appointment.dart';
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
        getDistancesFromUser(),
      ]).then((_) {
        log("Data fetched successfully");
      });
      await getAppointments();
      log("Data fetched in ${stopwatch.elapsedMilliseconds} ms");
      print(
        "${jsonEncode(appointments)} ${jsonEncode(appointments[0].provider)} ${jsonEncode(appointments[0].stylist)} ${jsonEncode(appointments[0].service)}",
      );
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
      for (var appointment in appointments) {
        for (var provider in providers) {
          if (appointment.providerId == provider.id) {
            appointment.provider = provider;
          }
        }
        for (var stylist in stylists) {
          if (appointment.stylistId == stylist.id) {
            appointment.stylist = stylist;
          }
        }
        for (var service in services) {
          if (appointment.serviceId == service.id) {
            appointment.service = service;
          }
        }
      }
    } catch (e) {
      log("Error fetching appointments: $e");
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

      final serviceStylistsResponse = await resClient
          .from("service_stylists")
          .select("*");
      if (serviceStylistsResponse.isEmpty) {
        log("No Service Stylists found");
        return;
      }

      // Parsing the services into a list of Service objects
      for (var service in services) {
        for (var stylist in stylists) {
          if (serviceStylistsResponse.any(
            (e) =>
                e['service_id'] == service.id && e['stylist_id'] == stylist.id,
          )) {
            service.stylists.add(stylist);
          }
        }
      }
      for (var service in services) {
        for (var provider in providers) {
          if (service.providerId == provider.id) {
            service.provider = provider;
          }
        }
      }
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

      await getStylists();
      for (var stylist in stylists) {
        for (var provider in providers) {
          if (provider.id == stylist.providerId) {
            provider.stylists.add(stylist);
          }
        }
      }
    } catch (e) {
      log("Error fetching providers: $e");
    }
  }

  Future<void> getDistancesFromUser() async {
    final resClient = supabase.client;
    final distances = await resClient
        .rpc(
          "providers_with_distance",
          params: {"p_profile_id": "c5c8fd53-93c4-453f-ba57-69566b0c4a85"},
        )
        .select("*");
    // The above RPC function should return a list of providers with their distances

    for (var e in distances) {
      for (var provider in providers) {
        if (provider.id == e['provider_id']) {
          provider.distanceFromUser =
              "${(e['distance_m'] / 1000).toStringAsFixed(2)} km";
        }
      }
    }
  }

  Future<void> getStylists() async {
    final resClient = supabase.client;
    final stylistsResponse = await resClient.from("stylists").select("*");
    if (stylistsResponse.isEmpty) {
      log("No Stylists found");
      return;
    }
    stylists = stylistsResponse.map((e) => Stylist.fromJson(e)).toList();
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

    if (session != null) {
      log("User signed in: ${user?.email}");
      return true;
    } else {
      log("Sign in failed");
      return false;
    }
  }
}
