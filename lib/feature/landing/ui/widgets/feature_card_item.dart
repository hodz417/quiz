import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeatureCardItem extends StatefulWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;
  final Gradient? cardGradient;
  final VoidCallback? onTap; // 👈 إضافة

  const FeatureCardItem({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.description,
    this.cardGradient,
    this.onTap, // 👈 إضافة
  });

  @override
  State<FeatureCardItem> createState() => _FeatureCardItemState();
}

class _FeatureCardItemState extends State<FeatureCardItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final gradient = widget.cardGradient ??
        const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 211, 236, 255), Colors.white],
        );

    return GestureDetector( // 👈 إضافة عشان الكارد يبقى clickable
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: 350.w,
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: _isHovered
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
                radius: 40.r,
                child: Icon(widget.icon, size: 32.sp, color: Colors.white),
              ),
              Gap(20.h),
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.black87,
                ),
              ),
              Gap(12.h),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  height: 1.6,
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
