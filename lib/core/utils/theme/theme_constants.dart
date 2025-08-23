import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ThemeConstants {
  static final horizontalPadding = 10.w;
  static final itemPadding = 9.r;
  static final gap = Gap(25.r);
  static const animationDuration = Duration(milliseconds: 300);

  static void configureEasyLoadingLight() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.light
      ..maskColor = Colors.black.withAlpha((0.5 * 255).toInt())
      ..indicatorColor = Colors.black
      ..textColor = Colors.black
      ..backgroundColor = Colors.white
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void configureEasyLoadingDark() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..maskColor = Colors.white.withAlpha((0.5 * 255).toInt())
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..backgroundColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}
