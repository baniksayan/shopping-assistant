// FILE PATH: lib/widgets/user_balance_card.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';
import '../services/user_data_service.dart';

class UserBalanceCard extends StatelessWidget {
  const UserBalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // User greeting card
        Container(
          height: AppDimensions.userCardHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.userCardBackground,
            borderRadius: BorderRadius.circular(AppDimensions.userCardRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: AppDimensions.userAvatarSize / 2,
                backgroundColor: AppColors.profileIconBackground,
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryText,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                UserDataService.firstName.isNotEmpty 
                    ? 'Hi ${UserDataService.firstName}' 
                    : 'Hi User',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
        // Balance card
        Container(
          height: AppDimensions.balanceCardHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.balanceCardBackground,
            borderRadius: BorderRadius.circular(AppDimensions.userCardRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: AppColors.balanceIconColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.homeBalance,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
