import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quiz/core/local_settings/local_settings_bloc.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/theme_constants.dart';
import 'package:quiz/core/utils/di.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LanguageDropdownMenu extends StatelessWidget {
  final String currentLanguage;

  const LanguageDropdownMenu({super.key, required this.currentLanguage});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;
        return DropdownButton<String>(
          value: currentLanguage,
          items: [
            DropdownMenuItem(
              value: 'en',
              child: Text(
                context.l10n.english,
                style: isMobile
                    ? AppTextStyles.font56BoldBlack
                    : AppTextStyles.font26BoldBlack,
              ),
            ),
            DropdownMenuItem(
              value: 'ar',
              child: Text(
                context.l10n.arabic,
                style: isMobile
                    ? AppTextStyles.font56BoldBlack
                    : AppTextStyles.font26BoldBlack,
              ),
            ),
          ],
          onChanged: (String? newValue) async {
            if (newValue != null && newValue != currentLanguage) {
              ThemeConstants.configureEasyLoadingLight();
              getIt<LocalSettingsBloc>().add(ChangeLocale(newValue));
              EasyLoading.dismiss();
            }
          },
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          style: AppTextStyles.font16BlackBold,
          dropdownColor: Colors.white,
          underline: const SizedBox(),
        );
      },
    );
  }
}
