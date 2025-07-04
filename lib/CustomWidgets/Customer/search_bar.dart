import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowup/CustomWidgets/Customer/filter_pop_up.dart';
import 'package:glowup/Styles/app_colors.dart';


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
    showDialog(
      context: context,
      builder: (context) => const FilterPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 349,
      height: 49,
     
      decoration: BoxDecoration(
      
         color: Theme.of(context).cardColor, 
    borderRadius: BorderRadius.circular(100),
       
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(leftIcon, color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.white
        : AppColors.darkText,),
           SizedBox(width: 8.w),
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
            child: Icon(rightIcon,    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.white
        : AppColors.darkText,
  ),),
          
        ],
      ),
    );
  }
}
