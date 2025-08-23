
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/core/utils/constants/routes.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'feature_card_item.dart';

class FeaturesCards extends StatelessWidget {
  const FeaturesCards({super.key});

void _startLevel(BuildContext context, String level) {
  // Navigate via GoRouter and pass the level as a query parameter
  GoRouter.of(context).go('${Routes.quize}?level=${Uri.encodeComponent(level)}');
}

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final bool isMobile =
            sizingInformation.deviceScreenType == DeviceScreenType.mobile;

        if (isMobile) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FeatureCardItem(
                icon: Icons.bolt_outlined,
                iconBgColor: AppColors.blueColor,
                title: context.l10n.level1Title,
                description: context.l10n.level1Description,
                onTap: () => _startLevel(context, 'Level 1'),
                isMobile: true,
              ),
              SizedBox(height: 24.h),
              FeatureCardItem(
                icon: Icons.insights_outlined,
                iconBgColor: AppColors.greenColor,
                title: context.l10n.level2Title,
                description: context.l10n.level2DescriptionMobile,
                cardGradient: AppColors.greenLinearGradient,
                onTap: () => _startLevel(context, 'Level 2'),
                isMobile: true,
              ),
              SizedBox(height: 24.h),
              FeatureCardItem(
                icon: Icons.star_border_outlined,
                iconBgColor: AppColors.blueColor,
                title: context.l10n.level3Title,
                description: context.l10n.level3DescriptionMobile,
                onTap: () => _startLevel(context, 'Level 3'),
                isMobile: true,
              ),
            ],
          );
        } else {
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 32.w,
            runSpacing: 24.h,
            children: [
              FeatureCardItem(
                icon: Icons.bolt_outlined,
                iconBgColor: AppColors.blueColor,
                title: context.l10n.level1Title,
                description: context.l10n.level1Description,
                onTap: () => _startLevel(context, 'Level 1'),
                isMobile: false,
              ),
              FeatureCardItem(
                icon: Icons.insights_outlined,
                iconBgColor: AppColors.greenColor,
                title: context.l10n.level2Title,
                description: context.l10n.level2DescriptionDesktop,
                cardGradient: AppColors.greenLinearGradient,
                onTap: () => _startLevel(context, 'Level 2'),
                isMobile: false,
              ),
              FeatureCardItem(
                icon: Icons.star_border_outlined,
                iconBgColor: AppColors.blueColor,
                title: context.l10n.level3Title,
                description: context.l10n.level3DescriptionDesktop,
                onTap: () => _startLevel(context, 'Level 3'),
                isMobile: false,
              ),
            ],
          );
        }
      },
    );
  }
}

