// question_input_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/feature/chat/bloc/chat_bloc.dart';
import 'package:quiz/feature/chat/data/models/assessment_question/assessment_question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class QuestionInputWidget extends StatelessWidget {
  final AssessmentQuestion question;
  final String fieldName;

  const QuestionInputWidget({
    super.key,
    required this.question,
    this.fieldName = 'answer',
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>();
    final prevAnswer = bloc.answers[question.id] ?? '';

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile =
            sizingInformation.deviceScreenType == DeviceScreenType.mobile;

        switch (question.kind) {
          case QuestionKind.likert:
            return FormBuilderRadioGroup<String>(
              name: fieldName,
              initialValue: prevAnswer.isNotEmpty ? prevAnswer : null,
              decoration: const InputDecoration(border: InputBorder.none),
              orientation: OptionsOrientation.vertical,
              wrapRunSpacing: 20,
              wrapSpacing: 16,
              controlAffinity: ControlAffinity.leading,
              activeColor: Theme.of(context).primaryColor,
              itemDecoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              options: _buildLikertOptions(context, isMobile),
              validator: FormBuilderValidators.required(
                errorText: context.l10n.pleaseSelectOption,
              ),
            );

          case QuestionKind.multipleChoice:
            final opts = question.options ?? [];
            return FormBuilderRadioGroup<String>(
              name: fieldName,
              initialValue: prevAnswer.isNotEmpty ? prevAnswer : null,
              decoration: const InputDecoration(border: InputBorder.none),
              orientation: OptionsOrientation.vertical,
              wrapRunSpacing: 20,
              wrapSpacing: 16,
              controlAffinity: ControlAffinity.leading,
              activeColor: Theme.of(context).primaryColor,
              itemDecoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(16),
              ),
              options: opts
                  .map(
                    (text) => FormBuilderFieldOption<String>(
                      value: text,
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 12,
                          ),
                          child: Text(
                            text,
                       style: isMobile
                      ? AppTextStyles.font30BoldBlack
                      : AppTextStyles.font14Black,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              validator: FormBuilderValidators.required(
                errorText: context.l10n.pleaseSelectOption,
              ),
            );

          case QuestionKind.openEnded:
            return FormBuilderTextField(
              name: fieldName,
              initialValue: prevAnswer,
              maxLines: 4,
              minLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: context.l10n.typeYourAnswer,
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: context.l10n.pleaseTypeYourAnswer,
                ),
                FormBuilderValidators.minLength(
                  2,
                  errorText: context.l10n.minLengthError,
                ),
              ]),
            );
        }
      },
    );
  }

  List<FormBuilderFieldOption<String>> _buildLikertOptions(
    BuildContext context,
    bool isMobile,
  ) {
    final loc = context.l10n;

    final options = [
      {'value': '5', 'label': loc.stronglyAgree},
      {'value': '4', 'label': loc.agree},
      {'value': '3', 'label': loc.neutral},
      {'value': '2', 'label': loc.disagree},
      {'value': '1', 'label': loc.stronglyDisagree},
    ];

    return options
        .map(
          (option) => FormBuilderFieldOption<String>(
            value: option['value']!,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 12,
                ),
                child: Text(
                  option['label']!,
                  style: isMobile
                      ? AppTextStyles.font30BoldBlack
                      : AppTextStyles.font14Black,
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
