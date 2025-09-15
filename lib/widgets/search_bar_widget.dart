// FILE PATH: lib/widgets/search_bar_widget.dart

import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_strings.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.searchBarHeight,
      decoration: BoxDecoration(
        color: AppColors.searchBarBackground,
        borderRadius: BorderRadius.circular(AppDimensions.searchBarRadius),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          const Expanded(
            child: Text(
              AppStrings.homeSearchHint,
              style: TextStyle(
                color: AppColors.searchBarHint,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.send,
              color: AppColors.primaryText,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
