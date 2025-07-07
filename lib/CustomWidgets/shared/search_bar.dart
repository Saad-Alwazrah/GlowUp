import 'package:flutter/material.dart';
import 'package:glowup/CustomWidgets/Shared/filter_pop_up.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final IconData leftIcon;
  final String hintText;
  final void Function(String)? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.leftIcon = Icons.search,
    this.hintText = "Search",
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 349,
      height: 49,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(leftIcon, color: Color(0xFF2E2E2E)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
