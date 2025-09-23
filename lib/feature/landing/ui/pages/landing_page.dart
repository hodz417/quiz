import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mentor/feature/landing/ui/widgets/header_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';


import 'package:mentor/feature/landing/ui/widgets/footer_section.dart';
import 'package:mentor/feature/landing/ui/widgets/hero_section.dart';
import 'package:mentor/feature/landing/ui/widgets/how_work_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final bool isMobile = sizingInformation.isMobile;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                HeaderBar(),
                HeroSection(),
                Gap(isMobile ? 24.h : 48.h), 
                HowItWorksSection(),
                Gap(isMobile ? 36.h : 72.h),

                if (!isMobile) FooterSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
