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
    // Detect if current locale is RTL (like Arabic)
    final isRtl = Directionality.of(context) == TextDirection.rtl;

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
          padding: const EdgeInsets.all(8.0),
          child: Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
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
                        textAlign: isRtl ? TextAlign.right : TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const Gap(6),
                // --- Card Items Content ---
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < items.length; i++) ...[
                      if ((items[i]['label']?.isNotEmpty ?? false))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: isRtl
                              ? [
                                  // Value on the right (for RTL)
                                  Text(
                                    items[i]['value'] ?? '',
                                    style: AppTextStyles.font14Grey.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    child: Text(
                                      '${items[i]['label']}:',
                                      style: AppTextStyles.font14Grey.copyWith(
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ]
                              : [
                                  // Label on the left (for LTR)
                                  Expanded(
                                    child: Text(
                                      '${items[i]['label']}:',
                                      style: AppTextStyles.font14Grey.copyWith(
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const Gap(12),
                                  Text(
                                    items[i]['value'] ?? '',
                                    style: AppTextStyles.font14Grey.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                        )
                      else
                        Align(
                          alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
                          child: Text(
                            items[i]['value'] ?? '',
                            style: AppTextStyles.font14Grey.copyWith(
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: isRtl ? TextAlign.right : TextAlign.left,
                          ),
                        ),
                      if (i != items.length - 1) const SizedBox(height: 6),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}