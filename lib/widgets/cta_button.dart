import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_dimensions.dart';

class CTAButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDarkMode;

  const CTAButton({
    Key? key,
    required this.onPressed,
    required this.isLoading,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<CTAButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth - (AppDimensions.horizontalMargin * 2);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: buttonWidth,
        height: AppDimensions.buttonHeight,
        decoration: BoxDecoration(
          color: _isPressed 
              ? AppColors.buttonPressed 
              : AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: widget.isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  AppStrings.ctaButton,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppDimensions.buttonFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
