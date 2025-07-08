import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowup/Repositories/models/appointment.dart';
import 'package:glowup/Styles/app_colors.dart';

class BookingCard extends StatelessWidget {
  final Appointment appointment;

  const BookingCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Service",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 12),
              _InfoRow(
                iconPath: 'assets/svgs/calendar.svg',
                text: appointment.appointmentDate,
              ),
              const SizedBox(height: 8),
              _InfoRow(
                iconPath: 'assets/svgs/clock.svg',
                text: "${appointment.appointmentStart} - ${appointment.appointmentEnd}",
              ),
              const SizedBox(height: 8),
              _InfoRow(
                iconPath: 'assets/svgs/user.svg',
                text: appointment.stylist?.name ?? "Stylist",
              ),
              const SizedBox(height: 8),
              _InfoRow(
                iconPath: 'assets/svgs/salon.svg',
                text: appointment.provider?.name ?? "Salon",
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _StatusBadge(status: appointment.status),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String iconPath;
  final String text;

  const _InfoRow({
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, width: 18, height: 18),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.darkText,
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  Color _getColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.orange;
      case 'confirmed':
        return AppColors.green;
      case 'cancelled':
        return Colors.red;
      case 'paid':
        return AppColors.purple;
      case 'completed':
        return AppColors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: _getColor(status),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
