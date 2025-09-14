import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_dimensions.dart';

class HeadlineText extends StatelessWidget {
  final bool isDarkMode;

  const HeadlineText({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.headline,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.white, // Always white for both themes
        fontSize: AppDimensions.headlineFontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: AppDimensions.headlineLetterSpacing,
        height: AppDimensions.headlineLineHeight / AppDimensions.headlineFontSize,
      ),
    );
  }
}
