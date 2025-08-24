// File: lib/feature/result/ui/widgets/topic_chip.dart
// Small reusable UI widget for the recommendation chips

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TopicChip extends StatelessWidget {
  final String title;
  final String label;

  const TopicChip({super.key, required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: isMobile
                    ? AppTextStyles.font30BoldBlack.copyWith(
                        color: Colors.white,
                      )
                    : AppTextStyles.font14BoldWhite,
              ),
              const Gap(4),
              SizedBox(
                width: 100,
                child: Text(
                  label,
                  style: isMobile
                      ? AppTextStyles.font22White
                      : AppTextStyles.font12White70,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
