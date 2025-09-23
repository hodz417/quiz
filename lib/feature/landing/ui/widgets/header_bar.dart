import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:mentor/core/local_settings/local_settings_bloc.dart';
import 'package:mentor/core/utils/constants/app_assets.dart';
import 'package:mentor/feature/landing/ui/widgets/language_dropdown_menu.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentLanguage = GetIt.I<LocalSettingsBloc>().state.local;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 36.w,
            vertical: isMobile ? 10.h : 20.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LanguageDropdownMenu(currentLanguage: currentLanguage),

              Image.asset(height: isMobile ? 40.h : 60.h, width: isMobile ? 280.w : 180.w, AppAssets.pngLogo),
            ],
          ),
        );
      },
    );
  }
}
