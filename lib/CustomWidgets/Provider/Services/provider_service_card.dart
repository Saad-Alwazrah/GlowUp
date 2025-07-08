import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Styles/app_colors.dart';

class ProviderServiceCard extends StatelessWidget {
  const ProviderServiceCard({super.key, required this.service});
  final Services service;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178.h,
      width: 398.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: service.imageUrl,
            fit: BoxFit.cover,
            width: 140.w,
            height: 140.h,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error, color: AppColors.goldenPeach),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                service.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(service.price.toStringAsFixed(0)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_outlined, color: AppColors.goldenPeach),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
