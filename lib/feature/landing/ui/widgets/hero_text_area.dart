import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/landing/data/helper/start_level_func.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HeroTextArea extends StatelessWidget {
  const HeroTextArea({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;
        return Column(
          crossAxisAlignment: isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,

          children: [
            Text(
              context.l10n.heroTitleLine1,
              style: isMobile
                  ? AppTextStyles.font70BoldBlack
                  : AppTextStyles.font56BoldBlack,
            ),
            Gap(8.h),
            Text(
              context.l10n.heroTitleLine2,
              style: AppTextStyles.font56BoldBlack,
            ),
            Gap(isMobile ? 12.h : 24.h),

            Text(
              isMobile
                  ? context.l10n.heroShortDescription
                  : context.l10n.heroDescription,
              style: isMobile
                  ? AppTextStyles.font35Grey
                  : AppTextStyles.font20Grey,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),

            Gap(isMobile ? 20.h : 36.h),
            Row(
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    startLevel(context, 'Level 1');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue900,
                    padding: EdgeInsets.symmetric(
                      horizontal: 36.w,
                      vertical: 20.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    context.l10n.heroStartNow,
                    style: isMobile
                        ? AppTextStyles.font35White
                        : AppTextStyles.font22White,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
