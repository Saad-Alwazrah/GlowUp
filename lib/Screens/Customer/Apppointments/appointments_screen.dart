import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                hintText: "Search bookings".tr(),
                onChanged: (value) {
                  // Implement search functionality here
                },
              ),

              SizedBox(height: 48.h,),

              Container(child: Column(
                children: [ListTile(leading: Text("sa"),)],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
