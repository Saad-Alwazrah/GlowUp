import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:glowup/Screens/Customer/Profile/bloc/profile_bloc.dart';
import 'package:glowup/Screens/Customer/Profile/bloc/profile_state.dart';
import 'package:glowup/Styles/Theme/bloc/theme_bloc.dart';
import 'package:glowup/Styles/Theme/bloc/theme_event.dart';
import 'package:glowup/Styles/Theme/bloc/theme_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            final profile = state.profile;

            return Column(
              children: [
               SizedBox(height: 100.h),
                Row(
                  children: [
                   SizedBox(width: 150.w),
                    Image.asset("assets/images/profile.png"),
                  ],
                ),
               SizedBox(height: 20.h),
                Container(
                  width: 324.w,
                  height: 560.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildItem(context, "assets/svgs/badge_name.svg", profile.fullName),
                        _divider(context),
                        _buildItem(context, "assets/svgs/phone_number.svg", profile.phone ?? "Number".tr()),
                        _divider(context),
                        _buildItem(context, "assets/svgs/email.svg", profile.username ?? "Email".tr()),
                        _divider(context),
                        _buildClickableItem(
                          context: context,
                          icon: "assets/svgs/help.svg",
                          label: "Help".tr(),
                          onTap: () => Navigator.pushNamed(context, '/help'),
                        ),
                        _divider(context),
                        _buildClickableItem(
                          context: context,
                          icon: "assets/svgs/language.svg",
                          label: "Language".tr(),
                          onTap: () {
                            final current = context.locale.languageCode;
                            final newLocale = current == 'en' ? const Locale('ar') : const Locale('en');
                            context.setLocale(newLocale);
                          },
                        ),
                        _divider(context),
                        _buildClickableItem(
                          context: context,
                          icon: "assets/svgs/settings.svg",
                          label: "Settings".tr(),
                          onTap: () => Navigator.pushNamed(context, '/settings'),
                        ),
                        _divider(context),
                        BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, themeState) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/svgs/contrast.svg",  colorFilter: ColorFilter.mode(
    Theme.of(context).textTheme.bodyLarge!.color!,
    BlendMode.srcIn,
  ),),
                                SizedBox(width: 20.w),
                                  Expanded(
                                    child: Text(
                                      "dark_mode".tr(),
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  Switch(
                                    value: themeState.themeMode == ThemeMode.dark,
                                    onChanged: (isDark) {
                                      context.read<ThemeBloc>().add(ToggleThemeEvent(isDark));
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        _divider(context),
                        _buildClickableItem(
                          context: context,
                          icon: "assets/svgs/logout.svg",
                          label: "Log out".tr(),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Log out".tr())),
                            );
                          },
                        ),
                         SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, String iconPath, String text) {
    return Row(
      children: [
      SizedBox(width: 20.w),
        SvgPicture.asset(iconPath, colorFilter: ColorFilter.mode(
    Theme.of(context).textTheme.bodyLarge!.color!,
    BlendMode.srcIn,),),
   SizedBox(width: 20.w),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
     
      ],
    );
  }

  Widget _buildClickableItem({
    required BuildContext context,
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
         SizedBox(width: 20.w),
          SvgPicture.asset(icon,
  colorFilter: ColorFilter.mode(
    Theme.of(context).textTheme.bodyLarge!.color!,
    BlendMode.srcIn,
  ),
),
          SizedBox(width: 20.w),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: 1.h,
        width: 297.w,
        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.08),
      ),
    );
  }
}


