import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/booking_cards.dart';
import 'package:glowup/CustomWidgets/Customer/search_bar.dart';
import 'package:glowup/CustomWidgets/Customer/segment_toggle.dart';
import 'package:glowup/Repositories/models/appointment.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_bloc.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_event.dart';
import 'package:glowup/Screens/Customer/BookingsScreen/bloc/booking_state.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Appointments
    final List<Appointment> allAppointments = [
      Appointment(
        id: 1,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "pending",
        atHome: false,
        bookedAt: "2025-07-01T12:00:00Z",
      ),
      Appointment(
        id: 2,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "cancel",
        atHome: true,
        bookedAt: "2025-07-01T12:00:00Z",
      ),
      Appointment(
        id: 3,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "paid",
        atHome: true,
        bookedAt: "2025-07-01T12:00:00Z",
      ),
      Appointment(
        id: 4,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "completed",
        atHome: true,
        bookedAt: "2025-07-01T12:00:00Z",
      ),
       Appointment(
        id: 5,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "completed",
        atHome: true,
        bookedAt: "2025-07-01T12:00:00Z",
      ),
         Appointment(
        id: 6,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "completed",
        atHome: true,
        bookedAt: "2025-07-01T12:00:00Z",
      ),
         Appointment(
        id: 7,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "completed",
        atHome: true,
        bookedAt: "2025-07-01T12:00:00Z",
      ),
        Appointment(
        id: 8,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "completed",
        atHome: true,
        bookedAt: "2025-07-01T12:00:00Z",
      ),
       Appointment(
        id: 9,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "completed",
        atHome: true,
        bookedAt: "2025-07-01T12:00:00Z",
      ), Appointment(
        id: 10,
        customerId: '1',
        providerId: '1',
        stylistId: '1',
        serviceId: 1,
        appointmentDate: "2025-07-04",
        appointmentStart: "4:00 PM",
        appointmentEnd: "5:00 PM",
        status: "completed",
        atHome: true,
        bookedAt: "2025-07-01T12:00:00Z",
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: ListView(
           
            children: [
              // Search bar
             CustomSearchBar(
                controller: TextEditingController(),
                hintText: "Search bookings".tr(),
              ),
              const SizedBox(height: 24),
              BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  final tabs = [
                    "Pending".tr(),
                    "Status".tr(),
                    "Paid".tr(),
                    "Completed".tr()
                  ];

                  String getFilter(int index) {
                    switch (index) {
                      case 0:
                        return 'pending';
                      case 1:
                        return 'cancel';
                      case 2:
                        return 'paid';
                      case 3:
                        return 'completed';
                      default:
                        return '';
                    }
                  }

                  final filteredAppointments = allAppointments
                      .where((a) => a.status == getFilter(state.selectedIndex))
                      .toList();

                  return Column(
                    children: [
                      SegmentedToggle(
                        selectedIndex: state.selectedIndex,
                        tabs: tabs,
                        onTabSelected: (index) {
                          context.read<BookingBloc>().add(ChangeBookingTab(index));
                        },
                      ),
                    SizedBox(height: 24.h),
                      if (filteredAppointments.isEmpty)
                        Text("No bookings found.".tr()),
                      ...filteredAppointments.map(
                        (appointment) => BookingCard(appointment: appointment),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


