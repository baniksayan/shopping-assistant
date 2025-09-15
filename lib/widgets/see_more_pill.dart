import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SeeMorePill extends StatelessWidget {
  final VoidCallback onTap;
  const SeeMorePill({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(32),
        ),
        child: const Icon(Icons.arrow_forward_ios, color: AppColors.primaryText, size: 20),
      ),
    );
  }
}
