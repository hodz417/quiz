import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 16,
          right: 16,
          child: SafeArea(
            child: Material(
              // Material + elevation so it has a nice shadow and ripple if using Ink
              color: Colors.transparent,
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: DonationButton(), // your existing DonationButton widget
            ),
          ),
        ),
      ],
    );
  }
}

// The custom donation button widget with blue theme
class DonationButton extends StatelessWidget {
  const DonationButton({super.key});

  // Blue theme colors
  static final Color backgroundColor = AppColors.blue900;
  static const Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              final uri = Uri.parse(
                "https://buymeacoffee.com/multiversementor",
              );
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Could not open donation page'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Container(
              width: 190.w,
              height: isMobile ? 45.h : 60.h,
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: isMobile
                  ? Icon(Icons.coffee, color: textColor, size: 50.w)
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Buy Us a Coffee',
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Gap(4.w),
                        Icon(Icons.coffee, color: textColor, size: 24.w),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
