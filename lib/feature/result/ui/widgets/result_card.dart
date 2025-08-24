

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Color> gradient;
  final List<Map<String, String>> items;
  const ResultCard({super.key, 
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
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if ((items[i]['label']?.isNotEmpty ?? false))
                          Flexible(
                            child: Text(
                              items[i]['label'] ?? '',
                              style: AppTextStyles.font14Grey.copyWith(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        const Gap(6),
                        Flexible(
                          child: Text(
                            items[i]['value'] ?? '',
                            style: AppTextStyles.font14Grey.copyWith(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
