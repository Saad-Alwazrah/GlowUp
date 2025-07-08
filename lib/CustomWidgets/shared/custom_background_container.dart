import 'package:flutter/material.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class CustomBackgroundContainer extends StatelessWidget {
  // to choose either Padding1 or Padding2
  bool paddingSize;

  double height;
  Widget childWidget;
  CustomBackgroundContainer({
    super.key,
    required this.childWidget,
    required this.height,
    this.paddingSize = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingSize
          ? EdgeInsets.symmetric(horizontal: 16)
          : EdgeInsetsGeometry.symmetric(horizontal: 36),
      child: Container(
        width: context.getScreenWidth(size: 1),
        height: height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: childWidget,
      ),
    );
  }
}
