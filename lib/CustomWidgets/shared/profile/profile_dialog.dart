import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/CustomWidgets/shared/custom_textfield.dart';
import 'package:glowup/Styles/app_colors.dart';

class ProfileDialog extends StatelessWidget {
  GlobalKey<FormState> formKey;
  final TextEditingController textFieldController;
  String? Function(String?) controllerValidation;
  String textFieldHint;
  final Function submitMethod;
  final double containerHeight;


  ProfileDialog({
    super.key,
    required this.formKey,
    required this.textFieldController,
    required this.controllerValidation,
    required this.textFieldHint,
    required this.submitMethod,
    required this.containerHeight
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(15)),
        height: containerHeight.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(
              key: formKey,
              child: CustomTextfield(
                initialText: "Khalid Sultan", //User profile name from the database  
                textFieldHint: textFieldHint,
                textFieldcontroller: textFieldController,
                validationMethod: controllerValidation,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
              child: CustomElevatedButton(text: "Submit", onTap:() {submitMethod(formKey);}),
            )
          ],
        ),
      ),
    );
  }
}
