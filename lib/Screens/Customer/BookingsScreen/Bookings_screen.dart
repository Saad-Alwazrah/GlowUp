import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:glowup/CustomWidgets/Shared/custom_calendar.dart';
import 'package:glowup/Repositories/api/supabase_connect.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = GetIt.I.get<SupabaseConnect>();
    return Scaffold(
      body: Center(child: CustomCalendar(stylist: supabase.stylists[1])),
    );
  }
}
