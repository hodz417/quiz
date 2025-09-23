import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mentor/core/utils/extensions/l10n_extension.dart';

import 'package:mentor/core/utils/theme/app_text_styles.dart';
import 'package:mentor/feature/landing/ui/widgets/features_cards.dart';
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
                context.l10n.howItWorksTitle,
                style: isMobile
                    ? AppTextStyles.font56BoldBlack
                    : AppTextStyles.font30BoldBlack,
                textAlign: TextAlign.center,
              ),
              Gap(12.h),
              Text(
                context.l10n.howItWorksSubtitle,

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
