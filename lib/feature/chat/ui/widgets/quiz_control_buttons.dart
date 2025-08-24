import 'package:flutter/material.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class QuizControlButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const QuizControlButtons({
    super.key,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile =
            sizingInformation.deviceScreenType == DeviceScreenType.mobile;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: onPrevious,
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              label: Text(
                context.l10n.previous,
                style: isMobile
                    ? AppTextStyles.font30BoldBlack
                    : AppTextStyles.font14Black,
              ),
            ),
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
              ),
              child: Text(
                context.l10n.next,
                style: isMobile
                    ? AppTextStyles.font30BoldBlack.copyWith(
                        color: Colors.white,
                      )
                    : AppTextStyles.font14Black.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
