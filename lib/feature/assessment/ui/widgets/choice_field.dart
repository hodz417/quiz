import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/extensions/theme_extension.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';

class ChoiceField extends StatelessWidget {
  final String name;
  final List<String> options;
  final bool isMobile;
  final String? initialValue;

  const ChoiceField({
    super.key,
    required this.name,
    required this.options,
    required this.isMobile,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      initialValue: initialValue,
      validator: FormBuilderValidators.required(
        errorText: context.l10n.pleaseSelectOption,
      ),
      builder: (FormFieldState<String?> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              runSpacing: 18,
              children: options.map((text) {
                final selected = field.value == text;
                return Focus(
                  child: GestureDetector(
                    onTap: () {
                      field.didChange(text);
                    },
                    child: Semantics(
                      selected: selected,
                      button: true,
                      label: text,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 120),
                        width: double.infinity,
                        constraints: const BoxConstraints(minWidth: 150),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.blueColor
                              : AppColors.simpleWhiteColor,
                          border: Border.all(
                            color: selected
                                ? AppColors.blueColor
                                : AppColors.greyColor200,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: AppColors.blueColor.withOpacity(0.12),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          text,
                          style: isMobile
                              ? (selected
                                  ? AppTextStyles.font30BoldBlack.copyWith(
                                      color: AppColors.simpleWhiteColor,
                                    )
                                  : AppTextStyles.font30BoldBlack)
                              : (selected
                                  ? AppTextStyles.font14Black.copyWith(
                                      color: AppColors.simpleWhiteColor,
                                    )
                                  : AppTextStyles.font14Black),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(color: context.theme.colorScheme.error),
                ),
              ),
          ],
        );
      },
    );
  }
}
