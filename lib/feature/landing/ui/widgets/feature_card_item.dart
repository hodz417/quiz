import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeatureCardItem extends StatefulWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;
  final Gradient? cardGradient;
  final VoidCallback? onTap;
  final bool isMobile; // معيار جديد لتحديد إذا كان على الموبايل

  const FeatureCardItem({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.description,
    this.cardGradient,
    this.onTap,
    required this.isMobile,
  });

  @override
  State<FeatureCardItem> createState() => _FeatureCardItemState();
}

class _FeatureCardItemState extends State<FeatureCardItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final gradient =
        widget.cardGradient ??
        const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 211, 236, 255), Colors.white],
        );

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: widget.isMobile
              ? 1000.w
              : 350.w, // عرض مختلف للموبايل والديسكتوب
          padding: EdgeInsets.symmetric(
            vertical: widget.isMobile ? 25.h : 18.h,
            horizontal: widget.isMobile ? 20.w : 20.w,
          ),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(widget.isMobile ? 14.r : 16.r),
            boxShadow:
                _isHovered &&
                    !widget
                        .isMobile // تأثير Hover للديسكتوب فقط
                ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: widget.iconBgColor,
                radius: widget.isMobile ? 60.r : 40.r,
                child: Icon(
                  widget.icon,
                  size: widget.isMobile ? 58.sp : 32.sp,
                  color: Colors.white,
                ),
              ),
              Gap(widget.isMobile ? 12.h : 20.h),
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: widget.isMobile ? 50.sp : 20.sp,
                  color: Colors.black87,
                ),
              ),
              Gap(widget.isMobile ? 8.h : 12.h),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: widget.isMobile ? 35.sp : 15.sp,
                  height: widget.isMobile ? 1.5 : 1.6,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
