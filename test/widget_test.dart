// This is a comprehensive Flutter widget test for the FutureFounders onboarding screen.
//
// To perform interactions with widgets in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap gestures
// and verify that the UI updates correctly. You can also use WidgetTester
// to find child widgets in the widget tree, read text, and verify that the
// values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shopping_assistant/main.dart'; // Import your main app file
import 'package:shopping_assistant/constants/app_strings.dart'; // Import string constants
import 'package:shopping_assistant/screens/onboarding_screen.dart';
import 'package:shopping_assistant/widgets/shopping_cart_illustration.dart';
import 'package:shopping_assistant/widgets/gradient_background.dart'; // Import widget

void main() {
  // Test group for the onboarding screen
  group('OnboardingScreen Widget Tests', () {

    // Test case: Initial UI rendering in dark mode
    testWidgets('Renders initial UI correctly in dark mode', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const FutureFoundersApp());

      // Verify that the main onboarding screen is visible.
      expect(find.byType(OnboardingScreen), findsOneWidget);

      // Verify the brand pill text is correct.
      expect(find.text(AppStrings.fullBrandName), findsOneWidget);

      // Verify the main headline text is correct.
      expect(find.text(AppStrings.headline), findsOneWidget);

      // Verify the "Get Started" button text is correct.
      expect(find.text(AppStrings.ctaButton), findsOneWidget);

      // Verify it starts in dark mode by checking the gradient background.
      final GradientBackground gradient = tester.widget(find.byType(GradientBackground));
      expect(gradient.isDarkMode, isTrue);

      // Verify the shopping cart is not visible in dark mode.
      expect(find.byType(ShoppingCartPainter), findsNothing);
    });

    // Test case: Theme toggling from dark to light mode
    testWidgets('Toggles theme from dark to light mode on tap', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const FutureFoundersApp());

      // Find the theme toggle button (debug only).
      final themeToggleButton = find.byIcon(Icons.light_mode);
      expect(themeToggleButton, findsOneWidget);

      // Tap the theme toggle button.
      await tester.tap(themeToggleButton);
      await tester.pump(); // Rebuild the widget with the new state.

      // Verify the theme has switched to light mode.
      final GradientBackground gradient = tester.widget(find.byType(GradientBackground));
      expect(gradient.isDarkMode, isFalse);

      // Verify the shopping cart illustration is now visible.
      expect(find.byType(ShoppingCartPainter), findsOneWidget);

      // Verify the theme toggle icon has updated.
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    });
    
    // Test case: CTA button loading state
    testWidgets('Shows loading indicator on CTA button press', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const FutureFoundersApp());

      // Find the "Get Started" button.
      final ctaButton = find.text(AppStrings.ctaButton);
      expect(ctaButton, findsOneWidget);

      // Verify no loading indicator is present initially.
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Tap the "Get Started" button.
      await tester.tap(ctaButton);
      await tester.pump(); // First pump for setState to show loading.

      // Verify the loading indicator is now visible.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for the simulated delay to complete.
      await tester.pump(const Duration(milliseconds: 500)); // Second pump after delay.
      
      // Verify the loading indicator is gone.
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
    
    // Test case: Light mode UI rendering
    testWidgets('Renders UI correctly in light mode after toggling', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const FutureFoundersApp());
      
      // Toggle to light mode first.
      await tester.tap(find.byIcon(Icons.light_mode));
      await tester.pump();
      
      // Verify all essential texts are still visible.
      expect(find.text(AppStrings.fullBrandName), findsOneWidget);
      expect(find.text(AppStrings.headline), findsOneWidget);
      expect(find.text(AppStrings.ctaButton), findsOneWidget);
      
      // Verify the ShoppingCartPainter is present.
      expect(find.byType(ShoppingCartPainter), findsOneWidget);
      
      // Verify the GradientBackground is in light mode.
      final GradientBackground gradient = tester.widget(find.byType(GradientBackground));
      expect(gradient.isDarkMode, isFalse);
    });

  });
}
