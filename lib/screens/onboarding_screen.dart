// FILE PATH: lib/screens/onboarding_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_content.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_dimensions.dart';
import '../widgets/onboarding_page_view.dart';
import '../widgets/onboarding_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  // --- DATA FOR THE ONBOARDING PAGES ---
  final List<OnboardingContent> _onboardingData = [
    OnboardingContent(
      image: 'assets/image1.png',
      pillText: AppStrings.page1Pill,
      pillIcon: Icons.search,
      headline: AppStrings.page1Headline,
    ),
    OnboardingContent(
      image: 'assets/image2.png',
      pillText: AppStrings.page2Pill,
      pillIcon: Icons.local_offer,
      headline: AppStrings.page2Headline,
    ),
    OnboardingContent(
      image: 'assets/image3.png',
      pillText: AppStrings.page3Pill,
      pillIcon: Icons.shopping_cart,
      headline: AppStrings.page3Headline,
    ),
    OnboardingContent(
      image: 'assets/image4.png',
      pillText: AppStrings.page4Pill,
      pillIcon: Icons.question_answer,
      headline: AppStrings.page4Headline,
    ),
  ];

  final List<Color> _pillColors = [
    AppColors.primaryPill,
    AppColors.secondaryPill,
    AppColors.tertiaryPill,
    AppColors.quaternaryPill,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      if (!mounted) return;
      setState(() {
        // Using round() to get the nearest page index during scroll
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextButtonPressed() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // LAST PAGE: Navigate to the login screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == _onboardingData.length - 1;
    final String buttonText =
        isLastPage ? AppStrings.getStartedButton : AppStrings.nextButton;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.horizontalMargin),
          child: Column(
            children: [
              // --- PAGE VIEW AREA ---
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return OnboardingPageView(
                      content: _onboardingData[index],
                      pillColor: _pillColors[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // --- BOTTOM CONTROLS ---
              OnboardingPageIndicator(
                pageCount: _onboardingData.length,
                currentPage: _currentPage,
              ),
              const SizedBox(height: 20),

              // --- ACTION BUTTON ---
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeight,
                child: ElevatedButton(
                  onPressed: _onNextButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.buttonRadius),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: AppDimensions.buttonFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.bottomPadding),
            ],
          ),
        ),
      ),
    );
  }
}
