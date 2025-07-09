import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Shared/booking_card.dart';
import 'package:glowup/CustomWidgets/shared/status_toggle.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_bloc.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc()..add(UpdateUIEvent()),
      child: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          final bloc = context.read<BookingBloc>();
          final userAppointments = bloc.supabase.getUserAppointments();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),

                    StatusToggle(
                      selectedIndex: bloc.selectedIndex,
                      onSelected: (int index) {
                        context.read<BookingBloc>().add(
                          StatusToggleEvent(index),
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    // You can add filtered list or content below here
                    ...List.generate(
                      userAppointments[bloc.selectedIndex]!.length,
                      (i) {
                        final appointment =
                            userAppointments[bloc.selectedIndex]![i];
                        return BookingCard(appointment: appointment);
                      },
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
