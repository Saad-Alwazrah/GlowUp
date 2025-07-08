import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Screens/Provider/EmployeeDetails/bloc/employee_details_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeDetailsBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<EmployeeDetailsBloc>();
          return Scaffold(
            // The Image of the Provider in the background of the AppBar
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
              ],
            ),
          );
        },
      ),
    );
  }
}
