import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Screens/Customer/Profile/bloc/profile_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowup/Styles/app_font.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (listenerContext, state) {
          final bloc = listenerContext.read<ProfileBloc>();
          if (state is UserLoggedOut) {
            Navigator.pushReplacementNamed(context, '/onboarding');
          }
          if (state is LogOutError) {
            ScaffoldMessenger.of(
              listenerContext,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is UserAvatarUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Avatar updated successfully!")),
            );
            bloc.add(LoadProfileAvatar());
          }
          if (state is UpdateAvatarError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final bloc = context.read<ProfileBloc>();

              return Column(
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
                      GestureDetector(
  onTap: () {
    Navigator.pushNamed(context, '/help');
  },
  child: Row(
    children: [
      SizedBox(width: 20),
      SvgPicture.asset("assets/svgs/help.svg"),
      SizedBox(width: 20),
      Text("Help", style: AppFonts.light16),
    ],
  ),
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
                          width: 297.w,
                          color: AppColors.darkText.withValues(alpha: 0.08),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => bloc.add(LogOutUser()),
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              SvgPicture.asset("assets/svgs/logout.svg"),
                              SizedBox(width: 20),
                              Text("Log out", style: AppFonts.light16),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
