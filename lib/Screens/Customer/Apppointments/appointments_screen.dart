import 'package:flutter/material.dart';
import 'package:glowup/CustomWidgets/Shared/search_bar.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 96),
          Row(
            children: [
              SizedBox(width: 32),
              CustomSearchBar(
                controller: TextEditingController(),
                hintText: "Search bookings",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
