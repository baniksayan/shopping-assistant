import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../widgets/category_icon_widget.dart';
import '../widgets/brand_grid_card.dart';
import '../widgets/savings_card.dart';

class FlashSaleScreen extends StatelessWidget {
  const FlashSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalMargin),
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E7),
                  borderRadius: BorderRadius.circular(27),
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        AppStrings.homeSearchPlaceholder,
                        style: TextStyle(
                          color: Color(0xFF8E8E93),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(
                        Icons.search,
                        color: Color(0xFF8E8E93),
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Category icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryIconWidget(
                    emoji: '▪️▪️\n▪️▪️',
                    label: AppStrings.categoryTopBrands,
                    onTap: () => print('Top Brands tapped'),
                  ),
                  CategoryIconWidget(
                    emoji: '🍔',
                    label: AppStrings.categoryFood,
                    onTap: () => print('Food tapped'),
                  ),
                  CategoryIconWidget(
                    emoji: '👟',
                    label: AppStrings.categoryClothing,
                    onTap: () => print('Clothing tapped'),
                  ),
                  CategoryIconWidget(
                    emoji: '🔮',
                    label: AppStrings.categoryBeauty,
                    onTap: () => print('Beauty tapped'),
                  ),
                  CategoryIconWidget(
                    emoji: '💍',
                    label: AppStrings.categoryJewellery,
                    onTap: () => print('Jewellery tapped'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Top Brands section title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalMargin),
              child: Text(
                AppStrings.topBrandsTitle,
                style: TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Top Brands Grid - First Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BrandGridCard(
                    brandName: AppStrings.brandZomato,
                    discount: AppStrings.discount4,
                    brandColor: const Color(0xFFE23744),
                    onTap: () => print('Zomato tapped'),
                  ),
                  BrandGridCard(
                    brandName: AppStrings.brandZepto,
                    discount: AppStrings.discount4,
                    brandColor: const Color(0xFF8B5CF6),
                    onTap: () => print('Zepto tapped'),
                  ),
                  BrandGridCard(
                    brandName: AppStrings.brandUber,
                    discount: AppStrings.discount4,
                    brandColor: const Color(0xFF000000),
                    onTap: () => print('Uber tapped'),
                  ),
                  BrandGridCard(
                    brandName: AppStrings.brandApollo,
                    discount: AppStrings.discount9,
                    brandColor: const Color(0xFF2196F3),
                    onTap: () => print('Apollo tapped'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Top Brands Grid - Second Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BrandGridCard(
                    brandName: AppStrings.brandFlipkart,
                    discount: AppStrings.discount1,
                    brandColor: const Color(0xFF2874F0),
                    onTap: () => print('Flipkart tapped'),
                  ),
                  BrandGridCard(
                    brandName: AppStrings.brandAmazon,
                    discount: AppStrings.discount1,
                    brandColor: const Color(0xFF232F3E),
                    onTap: () => print('Amazon tapped'),
                  ),
                  BrandGridCard(
                    brandName: AppStrings.brandAjio,
                    discount: AppStrings.discount6,
                    brandColor: const Color(0xFF2C5282),
                    onTap: () => print('Ajio tapped'),
                  ),
                  BrandGridCard(
                    brandName: AppStrings.brandBookMyShow,
                    discount: AppStrings.discount5,
                    brandColor: const Color(0xFFE53E3E),
                    onTap: () => print('BookMyShow tapped'),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Savings card
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.horizontalMargin),
              child: SavingsCard(),
            ),
            
            const SizedBox(height: 100), // Bottom padding for nav bar
          ],
        ),
      ),
    );
  }
}
