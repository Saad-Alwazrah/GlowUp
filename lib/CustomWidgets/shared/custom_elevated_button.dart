import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  Widget icon = const SizedBox.shrink();
  double radius;

  CustomElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon = const SizedBox.shrink(),
    this.radius = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  360.w,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.goldenPeach,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 4.w),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
