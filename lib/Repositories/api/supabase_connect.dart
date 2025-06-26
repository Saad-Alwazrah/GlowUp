import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  Future fetchData() async {
    try {
      final resClient = supabase.client;
      var response = await resClient.from("providers").select("*").single();
      log("-----");
      final provider = Provider.fromJson(response);
      provider.latitude = null;
      provider.longitude = null;
      await resClient
          .from("providers")
          .update(provider.toJson())
          .eq("id", provider.id);

      log(jsonEncode(provider.toJson()));
    } catch (e) {
      log("Error fetching data: $e");
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
