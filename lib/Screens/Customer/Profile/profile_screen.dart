import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/CustomWidgets/shared/profile/profile_dialog.dart';
import 'package:glowup/Screens/Customer/Profile/bloc/profile_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
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
              if (context.locale == Locale("en")) {
                bloc.languageSwitchValue = 1;
              } else {
                bloc.languageSwitchValue = 0;
              }
              return Column(
                children: [
                  SizedBox(height: 100.h),
                  GestureDetector(
                    onTap: () {
                      bloc.add(UpdateUserAvatar());
                    },
                    child: ClipOval(
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: bloc.supabase.userProfile?.avatarUrl ?? '',
                        height: 120.h,
                        width: 120.w,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.softBrown,
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            "assets/images/profile.png",
                            height: 120.h,
                            width: 120.w,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomBackgroundContainer(
                    childWidget: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.badge_outlined),
                          title: Text("Name".tr()),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ProfileDialog(
                                containerHeight: 200,
                                formKey: bloc.usernameKey,
                                textFieldController: bloc.usernameController,
                                controllerValidation: (value) =>
                                    bloc.userNameValidation(text: value),
                                textFieldHint: "New Username",
                                submitMethod: bloc.validationMethod,
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(color: Colors.amber),
                        ),
                        ListTile(
                          leading: Icon(Icons.email_outlined),
                          title: Text("Email".tr()),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ProfileDialog(
                                containerHeight: 200,
                                formKey: bloc.emailKey,
                                textFieldController: bloc.emailController,
                                controllerValidation: (value) =>
                                    bloc.emailValidation(text: value),
                                textFieldHint: "New Email",
                                submitMethod: bloc.validationMethod,
                              ),
                            );
                          },
                        ),
                        Divider(),
                        // Navigate to Help Screen
                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text("Help".tr()),
                        ),
                        Divider(),

                        // Navigate to the Settings Screen
                        ListTile(
                          leading: Icon(Icons.language),
                          title: Text("Language".tr()),
                          trailing: AnimatedToggleSwitch<int>.size(
                            height: 40,
                            current: bloc.languageSwitchValue,
                            values: [0, 1],
                            style: ToggleStyle(
                              borderColor: AppColors.goldenPeach,
                              backgroundColor: AppColors.background,
                              indicatorColor: AppColors.goldenPeach,
                            ),

                            iconList: [
                              Text(
                                "العربية",
                                style: AppFonts.regular14.copyWith(
                                  fontSize: 10,
                                  color: bloc.languageSwitchValue == 0
                                      ? AppColors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                "English",
                                style: AppFonts.regular14.copyWith(
                                  fontSize: 10,
                                  color: bloc.languageSwitchValue == 1
                                      ? AppColors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                            onChanged: (_) {
                              if (context.locale == Locale("en")) {
                                context.setLocale(Locale("ar"));
                              } else {
                                context.setLocale(Locale("en"));
                              }
                              bloc.add(LanguageSwitchToggleEvent());
                            },
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.contrast),
                          title: Text("Theme".tr()),
                          trailing: AnimatedToggleSwitch.size(
                            height: 40,
                            current: bloc.themeSwitchValue,
                            values: [0, 1],
                            style: ToggleStyle(
                              borderColor: AppColors.goldenPeach,
                              backgroundColor: AppColors.background,
                              indicatorColor: AppColors.goldenPeach,
                            ),
                            iconList: [
                              Icon(
                                Icons.light_mode,
                                color: bloc.themeSwitchValue == 0
                                    ? Colors.yellow.shade700
                                    : Colors.black,
                              ),
                              Icon(
                                Icons.dark_mode,
                                color: bloc.themeSwitchValue == 1
                                    ? AppColors.white
                                    : Colors.black,
                              ),
                            ],
                            onChanged: (_) =>
                                bloc.add(ThemeSwitchToggleEvent()),
                          ),
                        ),
                        Divider(),

                        // Add the Logout function
                        ListTile(
                          leading: Icon(Icons.logout, color: Colors.red),
                          title: Text("Logout".tr()),
                          onTap: () {
                            bloc.supabase.signOut();
                            bloc.add(UpdateUIEvent());
                          },
                        ),
                      ],
                    ),
                    height: 450.h,
                    paddingSize: false,
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
