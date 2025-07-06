import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/CustomWidgets/shared/profile/profile_dialog.dart';
import 'package:glowup/Screens/Provider/Profile/bloc/provider_profile_bloc.dart';
import 'package:glowup/Styles/app_font.dart';

class ProviderProfileScreen extends StatelessWidget {
  const ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderProfileBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<ProviderProfileBloc>();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                SizedBox(height: 120.h),
                CircleAvatar(radius: 58),
                SizedBox(height: 24.h),

                // The provider name
                Text("Khalid Sultan", style: AppFonts.semiBold24),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                              textFieldController: bloc.phoneNumberController,
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
                        leading: Icon(Icons.help),
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
                        leading: Icon(Icons.language),
                        title: Text("Help".tr()),
                      ),
                      Divider(),

                      // Navigate to the Settings Screen
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("Settings".tr()),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: CustomBackgroundContainer(
                                childWidget: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.language),
                                      title: Text("Language".tr()),
                                    ),
                                    Divider(),
                                    ListTile(
                                      leading: Icon(Icons.contrast),
                                      title: Text("Theme".tr()),
                                    ),
                                  ],
                                ),
                                height: 150.h,
                              ),
                            ),
                          );
                        },
                      ),
                      Divider(),

                      // Add the Logout function
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: Text("Logout".tr()),
                      ),
                    ],
                  ),
                  height: 435.h,
                  paddingSize: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
