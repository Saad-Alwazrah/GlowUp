import 'package:flutter/material.dart';
import 'package:glowup/CustomWidgets/Shared/filter_pop_up.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final IconData leftIcon;
  final IconData rightIcon;
  final String hintText;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.leftIcon = Icons.search,
    this.rightIcon = Icons.tune_outlined,
    this.hintText = "Search",
  });

  void _showFilterDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const FilterPopup());
  }

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
              onChanged: (value) {
                // Search logic goes here
              },
            ),
          ),
          GestureDetector(
            onTap: () => _showFilterDialog(context),
            child: Icon(rightIcon, color: Color(0xFF2E2E2E)),
          ),
        ],
      ),
    );
  }
}
