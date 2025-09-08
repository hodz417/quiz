import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Color> gradient;
  final List<Map<String, String>> items;
  const ResultCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.gradient,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Slightly increased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- Card Title ---
              Row(
                children: [
                  Icon(icon, color: iconColor, size: 22),
                  const Gap(6),
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.font20SemiBoldBlack.copyWith(
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Gap(6),
              // --- Card Items Content ---
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    // Check if the item has a meaningful 'label'
                    if ((items[i]['label']?.isNotEmpty ?? false))
                      // If label exists, use Row with spaceBetween for label:value layout
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Label on the left
                          Expanded(
                            child: Text(
                              '${items[i]['label']}:', // Add colon for clarity
                              style: AppTextStyles.font14Grey.copyWith(
                                fontSize: 12,
                                //fontWeight: FontWeight.bold, // Optional: make label slightly bolder
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // --- Increased Gap Here ---
                          // Changed from const Gap(6) to const Gap(12) for more space
                          const Gap(12), // Increase space between label and value
                          // --------------------------
                          // Value on the right
                          Text(
                            items[i]['value'] ?? '',
                            style: AppTextStyles.font14Grey.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold, // Make value bold for emphasis
                            ),
                            //overflow: TextOverflow.ellipsis, // Usually not needed for percentages
                          ),
                        ],
                      )
                    else
                      // If no label, just display the 'value' text aligned to the left
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          items[i]['value'] ?? '',
                          style: AppTextStyles.font14Grey.copyWith(
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    // Add spacing between items, except after the last one
                    if (i != items.length - 1) const SizedBox(height: 6),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}