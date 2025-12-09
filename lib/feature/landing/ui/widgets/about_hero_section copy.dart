import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor/core/utils/theme/app_text_styles.dart';
import 'package:mentor/feature/landing/ui/pages/meet_model.dart';


class AboutHeroSection extends StatelessWidget {
  final PersonsClass person;

  const AboutHeroSection({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),
                    child: Text(
                      person.name,
                      key: ValueKey(person.name),
                      // style: AppTextStyles.font40BlackBold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: Text(
                      person.title,
                      key: ValueKey('${person.name}-title'),
                      // style: AppTextStyles.fontGrey16Bold.copyWith(
                      //   fontWeight: FontWeight.w500,
                      //   fontSize: 18.sp
                      // ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 450),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: Text(
                      person.bio,
                      key: ValueKey('${person.name}-bio'),
                      // style: AppTextStyles.fontGrey16Bold.copyWith(
                      //   fontWeight: FontWeight.w400,
                      //   height: 1.6,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 40.w),
            Expanded(
              flex: 2,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  ),
                  child: child,
                ),
                child: ClipRRect(
                  key: ValueKey(person.image),
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(person.image, fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
