import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';

class GameCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final Color backgroundColor;
  final String emoji;
  final VoidCallback? onTap;

  const GameCard({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.backgroundColor,
    required this.emoji,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardWidth = ResponsiveHelper.getResponsiveWidth(context, 42);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: 160, // FIXED: Added explicit height instead of using Spacer
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 12),
            Flexible( // FIXED: Changed from fixed text to Flexible
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12), // FIXED: Replaced Spacer with fixed spacing
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$buttonText >',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: backgroundColor,
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
