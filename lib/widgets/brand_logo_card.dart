import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class BrandLogoCard extends StatelessWidget {
  final String assetPath;
  final String name;
  final VoidCallback? onTap;

  const BrandLogoCard({
    Key? key,
    required this.assetPath,
    required this.name,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fixed square card so all logos align perfectly in a horizontal list
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.04)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(assetPath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 64,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.secondaryText,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
