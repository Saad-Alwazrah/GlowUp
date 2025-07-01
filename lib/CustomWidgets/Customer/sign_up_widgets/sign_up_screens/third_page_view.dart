import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/Screens/Shared/Login/login_screen.dart';
import 'package:glowup/Styles/app_font.dart';

class ThirdPageView extends StatelessWidget {
  const ThirdPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Center(
          child: Text(
            "Your account have been created Please check you email to confirm it"
                .tr(),
            style: AppFonts.medium18,
          ),
        ),

        CustomElevatedButton(
          text: "Go to Login".tr(),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ],
    );
  }
}
