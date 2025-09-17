import 'package:flutter/material.dart';

class AppColors {
  static bool _isDarkMode = false;
  
  static void setDarkMode(bool isDark) {
    _isDarkMode = isDark;
  }
  
  static bool get isDarkMode => _isDarkMode;
  
  // --- Brand Colors ---
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color gradientStart = Color(0xFF4c6ef5);
  static const Color gradientEnd = Color(0xFF7c3aed);

  // --- Dark Theme Colors ---
  static const Color _darkBackground = Color(0xFF000000);
  static const Color _darkSurface = Color(0xFF1C1C1E);
  static const Color _darkCardBackground = Color(0xFF2C2C2E);
  static const Color _darkSearchBackground = Color(0xFF3A3A3C);
  static const Color _darkPrimaryText = Color(0xFFFFFFFF);
  static const Color _darkSecondaryText = Color(0xFF8E8E93);
  static const Color _darkHintText = Color(0xFF6D6D70);
  static const Color _darkBorder = Color(0xFF48484A);
  
  // --- Light Theme Colors ---
  static const Color _lightBackground = Color(0xFFF8F8F8);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightCardBackground = Color(0xFFF2F2F7);
  static const Color _lightSearchBackground = Color(0xFFE5E5EA);
  static const Color _lightPrimaryText = Color(0xFF000000);
  static const Color _lightSecondaryText = Color(0xFF3C3C43);
  static const Color _lightHintText = Color(0xFF8E8E93);
  static const Color _lightBorder = Color(0xFFD1D1D6);

  // --- Dynamic Theme Colors ---
  static Color get background => _isDarkMode ? _darkBackground : _lightBackground;
  static Color get surface => _isDarkMode ? _darkSurface : _lightSurface;
  static Color get cardBackground => _isDarkMode ? _darkCardBackground : _lightCardBackground;
  static Color get searchBackground => _isDarkMode ? _darkSearchBackground : _lightSearchBackground;
  static Color get primaryText => _isDarkMode ? _darkPrimaryText : _lightPrimaryText;
  static Color get secondaryText => _isDarkMode ? _darkSecondaryText : _lightSecondaryText;
  static Color get hintText => _isDarkMode ? _darkHintText : _lightHintText;
  static Color get borderColor => _isDarkMode ? _darkBorder : _lightBorder;
  
  // --- Category Icon Colors (Fixed) ---
  static Color get categoryIconBackground => _isDarkMode ? _darkCardBackground : Colors.grey[200]!;
  static Color get categoryIconColor => _isDarkMode ? Colors.white : Colors.black87;
  static Color get categoryLabelColor => _isDarkMode ? _darkSecondaryText : _lightSecondaryText;
  
  // --- User Profile Colors ---
  static Color get userCardBackground => _isDarkMode ? _darkCardBackground : _lightCardBackground;
  static Color get balanceCardBackground => _isDarkMode ? _darkSurface : _lightSurface;
  
  // Static colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color darkNavy = Color(0xFF1a1b3e);
  static const Color lightPeach = Color(0xFFFFE4C4);
  static const Color darkSection = Color(0xFF2C3E50);

  // --- Feature Cards ---
  static Color get groceryCardColor => _isDarkMode ? Color(0xFF8B6914) : Color(0xFFFFE5B4);
  static Color get suggestionCardColor => _isDarkMode ? Color(0xFF1E3A8A) : Color(0xFFDCEDFE);
  static Color get askCardColor => _isDarkMode ? Color(0xFF166534) : Color(0xFFDCFCE7);

  // --- Pill Colors ---
  static Color get primaryPill => _isDarkMode ? Color(0xFF2E3B4E) : Color(0xFFE8EFF8);
  static Color get secondaryPill => _isDarkMode ? Color(0xFF5D3FD3) : Color(0xFFF0EBFF);
  static Color get tertiaryPill => _isDarkMode ? Color(0xFFE8B42E) : Color(0xFFFEF3C7);
  static Color get quaternaryPill => _isDarkMode ? Color(0xFF1E847F) : Color(0xFFD1FAE5);

  // --- Brand Colors ---
  static const Color zomatoRed = Color(0xFFE23744);
  static const Color flipkartBlue = Color(0xFF2874F0);
  static const Color zeptoPurple = Color(0xFF8B5CF6);
  static const Color amazonBlack = Color(0xFF232F3E);
  static const Color uberBlack = Color(0xFF000000);
  static const Color apolloBlue = Color(0xFF00A8E8);

  // --- Interactive Elements ---
  static Color get buttonBackground => _isDarkMode ? _darkCardBackground : _lightSurface;
  static Color get buttonText => _isDarkMode ? _darkPrimaryText : _lightPrimaryText;
  static Color get buttonBorder => _isDarkMode ? _darkBorder : _lightBorder;
  static const Color buttonHover = Color(0xFF0051D5);
  static const Color buttonPressed = Color(0xFF003F99);
  static const Color sendButtonColor = Color(0xFF34C759);

  // --- Other UI Elements ---
  static const Color profileIconBackground = Color(0xFFE91E63); // Pink for profile
  static const Color balanceIconColor = Color(0xFF34C759); // Green for money
  
  // --- Page Indicator ---
  static Color get indicatorActive => _isDarkMode ? Colors.white : Colors.black87;
  static Color get indicatorInactive => _isDarkMode ? Color(0xFF555555) : Color(0xFFBBBBBB);

  // --- Input Fields ---
  static Color get inputFillColor => _isDarkMode ? _darkCardBackground : _lightCardBackground;
  static Color get inputBorderColor => _isDarkMode ? _darkBorder : _lightBorder;
  static Color get inputFocusedBorderColor => primaryBlue;

  // --- Gradients ---
  static const LinearGradient pillGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient get backgroundGradient => _isDarkMode 
    ? LinearGradient(
        colors: [background, Color(0xFF1a1a1a)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1.0],
      )
    : LinearGradient(
        colors: [background, Color(0xFFf0f0f0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1.0],
      );
}
