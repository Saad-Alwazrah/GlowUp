import 'package:flutter/material.dart';
import 'package:glowup/Styles/app_font.dart';

class OntapText extends StatelessWidget {
  String text;
  void Function()? pressedMethod;
  OntapText({super.key, required this.text, required this.pressedMethod});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: pressedMethod,
      child: Text(text, style: AppFonts.italic16),
    );
  }
}
