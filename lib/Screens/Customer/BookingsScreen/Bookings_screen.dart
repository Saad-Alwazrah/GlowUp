
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowup/CustomWidgets/Shared/search_bar.dart';
import 'package:glowup/CustomWidgets/shared/status_toggle.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_bloc.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_event.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_state.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return BlocProvider(
      create: (_) => BookingBloc(),
      child: Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 SizedBox(height: 80,),
              CustomSearchBar(
                controller: searchController,
                hintText: "Search bookings...",
                onChanged: (value) {
        
              
                },
              ),
               SizedBox(height: 20,),
              BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  return StatusToggle(
                    selectedIndex: state.selectedIndex,
                    onSelected: (int index) {
                      context
                          .read<BookingBloc>()
                          .add(StatusToggleChanged(index));
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              // You can add filtered list or content below here
              Expanded(
                child: Center(
                  child: Text("Booking list goes here"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


