import 'package:flutter/material.dart';
import 'package:glowup/Styles/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  bool isPassword;
  final TextEditingController textFieldcontroller;
  final String textFieldHint;
  final String? Function(String?) validationMethod;

  CustomTextfield({
    super.key,
    required this.textFieldHint,
    required this.textFieldcontroller,
    this.isPassword = false,
    required this.validationMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: TextFormField(
        controller: textFieldcontroller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightTextDark,
          hintText: textFieldHint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        ),
        obscureText: isPassword,
        obscuringCharacter: "*",
        onTapOutside: (event) =>
            FocusScope.of(context).requestFocus(FocusNode()),
        validator: validationMethod,
      ),
    );
  }
}
