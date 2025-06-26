import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:glowup/Repositories/models/profile.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConnect {
  late Supabase supabase;
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

  Future<void> addFavourite() async {
    if (user == null) {
      log("User not signed in, cannot add favorite");
      return;
    }
    try {
      final resClient = supabase.client;
    } catch (e) {
      log("Error adding favorite: $e");
    }
  }

  Future<void> removeFavourite() async {
    if (user == null) {
      log("User not signed in, cannot remove favorite");
      return;
    }
    try {
      final resClient = supabase.client;
    } catch (e) {
      log("Error removing favorite: $e");
    }
  }

  Future getFavorites() async {
    if (user == null) {
      log("User not signed in, cannot fetch favorites");
      return [];
    }
    try {
      final resClient = supabase.client;
    } catch (e) {
      log("Error fetching favorites: $e");
    }
  }

  Future<void> fetchData() async {
    try {
      // 24.654018, 46.583054
      final resClient = supabase.client;
      var response = await resClient.from("profiles").select("*").single();
      var providerRes = await resClient.from("providers").select("*").single();
      var provider = Provider.fromJson(providerRes);

      var profile = Profile.fromJson(response);
      var distances = await resClient
          .rpc("providers_with_distance", params: {"p_profile_id": profile.id})
          .select("*")
          .single();

      log(jsonEncode(distances));
    } catch (e) {
      log("Error fetching data: $e");
    }
  }

  Future<void> getProvidersDistanceFromUser() async {
    try {
      final resClient = supabase.client;
      if (user == null) {
        log("User not signed in, cannot get providers distance");
      }
    } catch (e) {
      log("Error getting providers distance from user: $e");
    }
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

    if (session != null) {
      log("User signed up as: ${user?.email}");
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
