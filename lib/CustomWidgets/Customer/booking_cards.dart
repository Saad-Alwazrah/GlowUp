import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Repositories/models/appointment.dart';

class BookingCard extends StatelessWidget {
  final Appointment appointment;

  const BookingCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final serviceName = appointment.service?.name ?? "Service";
    final stylistName = appointment.stylist?.name ?? "Stylist";
    final providerName = appointment.provider?.name ?? "Salon";
    final atHome = appointment.atHome ? "At Home" : "In Salon";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
     color: Theme.of(context).cardColor,

        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service name
          Text(
            serviceName,
            style: Theme.of(context).textTheme.bodyLarge,

          ),

          SizedBox(height: 8.h),

          // Date + Time
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(appointment.appointmentDate,   style: Theme.of(context).textTheme.bodyLarge,),
                ],
              ),
            SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
               SizedBox(width: 10.w),
                  Text("${appointment.appointmentStart} - ${appointment.appointmentEnd}",   style: Theme.of(context).textTheme.bodyLarge,),
                ],
              ),
            ],
          ),

       SizedBox(height: 4.h),

          // Stylist
          Row(
            children: [
              const Icon(Icons.person, size: 16, color: Colors.grey),
              const SizedBox(width: 10),
              Text(stylistName,   style: Theme.of(context).textTheme.bodyLarge,),
            ],
          ),

        SizedBox(height: 4.h),

          // Provider + Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.store, size: 16, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text(providerName,   style: Theme.of(context).textTheme.bodyLarge,),
                ],
              ),
              Container(
                width: 80.w,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: _statusColor(appointment.status),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  appointment.status.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      case 'paid':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

