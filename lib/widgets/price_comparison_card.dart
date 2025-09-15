import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class PriceComparisonCard extends StatelessWidget {
  final String productName;
  final List<Map<String, String>> results; // [{'store':'Amazon','price':'₹9,999','url':'...'}, ...]
  final int bestIndex;

  const PriceComparisonCard({
    Key? key,
    required this.productName,
    required this.results,
    required this.bestIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comparison results for',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            productName,
            style: const TextStyle(color: AppColors.primaryText, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Column(
            children: List.generate(results.length, (i) {
              final r = results[i];
              final isBest = i == bestIndex;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isBest ? Colors.green.withOpacity(0.12) : Colors.white.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isBest ? Colors.green.withOpacity(0.18) : Colors.white.withOpacity(0.02)),
                ),
                child: Row(
                  children: [
                    // Store logo placeholder (could be Image.asset)
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: isBest ? Colors.green : AppColors.primaryBlue.withOpacity(0.12),
                      child: Text(r['store']!.substring(0,1).toUpperCase(), style: TextStyle(color: isBest ? Colors.white : AppColors.primaryText)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r['store']!, style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(r['subtitle'] ?? '', style: TextStyle(color: AppColors.secondaryText, fontSize: 12)),
                        ],
                      ),
                    ),
                    Text(r['price']!, style: TextStyle(color: isBest ? Colors.green : AppColors.primaryText, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
