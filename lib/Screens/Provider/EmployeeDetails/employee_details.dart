import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Shared/custom_elevated_button.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/Repositories/models/stylist.dart';
import 'package:glowup/Screens/Provider/EmployeeDetails/bloc/employee_details_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class EmployeeDetails extends StatelessWidget {
  final Stylist stylist;
  const EmployeeDetails({super.key, required this.stylist});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeDetailsBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<EmployeeDetailsBloc>();
          return Scaffold(
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: AppColors.backgroundDark),
                  width: context.getScreenWidth(size: 1),
                  height: 150.h,
                  child: CachedNetworkImage(
                    imageUrl: "${bloc.provider.bannerUrl}",
                    errorWidget: (context, url, error) =>
                        Icon(Icons.image, color: AppColors.white),
                  ),
                ),
                SizedBox(height: 64.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 120.w),
                    Text(stylist.name, style: AppFonts.semiBold24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          stylist.avgRating == null
                              ? Text("No Rating".tr())
                              : Text("${stylist.avgRating}"),
                          Icon(Icons.star, color: Colors.yellow.shade600),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 48.h),

                CustomBackgroundContainer(
                  childWidget: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(stylist.bio!, style: AppFonts.medium18),
                  ),
                  height: 150,
                ),

                // CustomCalendar(stylist: stylist, onDaySelected: onDaySelected, currentDay: currentDay)
                CustomElevatedButton(
                  text: "Edit ",
                  onTap: () {},
                ), // Editing the schedule
              ],
            ),
          );
        },
      ),
    );
  }
}
