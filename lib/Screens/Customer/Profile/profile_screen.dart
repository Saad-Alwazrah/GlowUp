import 'package:flutter/material.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowup/Styles/app_font.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Row(
            children: [
              SizedBox(width: 140),
              Image.asset("assets/images/profile.png"),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: 324,
            height: 520,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    SvgPicture.asset('assets/svgs/badge_name.svg'),
                    SizedBox(width: 20),
                    Text("Name", style: AppFonts.light16),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  width: 297,
                  color: AppColors.darkText.withValues(alpha: 0.08),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    SvgPicture.asset("assets/svgs/phone_number.svg"),
                    SizedBox(width: 20),
                    Text("Phone", style: AppFonts.light16),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  width: 297,
                  color: AppColors.darkText.withValues(alpha: 0.08),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    SvgPicture.asset("assets/svgs/email.svg"),
                    SizedBox(width: 20),
                    Text("Email", style: AppFonts.light16),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  width: 297,
                  color: AppColors.darkText.withValues(alpha: 0.08),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    SvgPicture.asset("assets/svgs/help.svg"),
                    SizedBox(width: 20),
                    Text("Help", style: AppFonts.light16),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  width: 297,
                  color: AppColors.darkText.withValues(alpha: 0.08),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    SvgPicture.asset("assets/svgs/language.svg"),
                    SizedBox(width: 20),
                    Text("Language", style: AppFonts.light16),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  width: 297,
                  color: AppColors.darkText.withValues(alpha: 0.08),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    SvgPicture.asset("assets/svgs/settings.svg"),
                    SizedBox(width: 20),
                    Text("Settings", style: AppFonts.light16),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  width: 297,
                  color: AppColors.darkText.withValues(alpha: 0.08),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    SvgPicture.asset("assets/svgs/contrast.svg"),
                    SizedBox(width: 20),
                    Text("Dark mode", style: AppFonts.light16),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  width: 297,
                  color: AppColors.darkText.withValues(alpha: 0.08),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20),
                    SvgPicture.asset("assets/svgs/logout.svg"),
                    SizedBox(width: 20),
                    Text("Log out", style: AppFonts.light16),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
