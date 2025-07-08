import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Customer/Services/service_card.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Styles/app_colors.dart';
import 'package:glowup/Utilities/extensions/screen_size.dart';

class ProviderCard extends StatelessWidget {
  const ProviderCard({super.key, required this.provider});
  final Provider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 310.h,
          width: context.getScreenWidth(size: 1.w),
          child: ListView.builder(
            itemCount: provider.services.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 310.h,
                width: 230.w,
                child: ServiceCard(service: provider.services[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
