import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/feature/landing/ui/widgets/features_cards.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 36.w;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "?How does Multiverse Mentor work",
                style: isMobile
                    ? AppTextStyles.font56BoldBlack
                    : AppTextStyles.font30BoldBlack,
                textAlign: TextAlign.center,
              ),
              Gap(12.h),
              Text(
                "Three simple steps to reach your ideal career path",
                style: isMobile
                    ? AppTextStyles.font35Grey
                    : AppTextStyles.font18RegularGrey,
                textAlign: TextAlign.center,
              ),
              Gap(isMobile ? 20.h : 48.h),

              const FeaturesCards(),
            ],
          ),
        );
      },
    );
  }
}
