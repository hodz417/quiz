import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';

import 'package:quiz/feature/assessment/bloc/assessment_bloc.dart';
import 'package:quiz/feature/assessment/data/helper/likert_options.dart';
import 'package:quiz/feature/assessment/data/models/assessment_question/assessment_question.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/feature/assessment/ui/widgets/choice_field.dart';
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
    final bloc = context.read<AssessmentBloc>();
    final prevAnswer = bloc.answers[question.id] ?? '';

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile =
            sizingInformation.deviceScreenType == DeviceScreenType.mobile;

        switch (question.kind) {
          case QuestionKind.likert:
            final options = likertOptions(context);
            // use only the labels for display (keeps current behavior)
            final labels = options.map((o) => o['label']!).toList();
            return ChoiceField(
              name: fieldName,
              options: labels,
              isMobile: isMobile,
              initialValue: prevAnswer.isNotEmpty ? prevAnswer : null,
            );

          case QuestionKind.multipleChoice:
            final opts = question.options ?? [];
            return ChoiceField(
              name: fieldName,
              options: opts,
              isMobile: isMobile,
              initialValue: prevAnswer.isNotEmpty ? prevAnswer : null,
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
}
