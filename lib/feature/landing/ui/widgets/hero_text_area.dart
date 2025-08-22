import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';

class HeroTextArea extends StatelessWidget {
  const HeroTextArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // علشان العربي
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("اكتشف مسارك\nالمهني", style: AppTextStyles.font56BoldBlack),
          Gap(8.h),
          Text("مع الذكاء الاصطناعي", style: AppTextStyles.font56BoldBlack),
          Gap(24.h),
          Text(
            "منصة شاملة تساعدك في تحديد مهاراتك وبناء مسارك المهني من خلال التوجيه الذكي والدورات المخصصة",
            style: AppTextStyles.font20Grey,
          ),
          Gap(36.h),

          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue900,
                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  "ابدأ الآن ←",
                  style: AppTextStyles.font22White,
                ),
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}
