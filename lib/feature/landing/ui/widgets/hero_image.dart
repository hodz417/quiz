import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';



class HeroImage extends StatelessWidget {
  final double width;
  final double height;
  const HeroImage({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 24.r,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      padding: EdgeInsets.all(22.w),
      child: Stack(
        children: [
          Positioned(
            top: 34.h,
            left: 22.w,
            right: 22.w,
            child: Column(
              children: [
                Container(
                  height: 22.h,
                  color: Colors.grey.shade300,
                  margin: EdgeInsets.only(bottom: 12.h),
                ),
                Container(
                  height: 22.h,
                  width: 400.w,
                  color: Colors.grey.shade300,
                  margin: EdgeInsets.only(bottom: 12.h),
                ),
                Container(height: 22.h, color: Colors.grey.shade300),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 140.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 44.w),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          Positioned(
            bottom: 30.h,
            right: 30.w,
            child: Row(
              children: [
                Container(
                  width: 52.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Gap(14.w),
                Container(
                  width: 52.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
