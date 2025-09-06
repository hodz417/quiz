import 'package:flutter/material.dart';

class AppColors {
  static const Color whiteColor = Color(0xFFFAFDFF);
  static const Color simpleWhiteColor = Colors.white;
  static const Color kPrimaryBg = Color(0xFFE6F2FF);

  static final Color blue700 = Colors.blue.shade700;
  static final Color blue900 = Colors.blue.shade900;
  static final Color blueColor = Colors.blue;
  static final Color greenColor = Colors.green;

  static final Color greyColor = Colors.grey;

  static final Color greyColor200 = Colors.grey.shade200;

  static const LinearGradient greenLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 203, 252, 206), Colors.white],
  );
  static final Color blackColor = Colors.black;

  static const Color darkBlackColor = Color(0xFF0B1426);

  static const Color primary = Color(0xFF1E88E5);
  static final Color primary700 = Colors.blue.shade700;
  static final Color primary900 = Colors.blue.shade900;

  static const Color selectedColor = primary;
  static const Color defaultBorderColor = Color(0xFFF1F2F4);
}
