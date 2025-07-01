import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:glowup/CustomWidgets/shared/custom_textfield.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class SecondPageView extends StatelessWidget {
  GlobalKey<FormState> formKey;
  final TextEditingController controller;

  String? Function(String?) addressValidation;
  void Function() pressedMethod;

  SecondPageView({
    super.key,
    required this.controller,
    required this.addressValidation,
    required this.pressedMethod,
    required this.formKey
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        // Relpace the placeholder with googleMap instance

        // The size of the instance
        Container(
          width: context.getScreenWidth(size: 0.8),
          height: 72,
          decoration: BoxDecoration(color: AppColors.goldenPeachDark),
          child: Placeholder(),
        ),
        Form(
          key: formKey,
          child: CustomTextfield(
            textFieldHint: "Public Address".tr(),
            textFieldcontroller: controller,
            validationMethod: addressValidation,
          ),
        ),
        CustomElevatedButton(text: "Sign Up", onTap: pressedMethod),
      ],
    );
  }
}
