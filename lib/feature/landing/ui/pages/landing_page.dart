import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/landing/ui/widgets/footer_section.dart';
import 'package:quiz/feature/landing/ui/widgets/hero_section.dart';
import 'package:quiz/feature/landing/ui/widgets/how_work_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final bool isMobile = sizingInformation.isMobile;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            centerTitle: isMobile,
            title: Text(
              "Multiverse Mentor",
              style: isMobile
                  ? AppTextStyles.font70BoldBlack
                  : AppTextStyles.font26BoldBlack,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                HeroSection(),
                Gap(isMobile ? 24.h : 48.h), // فراغ أقل في الموبايل
                HowItWorksSection(),
                Gap(isMobile ? 36.h : 72.h),

                if (!isMobile) FooterSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
