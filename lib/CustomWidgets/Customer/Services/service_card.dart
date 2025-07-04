import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Repositories/models/appointment.dart';

class BookingCard extends StatelessWidget {
  final Appointment appointment;

  const BookingCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final serviceName = appointment.service?.name ?? "Service".tr();
    final stylistName = appointment.stylist?.name ?? "Stylist".tr();
    final providerName = appointment.provider?.name ?? "Salon".tr();
    final atHome = appointment.atHome ? "At Home".tr() : "In Salon".tr();

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
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
  fontWeight: FontWeight.w600,
),

          ),
         SizedBox(height: 8.h),

          // Date + Time
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                   SizedBox(width: 10.w),
                  Text(appointment.appointmentDate),
                ],
              ),
             SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 10),
                  Text("${appointment.appointmentStart} - ${appointment.appointmentEnd}"),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // Stylist & Provider
          Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  SizedBox(width: 10.w),
                  Text(stylistName),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  const Icon(Icons.store, size: 16, color: Colors.grey),
                SizedBox(width: 10.w),
                  Text(providerName),
                  const Spacer(),
                  Container(
                    width: 80.w,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: _statusColor(appointment.status),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      appointment.status.tr(), // TRANSLATED STATUS
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
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


