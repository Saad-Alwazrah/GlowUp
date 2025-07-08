import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Provider/Services/provider_service_card.dart';
import 'package:glowup/Screens/Provider/Services/bloc/provider_services_bloc.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class ProviderServicesScreen extends StatelessWidget {
  const ProviderServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderServicesBloc(),
      child: BlocBuilder<ProviderServicesBloc, ProviderServicesState>(
        builder: (context, state) {
          log("entered ProviderServicesScreen");
          final bloc = context.read<ProviderServicesBloc>();
          final services = bloc.supabase.theProvider?.services ?? [];
          log("services length: ${services.length}");
          return Scaffold(
            body: Column(
              children: [
                if (services.isNotEmpty)
                  SizedBox(
                    height: context.getScreenHeight(size: 0.6.h),
                    width: context.getScreenWidth(size: 1.w),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return ProviderServiceCard(service: service);
                      },
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
