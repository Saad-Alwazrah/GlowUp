import 'package:flutter/material.dart';
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
      width: 360,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFFDFA878),
          foregroundColor: Colors.white,
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
