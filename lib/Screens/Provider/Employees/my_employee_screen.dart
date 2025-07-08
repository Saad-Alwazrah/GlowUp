import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Provider/Employees/employee_container.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Screens/Provider/EmployeeDetails/employee_details.dart';
import 'package:glowup/Screens/Provider/Employees/bloc/employee_bloc.dart';
import 'package:glowup/Screens/Provider/Profile/bloc/provider_profile_bloc.dart';
import 'package:glowup/Screens/Provider/Profile/provider_profile_screen.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class MyEmployeeScreen extends StatelessWidget {
  const MyEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final bloc = context.read<ProviderProfileBloc>();
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 48.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProviderProfileScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_back, color: AppColors.goldenPeach),
                  ),
                ),
                Text(context.tr("My Employees") , style: AppFonts.semiBold24),
                SizedBox(height: 48.h),
                CustomElevatedButton(
                  text: context.tr("+  Add new employee") ,
                  onTap: () {},
                ), // Need to add the function

                SizedBox(height: 24.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: context.getScreenWidth(size: 1),
                    height: context.getScreenHeight(size: 0.6.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: bloc.provider.stylists.length,
                      itemBuilder: (context, index) {
                        return EmployeeContainer(
                          employeeName: context.tr(bloc.provider.stylists[index].name) ,
                          employeeRating:
                              bloc.provider.stylists[index].avgRating,
                          containerMethod: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EmployeeDetails(stylist: bloc.provider.stylists[index]),
                            ),
                          ), // Need to make the transition good
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
