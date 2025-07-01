import 'package:flutter/material.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class BackgroundContainer extends StatelessWidget {
  final double heightSize;
  final Widget childWidget;
  const BackgroundContainer({
    super.key,
    required this.childWidget,
    required this.heightSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
        ),
        height: context.getScreenHeight(size: heightSize),
        width: context.getScreenWidth(size: 1),
        child: childWidget,
      ),
    );
  }
}
