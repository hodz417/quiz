import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/landing/ui/widgets/hero_image.dart';
import 'package:quiz/feature/landing/ui/widgets/hero_text_area.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final bool isMobile = sizingInformation.isMobile;

        return Container(
          color: AppColors.kPrimaryBg,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20.w : 36.w,
            vertical: isMobile ? 32.h : 60.h,
          ),
          child: isMobile
              // Mobile: stack in a Column
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // الصورة أولاً (لو عايز النص أولاني قللي وانا اعدل)
                    HeroImage(width: 1100.w, height: 200.h),
                    Gap(40.h),
                    HeroTextArea(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: HeroImage(width: 720.w, height: 280.h),
                    ),
                    Gap(56.w),
                    Expanded(flex: 6, child: HeroTextArea()),
                  ],
                ),
        );
      },
    );
  }
}
