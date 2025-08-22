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
          title: "المستوى الأول – الفحص السريع",
          description:
              "عدد الأسئلة: 20\nالمدة: 15 – 20 دقيقة\nالتركيز: التواصل، المبادرة، حل المشكلات، المسؤولية، الفضول",
          onTap: () => _startLevel(context, "Level 1"),
        ),
        FeatureCardItem(
          icon: Icons.insights_outlined,
          iconBgColor: AppColors.greenColor,
          title: "المستوى الثاني – التعمق",
          description:
              "عدد الأسئلة: 40\nالمدة: 30 – 40 دقيقة\nالتركيز: التعاون، القيادة، المرونة، إدارة الوقت، التعامل مع العملاء",
          cardGradient: AppColors.greenLinearGradient,
          onTap: () => _startLevel(context, "Level 2"),
        ),
        FeatureCardItem(
          icon: Icons.star_border_outlined,
          iconBgColor: AppColors.blueColor,
          title: "المستوى الثالث – التحدي الاحترافي",
          description:
              "عدد الأسئلة: 60\nالمدة: أكثر من ساعة\nالتركيز: التفكير الاستراتيجي، الابتكار، التخطيط طويل المدى، العقلية الريادية",
          onTap: () => _startLevel(context, "Level 3"),
        ),
      ],
    );
  }
}
