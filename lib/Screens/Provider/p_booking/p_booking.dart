import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowup/CustomWidgets/Shared/search_bar.dart';

import 'package:glowup/CustomWidgets/shared/status_toggle.dart';

import 'package:glowup/Screens/Provider/p_booking/bloc/p_booking_bloc.dart';
import 'package:glowup/Screens/Provider/p_booking/bloc/p_booking_event.dart';
import 'package:glowup/Screens/Provider/p_booking/bloc/p_booking_state.dart';

class PBookingsScreen extends StatelessWidget {
  const PBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return BlocProvider(
      create: (_) => PBookingBloc(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              CustomSearchBar(
                controller: searchController,
                hintText: "Search for my bookings...",
                onChanged: (value) {
                  // Optional: Dispatch a search event to PBookingBloc
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<PBookingBloc, PBookingState>(
                builder: (context, state) {
                  return StatusToggle(
                    selectedIndex: state.selectedIndex,
                    onSelected: (int index) {
                      context
                          .read<PBookingBloc>()
                          .add(PStatusToggleChanged(index));
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: Text("Provider Booking list goes here"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
