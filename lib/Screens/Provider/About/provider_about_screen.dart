import 'package:flutter/material.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class ProviderAboutScreen extends StatelessWidget {
  const ProviderAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("About GlowUp",     style: AppFonts.semiBold24.copyWith(color: Colors.black),),
        backgroundColor: AppColors.background,
        elevation: 0, // remove shadow
        surfaceTintColor: Colors.transparent, // prevent Material3 overlay
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("GlowUp — Your All-in-One Booking Partner", style: AppFonts.medium18),
            SizedBox(height: 16),
            Text(
              "GlowUp helps salons and beauty professionals reach more customers, manage appointments efficiently, and grow their business — all from one platform.",
              style: AppFonts.light16,
            ),
            SizedBox(height: 24),
            Text("Why Join GlowUp?", style: AppFonts.medium18),
            SizedBox(height: 12),
            _bullet("List your services for free"),
            _bullet("Get discovered by local clients"),
            _bullet("Receive and manage bookings in real-time"),
            _bullet("Flexible calendar and time slot management"),
            _bullet("Build trust through ratings & reviews"),
            SizedBox(height: 24),
            Text("Questions? Contact us at support@glowup.com", style: AppFonts.light16),
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 20)),
          Expanded(child: Text(text, style: AppFonts.light16)),
        ],
      ),
    );
  }
}


