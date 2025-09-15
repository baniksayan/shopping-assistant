// FILE PATH: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../widgets/user_balance_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/feature_card.dart';
import '../widgets/ai_assistant_card.dart';
import '../utils/responsive_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.horizontalMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              
              // User greeting and balance cards
              const UserBalanceCard(),
              
              const SizedBox(height: 24),
              
              // Welcome and main title
              _buildWelcomeSection(context),
              
              const SizedBox(height: 24),
              
              // Stats cards
              _buildStatsSection(context),
              
              const SizedBox(height: 24),
              
              // Quick actions
              _buildQuickActionsSection(context),
              
              const SizedBox(height: 24),
              
              // AI Assistant card
              const AIAssistantCard(),
              
              const SizedBox(height: 24),
              
              // Smart features
              _buildSmartFeaturesSection(context),
              
              const SizedBox(height: 24),
              
              // Popular brands (existing)
              _buildPopularBrandsSection(context),
              
              const SizedBox(height: 24),
              
              // Trust section
              _buildTrustSection(context),
              
              const SizedBox(height: 100), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.homeWelcome,
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.homeMainTitle,
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 28),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.homeSubtitle,
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatsCard(
            value: '₹15,420',
            label: AppStrings.totalSavings,
            icon: Icons.savings,
            iconColor: const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            value: '24',
            label: AppStrings.itemsTracked,
            icon: Icons.track_changes,
            iconColor: const Color(0xFF2196F3),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            value: '127',
            label: AppStrings.dealsFound,
            icon: Icons.local_offer,
            iconColor: const Color(0xFFFF9800),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.quickActionsTitle,
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                title: AppStrings.actionScanProduct,
                icon: Icons.qr_code_scanner,
                backgroundColor: const Color(0xFF9C27B0),
                onTap: () => print('Scan Product'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                title: AppStrings.actionComparePrice,
                icon: Icons.compare,
                backgroundColor: const Color(0xFF2196F3),
                onTap: () => print('Compare Prices'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                title: AppStrings.actionFindDeals,
                icon: Icons.local_offer,
                backgroundColor: const Color(0xFFFF9800),
                onTap: () => print('Find Deals'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                title: AppStrings.actionAskAssistant,
                icon: Icons.assistant,
                backgroundColor: const Color(0xFF4CAF50),
                onTap: () => print('Ask Assistant'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmartFeaturesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.smartFeaturesTitle,
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        FeatureCard(
          title: AppStrings.featurePriceTracker,
          description: AppStrings.featurePriceTrackerDesc,
          icon: Icons.trending_down,
          accentColor: const Color(0xFF4CAF50),
          onTap: () => print('Price Tracker'),
        ),
        const SizedBox(height: 12),
        FeatureCard(
          title: AppStrings.featureSmartRecommendations,
          description: AppStrings.featureSmartRecommendationsDesc,
          icon: Icons.recommend,
          accentColor: const Color(0xFF2196F3),
          onTap: () => print('Smart Recommendations'),
        ),
        const SizedBox(width: 12),
        FeatureCard(
          title: AppStrings.featureBulkSaver,
          description: AppStrings.featureBulkSaverDesc,
          icon: Icons.shopping_cart_outlined,
          accentColor: const Color(0xFFFF9800),
          onTap: () => print('Bulk Saver'),
        ),
      ],
    );
  }

  Widget _buildPopularBrandsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Brands',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Your existing brand row here - keep as is
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBrandCard('Amazon', '1-5% OFF', const Color(0xFF232F3E)),
            _buildBrandCard('Flipkart', '1-10% OFF', const Color(0xFF2874F0)),
            _buildBrandCard('Myntra', '5-40% OFF', const Color(0xFFEE5F73)),
            _buildBrandCard('Zomato', '20% OFF', const Color(0xFFE23744)),
          ],
        ),
      ],
    );
  }

  Widget _buildBrandCard(String name, String discount, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            discount,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTrustSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.trustTitle,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildTrustFeature(AppStrings.trustFeature1),
          _buildTrustFeature(AppStrings.trustFeature2),
          _buildTrustFeature(AppStrings.trustFeature3),
        ],
      ),
    );
  }

  Widget _buildTrustFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        feature,
        style: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: 14,
        ),
      ),
    );
  }
}
