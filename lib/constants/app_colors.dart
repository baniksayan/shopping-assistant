import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color gradientStart = Color(0xFF4c6ef5);
  static const Color gradientEnd = Color(0xFF7c3aed);
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkNavy = Color(0xFF1a1b3e);
  static const Color white = Color(0xFFFFFFFF);
  
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightPeach = Color(0xFFFFE4C4);
  static const Color darkSection = Color(0xFF2C3E50);
  
  // Interactive States
  static const Color buttonHover = Color(0xFF0051D5);
  static const Color buttonPressed = Color(0xFF003F99);
  
  // Gradients
  static const LinearGradient pillGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkBackgroundGradient = LinearGradient(
    colors: [darkBackground, darkNavy],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.6, 1.0],
  );
  
  static const LinearGradient lightBackgroundGradient = LinearGradient(
    colors: [lightBackground, lightPeach, darkSection],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.6, 1.0],
  );

  static const Color background = Color(0xFF000000);
  static const Color cardBackground = Color(0xFF1C1C1E);
  static const Color primaryPill = Color(0xFF2E3B4E); // Dark blue
  static const Color secondaryPill = Color(0xFF5D3FD3); // Purple/Indigo
  static const Color tertiaryPill = Color(0xFFE8B42E); // Yellow/Gold
  static const Color quaternaryPill = Color(0xFF1E847F); // Teal

  // Text Colors
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFEBEBF5);

  // Button Colors
  static const Color buttonBackground = Color(0xFFFFFFFF);
  static const Color buttonText = Color(0xFF000000);
  
  // Page Indicator
  static const Color indicatorActive = Color(0xFFFFFFFF);
  static const Color indicatorInactive = Color(0xFF555555);
}
