import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_dimensions.dart';

class BrandPill extends StatelessWidget {
  final bool isDarkMode;

  const BrandPill({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.pillWidth,
      height: AppDimensions.pillHeight,
      decoration: BoxDecoration(
        gradient: AppColors.pillGradient,
        borderRadius: BorderRadius.circular(AppDimensions.pillRadius),
      ),
      child: const Center(
        child: Text(
          AppStrings.fullBrandName,
          style: TextStyle(
            color: AppColors.white,
            fontSize: AppDimensions.pillFontSize,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.3,
          ),
        ),
      ),
    );
  }
}
