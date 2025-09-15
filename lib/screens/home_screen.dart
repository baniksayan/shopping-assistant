import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_dimensions.dart';
import '../widgets/user_balance_card.dart';
import '../widgets/stats_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/feature_card.dart';
import '../widgets/ai_assistant_card.dart';
import '../widgets/search_input_card.dart';
import '../widgets/brand_logo_card.dart';
import '../widgets/see_more_pill.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.horizontalMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserBalanceCard(),
            const SizedBox(height: 20),

            // Smart compare search bar
            SearchInputCard(
              controller: _searchCtrl,
              onCompare: () => print('Compare "${_searchCtrl.text}"'),
            ),

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
            const SizedBox(height: 18),
                _buildTrustSection(context),
                const SizedBox(height: 28),
          ],
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
      children: const [
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
    final logoCards = <Widget>[
      ...AppStrings.topBrandLogos.map((b) => BrandLogoCard(
            assetPath: b['asset']!,
            name: b['name']!,
            onTap: () => print('Open ${b['name']}'),
          )),
      SeeMorePill(onTap: () => print('See more brands')),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Top Brands',
            style: TextStyle(color: AppColors.primaryText, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 84,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: logoCards.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => logoCards[i],
          ),
        ),
      ],
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
        children: const [
          Text(AppStrings.trustTitle,
              style: TextStyle(color: AppColors.primaryText, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text(AppStrings.trustFeature1, style: TextStyle(color: AppColors.secondaryText, fontSize: 14)),
          SizedBox(height: 6),
          Text(AppStrings.trustFeature2, style: TextStyle(color: AppColors.secondaryText, fontSize: 14)),
          SizedBox(height: 6),
          Text(AppStrings.trustFeature3, style: TextStyle(color: AppColors.secondaryText, fontSize: 14)),
        ],
      ),
    );
  }
}
