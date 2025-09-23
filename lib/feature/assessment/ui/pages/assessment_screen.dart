// assessment_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mentor/core/utils/extensions/l10n_extension.dart';
import 'package:mentor/core/utils/theme/app_text_styles.dart';
import 'package:mentor/core/utils/theme/app_theme.dart';
import 'package:mentor/feature/assessment/bloc/assessment_bloc.dart';
import 'package:mentor/feature/assessment/data/models/assessment_question/assessment_question.dart';
import 'package:mentor/feature/assessment/ui/widgets/progress_bar.dart';
import 'package:mentor/feature/assessment/ui/widgets/question_input.dart';
import 'package:mentor/feature/assessment/ui/widgets/quiz_control_buttons.dart';
import 'package:mentor/feature/result/ui/pages/result_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

class QuizPage extends StatefulWidget {
  final String selectedLevel;
  const QuizPage({super.key, required this.selectedLevel});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<AssessmentBloc>();
      if (bloc.selectedLevel != widget.selectedLevel) {
        bloc.add(AssessmentStarted(level: widget.selectedLevel));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile =
            sizingInformation.deviceScreenType == DeviceScreenType.mobile;
        final mediaQuery = MediaQuery.of(context);
        final containerHeight = isMobile
            ? mediaQuery.size.height * 0.70
            : mediaQuery.size.height * 0.75;
        final containerWidth = isMobile
            ? mediaQuery.size.width * 0.95
            : mediaQuery.size.width * 0.6;

        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.kPrimaryBg,
            appBar: const ProgressBar(),
            body: BlocConsumer<AssessmentBloc, AssessmentState>(
              listener: (ctx, state) {
                try {
                  if (state is AssessmentLoaded) {
                    final hasLoading = state.messages.any(
                      (m) => m['isLoading'] == true,
                    );
                    if (hasLoading) {
                      EasyLoading.show(status: context.l10n.loading);
                    } else {
                      EasyLoading.dismiss();
                    }
                  } else if (state is AssessmentAnalysisComplete) {
                    // ensure loading dismissed before navigation
                    EasyLoading.dismiss();
                  } else if (state is AssessmentError) {
                    EasyLoading.dismiss();
                  } else if (state is AssessmentInitial) {
                    EasyLoading.dismiss();
                  }
                } catch (_) {}

                if (state is AssessmentError) {
                  ScaffoldMessenger.of(
                    ctx,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }

                if (state is AssessmentAnalysisComplete) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      ctx,
                      MaterialPageRoute(
                        builder: (_) => ResultPageWeb(result: state.result),
                      ),
                    ).then((_) {
                      ctx.read<AssessmentBloc>().add(ResetAssessment());
                    });
                  });
                }
              },
              builder: (ctx, state) {
                if (state is AssessmentInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AssessmentLoaded) {
                  final currentQ = state.currentQuestion;
                  if (currentQ == null) {
                    // if currentQuestion is null but messages include loading,
                    // we rely on EasyLoading overlay (already handled in listener)
                    return const SizedBox.shrink();
                  }

                  return Center(
                    child: Focus(
                      autofocus: true,
                      onKey: (FocusNode node, RawKeyEvent event) {
                        // only handle key down to avoid double firing
                        if (event is RawKeyDownEvent) {
                          final isEnter =
                              event.logicalKey == LogicalKeyboardKey.enter ||
                              event.logicalKey ==
                                  LogicalKeyboardKey.numpadEnter;
                          if (isEnter) {
                            // Avoid submitting when question is open-ended (to allow newline)
                            if (currentQ.kind == QuestionKind.openEnded) {
                              return KeyEventResult.ignored;
                            }

                            // call your existing next handler which validates & submits
                            _onNextPressed(currentQ);
                            return KeyEventResult.handled;
                          }
                        }
                        return KeyEventResult.ignored;
                      },
                      child: Container(
                        height: containerHeight,
                        width: containerWidth,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: FormBuilder(
                            key: _formKey,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Gap(20.h),
                                      Text(
                                        currentQ.text,
                                        style: isMobile
                                            ? AppTextStyles.font56BoldBlack
                                            : AppTextStyles.font20SemiBoldBlack,
                                        textAlign: TextAlign.center,
                                      ),
                                      const Gap(35),
                                      Expanded(
                                        child: QuestionInputWidget(
                                          question: currentQ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                QuizControlButtons(
                                  onPrevious: () {
                                    context.read<AssessmentBloc>().add(
                                      PrevQuestion(),
                                    );
                                    _formKey.currentState?.reset();
                                  },
                                  onNext: () => _onNextPressed(currentQ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // localized unknown state
                return Center(child: Text(""));
              },
            ),
          ),
        );
      },
    );
  }

  void _onNextPressed(AssessmentQuestion currentQ) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final val = _formKey.currentState!.fields['answer']!.value
          .toString()
          .trim();
      context.read<AssessmentBloc>().add(
        AnswerSubmitted(currentQ.id, val),
      ); // Bloc sends to Gemini or backend
      _formKey.currentState?.reset();
    } else {}
  }
}
