import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:quiz/core/local_settings/local_settings_bloc.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:quiz/feature/landing/ui/widgets/language_dropdown_menu.dart';
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
              Text(
                context.l10n.multiverseMentor,
                style: isMobile
                    ? AppTextStyles.font56BoldBlack
                    : AppTextStyles.font26BoldBlack,
              ),
            ],
          ),
        );
      },
    );
  }
}
