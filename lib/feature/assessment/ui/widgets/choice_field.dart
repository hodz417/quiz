import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mentor/core/utils/extensions/l10n_extension.dart';
import 'package:mentor/core/utils/theme/app_text_styles.dart';
import 'package:mentor/core/utils/extensions/theme_extension.dart';
import 'package:mentor/core/utils/theme/app_theme.dart';
import 'dart:math' as math;

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
    // estimated per-item height to compute a sensible max height on mobile
    const double estimatedItemHeight = 72; // tweak if your padding/font changes
    final maxHeight = math.min(
      options.length * estimatedItemHeight,
      MediaQuery.of(context).size.height * 0.45,
    );

    return FormBuilderField<String>(
      name: name,
      initialValue: initialValue,
      validator: FormBuilderValidators.required(
        errorText: context.l10n.pleaseSelectOption,
      ),
      builder: (FormFieldState<String?> field) {
        // map options to widgets
        final List<Widget> items = List.generate(options.length, (index) {
          final text = options[index];
          final selected = field.value == text;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Focus(
              child: GestureDetector(
                onTap: () => field.didChange(text),
                child: Semantics(
                  selected: selected,
                  button: true,
                  label: text,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    width: double.infinity,
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
                                ? AppTextStyles.font45BoldWhite
                                : AppTextStyles.font45BoldBlack)
                          : (selected
                                ? AppTextStyles.font14White
                                : AppTextStyles.font14Black),
                    ),
                  ),
                ),
              ),
            ),
          );
        });

        // Build final layout:
        // - On mobile: put the scrollable list inside Flexible so it can take available space and scroll
        // - On larger screens: use a simple Column (vertical, non-scrollable)
        final Widget content = isMobile
            ? Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: items.length,
                    itemBuilder: (_, i) => items[i],
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: items,
              );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // when `content` is Flexible it will expand inside this Column properly
            content,
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
