import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/Screens/Provider/Employees/bloc/employee_bloc.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Styles/app_font.dart';

class MyEmployeeScreen extends StatelessWidget {
  const MyEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<EmployeeBloc>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.background,
              actions: [BackButton(color: AppColors.goldenPeach)],
            ),
            body: Column(
              children: [
                Text("My Employees", style: AppFonts.semiBold24),
                SizedBox(height: 48.h),
                CustomElevatedButton(
                  text: "+   Add new employee",
                  onTap: () {},
                ), // Need to add the function
                CustomBackgroundContainer(
                  childWidget: Column(
                    children: [
                      // Replace it with a Listview Builder from the database
                      ListTile(
                        leading: Text("Employee Rating"),
                        title: Text("Employee Name"),
                        trailing: Icon(
                          Icons.delete_outline,
                          color: AppColors.goldenPeach,
                        ),
                      ),
                    ],
                  ),
                  height: 200,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
