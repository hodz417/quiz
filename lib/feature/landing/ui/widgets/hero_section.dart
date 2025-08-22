import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/landing/ui/widgets/hero_image.dart';
import 'package:quiz/feature/landing/ui/widgets/hero_text_area.dart';


class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kPrimaryBg,

      padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 60.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side text area
          Expanded(flex: 6, child: HeroTextArea()),
          Gap(56.w),
          Expanded(
            flex: 5,
            child: HeroImage(width: 720.w, height: 280.h),
          ),
        ],
      ),
    );
  }
}
