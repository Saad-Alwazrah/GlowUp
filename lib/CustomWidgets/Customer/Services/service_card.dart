import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:glowup/Repositories/models/services.dart';
import 'package:glowup/Screens/Customer/BookingDetails/booking_details_screen.dart';
import 'package:glowup/Styles/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final Services service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookingDetailsScreen(service: service),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Theme.of(context).cardColor,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image & Overlays
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: service.imageUrl,
                    height: 160,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),

                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: AppColors.goldenPeach,
                      size: 75.h,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.w,
                  left: 8.w,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      service.provider!.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),

            /// Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          softWrap: false,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'SAR ${service.price.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          service.provider!.address ?? "",
                          softWrap: true,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Text(
                    service.provider!.distanceFromUser!,
                    softWrap: true,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
