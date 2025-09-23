
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mentor/core/utils/theme/app_text_styles.dart';

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
