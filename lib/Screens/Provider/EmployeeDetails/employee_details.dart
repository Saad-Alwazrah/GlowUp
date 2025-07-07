import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowup/Screens/Provider/EmployeeDetails/bloc/employee_details_bloc.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeDetailsBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<EmployeeDetails>();
          return Scaffold(
             // The Image of the Provider in the background of the AppBar
            body: Column(

            ),
          );
        },
      ),
    );
  }
}
