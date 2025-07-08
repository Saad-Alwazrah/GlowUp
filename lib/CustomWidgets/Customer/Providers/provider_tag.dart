import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glowup/Repositories/models/provider.dart';
import 'package:glowup/Styles/app_colors.dart';

class ProviderTag extends StatelessWidget {
  const ProviderTag({super.key, required this.theProvider});
  final Provider theProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: theProvider.avatarUrl ?? "",
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: AppColors.goldenPeach),
          ),
        ],
      ),
    );
  }
}
