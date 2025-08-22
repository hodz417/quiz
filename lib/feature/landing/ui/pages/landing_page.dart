import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/landing/ui/widgets/footer_section.dart';
import 'package:quiz/feature/landing/ui/widgets/hero_section.dart';
import 'package:quiz/feature/landing/ui/widgets/how_work_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Multiverse Mentor", style: AppTextStyles.font26BoldBlack),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(),
            Gap(48.h),
            HowItWorksSection(),
            Gap(72.h),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
