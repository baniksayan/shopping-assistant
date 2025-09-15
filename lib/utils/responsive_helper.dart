// FILE PATH: lib/utils/responsive_helper.dart

import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double getResponsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }
  
  static double getResponsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }
  
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 400) {
      return baseSize * 1.1;
    } else if (screenWidth < 350) {
      return baseSize * 0.9;
    }
    return baseSize;
  }
  
  static int getBrandGridCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 6; // Tablet
    } else if (screenWidth > 400) {
      return 4; // Large phone
    }
    return 4; // Default mobile
  }
}
