import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/CustomWidgets/shared/profile/profile_dialog.dart';
import 'package:glowup/Screens/Provider/Profile/bloc/provider_profile_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class ProviderProfileScreen extends StatelessWidget {
  ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderProfileBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<ProviderProfileBloc>();
          if (context.locale == Locale("en")) {
                bloc.languageSwitchValue = 1;
              } else {
                bloc.languageSwitchValue = 0;
              }
          return BlocBuilder<ProviderProfileBloc, ProviderProfileState>(
            builder: (context, state) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.backgroundDark,
                            ),
                            width: context.getScreenWidth(size: 1),
                            height: 150.h,
                            child: CachedNetworkImage(
                              imageUrl: "${bloc.provider.bannerUrl}",
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.image, color: AppColors.white),
                            ),
                          ),
                          // Need to be tested
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: -54.h,
                            child: GestureDetector(
                              onTap: () {
                                bloc.add(UpdateProviderAvatarEvent());
                              },
                              child: CircleAvatar(
                                radius: 58,
                                child: CachedNetworkImage(
                                  imageUrl: "${bloc.provider.avatarUrl}",
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.person,
                                    color: AppColors.white,
                                    size: 80.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  
                      SizedBox(height: 72.h),
                  
                      // The provider name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(),
                          Container(
                            decoration: BoxDecoration(color: Colors.amber),
                            child: Text(
                              bloc.provider.name,
                              style: AppFonts.semiBold24,
                            ),
                          ),
                          Row(
                            children: [
                              Text("${bloc.provider.avgRating}"),
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade600,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Divider(color: Colors.amber),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text("Number".tr()),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ProfileDialog(
                                    containerHeight: 200,
                                    formKey: bloc.phoneNumberKey,
                                    textFieldController:
                                        bloc.phoneNumberController,
                                    controllerValidation: (value) =>
                                        bloc.phoneValidation(text: value),
                                    textFieldHint: "New Phone Number",
                                    submitMethod: bloc.validationMethod,
                                  ),
                                );
                              },
                            ),
                            Divider(),
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
                                onChanged: (_) => bloc.add(ThemeSwitchToggleEvent()),
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
                        height: 520.h,
                        paddingSize: false,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
