import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/chat/ui/pages/assessment_screen.dart';
import 'package:quiz/feature/chat/bloc/chat_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature_card_item.dart';

class FeaturesCards extends StatelessWidget {
  const FeaturesCards({super.key});

  void _startLevel(BuildContext context, String level) {
    context.read<ChatBloc>().add(ChatStarted(level: level));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QuizPage(selectedLevel: level),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 32.w,
      runSpacing: 24.h,
      children: [
        FeatureCardItem(
          icon: Icons.bolt_outlined,
          iconBgColor: AppColors.blueColor,
          title: "Level 1 – Quick Check",
          description:
              "Questions: 20\n"
              "Duration: 15 – 20 minutes\n"
              "Focus: Communication, Initiative, Problem-Solving, Responsibility, Curiosity",
          onTap: () => _startLevel(context, "Level 1"),
        ),
        FeatureCardItem(
          icon: Icons.insights_outlined,
          iconBgColor: AppColors.greenColor,
          title: "Level 2 – In-Depth",
          description:
              "Questions: 40\n"
              "Duration: 30 – 40 minutes\n"
              "Focus: Collaboration, Leadership, Flexibility, Time Management, Customer Handling",
          cardGradient: AppColors.greenLinearGradient,
          onTap: () => _startLevel(context, "Level 2"),
        ),
        FeatureCardItem(
          icon: Icons.star_border_outlined,
          iconBgColor: AppColors.blueColor,
          title: "Level 3 – Professional Challenge",
          description:
              "Questions: 60\n"
              "Duration: More than 1 hour\n"
              "Focus: Strategic Thinking, Innovation, Long-Term Planning, Entrepreneurial Mindset",
          onTap: () => _startLevel(context, "Level 3"),
        ),
      ],
    );
  }
}
