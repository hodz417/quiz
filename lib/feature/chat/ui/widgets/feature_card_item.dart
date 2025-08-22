import 'package:flutter/material.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/chat/data/models/assessment_question/assessment_question.dart';

class LikertQuestionWidget extends StatelessWidget {
  final AssessmentQuestion question;
  final ValueChanged<int> onSelected;

  const LikertQuestionWidget({
    super.key,
    required this.question,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: List.generate(5, (index) {
                final value = index + 1;
                return ChoiceChip(
                  label: Text('$value'),
                  selected: false, // Update this based on the selected value
                  onSelected: (selected) {
                    if (selected) {
                      onSelected(value);
                    }
                  },
                  selectedColor: AppColors.blueColor,
                  backgroundColor: AppColors.greyColor.withOpacity(0.2),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MultipleChoiceQuestionWidget extends StatelessWidget {
  final AssessmentQuestion question;
  final ValueChanged<int?> onSelected;

  const MultipleChoiceQuestionWidget({
    Key? key,
    required this.question,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = question.options ?? [];
    return Card(
      color: AppColors.whiteColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Column(
              children: List.generate(options.length, (index) {
                return RadioListTile<int>(
                  title: Text(options[index]),
                  value: index,
                  groupValue: null, // Update this based on the selected value
                  onChanged: (value) {
                    onSelected(value);
                  },
                  activeColor: AppColors.blueColor,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class OpenEndedQuestionWidget extends StatelessWidget {
  final AssessmentQuestion question;
  final TextEditingController controller;

  const OpenEndedQuestionWidget({
    Key? key,
    required this.question,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Type your answer...',
                filled: true,
                fillColor: AppColors.greyColor.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}