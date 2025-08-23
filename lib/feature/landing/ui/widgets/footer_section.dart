import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 36.w;
    final verticalPadding = 44.h;

    return Container(
      width: double.infinity,
      color: const Color(0xFF0B1426),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            FooterLogoAndContact(),
            FooterLinks(
              title: "Services",
              items: [
                "Mentorship",
                "Personality Analysis",
                "Courses",
              ],
            ),
            FooterLinks(
              title: "Quick Links",
              items: [
                "Dashboard",
                "Projects",
                "Academic Mentorship",
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FooterLogoAndContact extends StatelessWidget {
  const FooterLogoAndContact({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Multiverse Mentor",
                style: AppTextStyles.font22BlueSemiBold,
              ),
              Gap(12.w),
              Icon(Icons.public, color: AppColors.blue700, size: 28.sp),
            ],
          ),
          Gap(12.h),
          Text(
            "A comprehensive platform for skill development and career mentorship",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Colors.grey.shade300,
              height: 1.4,
            ),
          ),
          Gap(44.h),
          Text(
            "Contact Us",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: Colors.blue.shade300,
            ),
          ),
          Gap(12.h),
          Text(
            "info@multiversementor.com",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade400,
              fontSize: 18.sp,
              height: 1.3,
            ),
          ),
          Gap(6.h),
          Text(
            "+966 13 123 4567",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade400,
              fontSize: 18.sp,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class FooterLinks extends StatelessWidget {
  final String title;
  final List<String> items;

  const FooterLinks({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.w,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.font20BoldBlue300),
            Gap(20.h),
            ...items.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Text(item, style: AppTextStyles.font17SemiBoldGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
