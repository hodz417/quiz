
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mentor/core/utils/extensions/l10n_extension.dart';
import 'package:mentor/core/utils/theme/app_text_styles.dart';
import 'package:mentor/core/utils/theme/app_theme.dart';

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
                context.l10n.multiverseMentor,
                style: AppTextStyles.font22BlueSemiBold,
              ),
              Gap(12.w),
              Icon(Icons.public, color: AppColors.blue700, size: 28.sp),
            ],
          ),
          Gap(12.h),
          Text(
            context.l10n.footerPlatformDescription,
            style: AppTextStyles.font16Grey
          ),
          Gap(44.h),
          Text(
            context.l10n.footerContactUs,
            style: AppTextStyles.font18BoldBlue300
          ),
          Gap(12.h),
          Text(
            context.l10n.footerContactEmail,
            style: AppTextStyles.font18Grey300
          ),
          Gap(6.h),
          Text(
            context.l10n.footerContactPhone,
            style: AppTextStyles.font18Grey300
          ),
          
        ],
      ),
    );
  }
}
