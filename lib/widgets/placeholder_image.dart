// FILE PATH: lib/widgets/placeholder_image.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PlaceholderImage extends StatelessWidget {
  final String imagePath;
  const PlaceholderImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // In a real app, you would use Image.asset(imagePath)
    // For now, we use a styled container as a placeholder.
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade800, width: 1.5),
      ),
      child: Center(
        child: Text(
          'Image for:\n${imagePath.split('/').last.replaceAll('.png', '')}',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
