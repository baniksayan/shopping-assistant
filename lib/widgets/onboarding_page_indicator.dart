// FILE PATH: lib/widgets/onboarding_page_indicator.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const OnboardingPageIndicator({
    Key? key,
    required this.pageCount,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) => _buildDot(index)),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.indicatorSpacing / 2),
      height: AppDimensions.indicatorSize,
      width: currentPage == index ? AppDimensions.indicatorSize * 2.5 : AppDimensions.indicatorSize,
      decoration: BoxDecoration(
        color: currentPage == index ? AppColors.indicatorActive : AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(AppDimensions.indicatorSize / 2),
      ),
    );
  }
}
