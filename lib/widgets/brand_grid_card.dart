// FILE PATH: lib/widgets/brand_grid_card.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class BrandGridCard extends StatelessWidget {
  final String brandName;
  final String discount;
  final Color brandColor;
  final VoidCallback? onTap;

  const BrandGridCard({
    Key? key,
    required this.brandName,
    required this.discount,
    required this.brandColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: brandColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                brandName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              discount,
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
