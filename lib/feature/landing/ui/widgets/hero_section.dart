import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/constants/app_assets.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
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
            vertical: isMobile ? 32.h : 10.h,
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.heroImage2 ,width: 1400.w, height: 350.h),
                    Gap(40.h),
                    HeroTextArea(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: HeroTextArea()),
                    Gap(56.w),

                    Expanded(flex: 4, child: Image.asset(AppAssets.heroImage2 , height: 600.h,),),
                  ],
                ),
        );
      },
    );
  }
}
