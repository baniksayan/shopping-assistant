// FILE PATH: lib/widgets/onboarding_page_view.dart

import 'package:flutter/material.dart';
import '../models/onboarding_content.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'placeholder_image.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingContent content;
  final Color pillColor;

  const OnboardingPageView({
    Key? key,
    required this.content,
    required this.pillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image Placeholder
        AspectRatio(
          aspectRatio: AppDimensions.imageAspectRatio,
          child: PlaceholderImage(imagePath: content.image),
        ),
        const SizedBox(height: 30),

        // Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: pillColor,
            borderRadius: BorderRadius.circular(AppDimensions.pillRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                content.pillIcon,
                color: AppColors.primaryText,
                size: AppDimensions.pillIconSize,
              ),
              const SizedBox(width: 8),
              Text(
                content.pillText,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: AppDimensions.pillFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Headline
        Text(
          content.headline,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: AppDimensions.headlineFontSize,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
