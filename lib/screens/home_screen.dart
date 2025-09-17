import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_dimensions.dart';
import '../widgets/user_balance_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/feature_card.dart';
import '../widgets/ai_assistant_card.dart';
import '../widgets/category_icon_widget.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  Widget _buildTopBar() {
    return Row(
      children: [
        // Profile button in top-left
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileViewScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        // You can add more top bar items here in the future
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.searchBackground,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.borderColor.withOpacity(0.1),
        ),
      ),
      child: TextField(
        controller: _searchCtrl,
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Search from 300+ brands',
          hintStyle: TextStyle(
            color: AppColors.hintText,
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.hintText,
            size: 24,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CategoryIconWidget(
          emoji: '🏷️',
          label: AppStrings.categoryTopBrands,
          onTap: () => print('Top Brands tapped'),
        ),
        CategoryIconWidget(
          emoji: '🍔',
          label: AppStrings.categoryFood,
          onTap: () => print('Food tapped'),
        ),
        CategoryIconWidget(
          emoji: '👕',
          label: AppStrings.categoryClothing,
          onTap: () => print('Clothing tapped'),
        ),
        CategoryIconWidget(
          emoji: '💄',
          label: AppStrings.categoryBeauty,
          onTap: () => print('Beauty tapped'),
        ),
        CategoryIconWidget(
          emoji: '💍',
          label: AppStrings.categoryJewellery,
          onTap: () => print('Jewellery tapped'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.horizontalMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 16),
              const UserBalanceCard(),
              const SizedBox(height: 20),

              // Search bar from 300+ brands
              _buildSearchBar(),
              const SizedBox(height: 20),

              // Category icons section
              _buildCategorySection(),
              const SizedBox(height: 20),

              _buildStatsRow(context),
              const SizedBox(height: 18),
              _buildQuickActionsRow(context),
              const SizedBox(height: 18),
              const AIAssistantCard(),
              const SizedBox(height: 18),
              _buildSmartFeaturesColumn(context),
              const SizedBox(height: 18),
              _buildBrandLogoStrip(context),
              const SizedBox(height: 20),
              _buildSavingsCard(),
              const SizedBox(height: 18),
              _buildTrustSection(context),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────────────────── STATS
  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: StatsCard(value: '₹15 420', label: AppStrings.totalSavings,   icon: Icons.savings,          iconColor: Color(0xFF4CAF50))),
        SizedBox(width: 12),
        Expanded(child: StatsCard(value: '24',      label: AppStrings.itemsTracked,   icon: Icons.track_changes,    iconColor: Color(0xFF2196F3))),
        SizedBox(width: 12),
        Expanded(child: StatsCard(value: '127',     label: AppStrings.dealsFound,     icon: Icons.local_offer,      iconColor: Color(0xFFFF9800))),
      ],
    );
  }

  // ────────────────────────────────── QUICK ACTIONS
  Widget _buildQuickActionsRow(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: QuickActionCard(title: AppStrings.actionScanProduct,  icon: Icons.qr_code_scanner, backgroundColor: Color(0xFF9C27B0))),
        SizedBox(width: 12),
        Expanded(child: QuickActionCard(title: AppStrings.actionComparePrice, icon: Icons.compare,         backgroundColor: Color(0xFF2196F3))),
        SizedBox(width: 12),
        Expanded(child: QuickActionCard(title: AppStrings.actionFindDeals,    icon: Icons.local_offer,     backgroundColor: Color(0xFFFF9800))),
        SizedBox(width: 12),
        Expanded(child: QuickActionCard(title: AppStrings.actionAskAssistant, icon: Icons.smart_toy,       backgroundColor: Color(0xFF4CAF50))),
      ],
    );
  }

  // ─────────────────────────────── SMART FEATURES
  Widget _buildSmartFeaturesColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Smart Shopping Features',
            style: TextStyle(color: AppColors.primaryText, fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        FeatureCard(
          title: AppStrings.featurePriceTracker,
          description: AppStrings.featurePriceTrackerDesc,
          icon: Icons.trending_down,
          accentColor: Color(0xFF4CAF50),
        ),
        SizedBox(height: 12),
        FeatureCard(
          title: AppStrings.featureSmartRecommendations,
          description: AppStrings.featureSmartRecommendationsDesc,
          icon: Icons.recommend,
          accentColor: Color(0xFF2196F3),
        ),
        SizedBox(height: 12),
        FeatureCard(
          title: AppStrings.featureBulkSaver,
          description: AppStrings.featureBulkSaverDesc,
          icon: Icons.group,
          accentColor: Color(0xFFFF9800),
        ),
      ],
    );
  }

  // ──────────────────────────────── BRAND LOGO STRIP
  Widget _buildBrandLogoStrip(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Top Brands',
            style: TextStyle(color: AppColors.primaryText, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        // Brand grid with proper theming
        Row(
          children: [
            Expanded(child: _buildBrandCard('Zomato', '4% OFF', AppColors.zomatoRed)),
            const SizedBox(width: 12),
            Expanded(child: _buildBrandCard('Zepto', '4% OFF', AppColors.zeptoPurple)),
            const SizedBox(width: 12),
            Expanded(child: _buildBrandCard('Uber', '4% OFF', AppColors.uberBlack)),
            const SizedBox(width: 12),
            Expanded(child: _buildBrandCard('Apollo', '9% OFF', AppColors.apolloBlue)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildBrandCard('Flipkart', '1% OFF', AppColors.flipkartBlue)),
            const SizedBox(width: 12),
            Expanded(child: _buildBrandCard('Amazon', '1% OFF', AppColors.amazonBlack)),
            const SizedBox(width: 12),
            Expanded(child: _buildBrandCard('Ajio', '6% OFF', Color(0xFF004CFF))),
            const SizedBox(width: 12),
            Expanded(child: _buildBrandCard('BookMyShow', '5% OFF', Color(0xFFDC2626))),
          ],
        ),
      ],
    );
  }

  Widget _buildBrandCard(String name, String discount, Color brandColor) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: brandColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.borderColor.withOpacity(0.2),
            ),
          ),
          child: Text(
            discount,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSavingsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderColor.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Savings till date',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '₹0.00',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.borderColor.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    'View all voucher orders',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.currency_rupee,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────── TRUST
  Widget _buildTrustSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.trustTitle,
              style: TextStyle(color: AppColors.primaryText, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(AppStrings.trustFeature1, style: TextStyle(color: AppColors.secondaryText, fontSize: 14)),
          const SizedBox(height: 6),
          Text(AppStrings.trustFeature2, style: TextStyle(color: AppColors.secondaryText, fontSize: 14)),
          const SizedBox(height: 6),
          Text(AppStrings.trustFeature3, style: TextStyle(color: AppColors.secondaryText, fontSize: 14)),
        ],
      ),
    );
  }
}
