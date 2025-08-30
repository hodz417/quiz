import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/landing/ui/widgets/footer_links.dart';
import 'package:quiz/feature/landing/ui/widgets/footer_logo_and_contact.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 36.w;
    final verticalPadding = 44.h;

    return Container(
      width: double.infinity,
      color: AppColors.darkBlackColor,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FooterLogoAndContact(),
          FooterLinks(
            title: context.l10n.footerServices,
            items: [
              context.l10n.footerServiceGuidance,
              context.l10n.footerServicePersonalityAnalysis,
              context.l10n.footerServiceCourses,
            ],
          ),
          FooterLinks(
            title: context.l10n.footerQuickLinks,
            items: [
              context.l10n.footerQuickLinksDashboard,
              context.l10n.footerQuickLinksProjects,
              context.l10n.footerQuickLinksMentoring,
            ],
          ),
        ],
      ),
    );
  }
}
