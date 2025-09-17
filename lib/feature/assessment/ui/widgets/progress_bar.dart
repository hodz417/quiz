import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';
import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/assessment/bloc/assessment_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProgressBar extends StatelessWidget implements PreferredSizeWidget {
  const ProgressBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentBloc, AssessmentState>(
      builder: (ctx, state) {
        // default values
        int currentStep = 0;
        int totalSteps = 1;
        double realProgress = 0.0;
        String progressText = '0%';

        // get bloc instance
        final bloc = BlocProvider.of<AssessmentBloc>(context);

        if (state is AssessmentLoaded) {
          totalSteps = bloc.levelQuestions.length;
          currentStep = state.currentIndex + 1;

          // weighted progress
          realProgress = bloc.progress;
          progressText = '${(realProgress * 100).toStringAsFixed(0)}%';
        } else if (state is AssessmentAnalysisComplete) {
          // when analysis is complete
          realProgress = 1.0;
          progressText = '100%';
          totalSteps = bloc.levelQuestions.length;
          currentStep = totalSteps;
        }

        final barWidth = MediaQuery.of(context).size.width * 0.9;

        return AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              final isMobile = sizingInformation.isMobile;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: barWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${context.l10n.progressQuestion} $currentStep',
                          style: isMobile
                              ? AppTextStyles.font45BoldBlack
                              : AppTextStyles.font14Black,
                        ),
                        Text(
                          progressText,
                          style: isMobile
                              ? AppTextStyles.font45BoldBlue
                              : AppTextStyles.font14LightBlue,
                        ),
                        Text(
                          '${context.l10n.progressOf} $totalSteps',
                          style: isMobile
                              ? AppTextStyles.font45BoldBlack
                              : AppTextStyles.font14Black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: realProgress,
                    minHeight: 8,
                    backgroundColor: AppColors.greyColor.withAlpha(100),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.blueColor,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
