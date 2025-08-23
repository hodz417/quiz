// Updated QuizPage (assessment_screen.dart) to fix the navigation error
// Assume this is assessment_screen.dart based on the file path in error

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

import 'package:quiz/core/utils/theme/app_text_styles.dart';
import 'package:quiz/core/utils/theme/app_theme.dart';
import 'package:quiz/feature/chat/bloc/chat_bloc.dart';
import 'package:quiz/feature/chat/data/models/assessment_question/assessment_question.dart';
import 'package:quiz/feature/result/ui/pages/result_page.dart';

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
      final bloc = context.read<ChatBloc>();
      if (bloc.selectedLevel != widget.selectedLevel) {
        bloc.add(ChatStarted(level: widget.selectedLevel));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final containerHeight = mediaQuery.size.height * 0.8;
    final containerWidth = mediaQuery.size.width * 0.6;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryBg,
        appBar: const ProgressBar(),
        body: BlocConsumer<ChatBloc, ChatState>(
          listener: (ctx, state) {
            if (state is ChatError) {
              ScaffoldMessenger.of(
                ctx,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is AnalysisCompleteState) {
              // Delay navigation to avoid building during build
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (_) => ResultPageWeb(result: state.result),
                  ),
                ).then((_) {
                  ctx.read<ChatBloc>().add(ResetChat());
                });
              });
            }
          },
          builder: (ctx, state) {
            if (state is ChatInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ChatLoaded) {
              final currentQ = state.currentQuestion;
              if (currentQ == null) return const SizedBox.shrink();

              return Center(
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
                          const QuizHeader(),
                          const Gap(35),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  currentQ.text,
                                  style: AppTextStyles.font20SemiBoldBlack,
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(35),
                                Expanded(child: _inputForQuestion(currentQ)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          QuizControlButtons(
                            onPrevious: () {
                              context.read<ChatBloc>().add(PrevQuestion());
                              _formKey.currentState?.reset();
                            },
                            onNext: () => _onNextPressed(currentQ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            // Removed AnalysisCompleteState builder to avoid duplication; navigation handles it
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }

  Widget _inputForQuestion(AssessmentQuestion q) {
    final bloc = context.read<ChatBloc>();
    final prevAnswer = bloc.answers[q.id] ?? '';
    final fieldName = 'answer';

    switch (q.kind) {
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
          options: _buildLikertOptions(),
          validator: FormBuilderValidators.required(
            errorText: 'Please choose a rating',
          ),
        );

      case QuestionKind.multipleChoice:
        final opts = q.options ?? [];
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
                      child: Text(text, style: AppTextStyles.font14Black),
                    ),
                  ),
                ),
              )
              .toList(),
          validator: FormBuilderValidators.required(
            errorText: 'Please select an option',
          ),
        );

      case QuestionKind.openEnded:
        return FormBuilderTextField(
          name: fieldName,
          initialValue: prevAnswer,
          maxLines: 4,
          minLines: 3,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: 'Type your answer...',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(2),
          ]),
        );
    }
  }

  List<FormBuilderFieldOption<String>> _buildLikertOptions() {
    const options = [
      {'value': '5', 'label': 'Strongly Agree'},
      {'value': '4', 'label': 'Agree'},
      {'value': '3', 'label': 'Neutral'},
      {'value': '2', 'label': 'Disagree'},
      {'value': '1', 'label': 'Strongly Disagree'},
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
                child: Text(option['label']!, style: AppTextStyles.font14Black),
              ),
            ),
          ),
        )
        .toList();
  }

  void _onNextPressed(AssessmentQuestion currentQ) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final val = _formKey.currentState!.fields['answer']!.value
          .toString()
          .trim();
      context.read<ChatBloc>().add(
        AnswerSubmitted(currentQ.id, val),
      ); // Bloc sends to Gemini or backend
      _formKey.currentState?.reset();
    } else {}
  }
}

class QuizControlButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const QuizControlButtons({
    super.key,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: onPrevious,
          label: Text('Previous', style: AppTextStyles.font14Black),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        ElevatedButton(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
          child: Text(
            'Next',
            style: AppTextStyles.font14Black.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class QuizHeader extends StatelessWidget {
  const QuizHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Personality Test", style: AppTextStyles.font26BoldBlack),
        const Gap(15),
        Text(
          "We will analyze your personality to help you choose the right career path",
          style: AppTextStyles.font17Grey,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget implements PreferredSizeWidget {
  const ProgressBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (ctx, state) {
        // default values
        int currentStep = 0;
        int totalSteps = 1;
        double realProgress = 0.0;
        String progressText = '0%';

        // get bloc instance
        final bloc = BlocProvider.of<ChatBloc>(context);

        if (state is ChatLoaded) {
          totalSteps = bloc.levelQuestions.length;
          currentStep = state.currentIndex + 1;

          // weighted progress
          realProgress = bloc.progress;
          progressText = '${(realProgress * 100).toStringAsFixed(0)}%';
        } else if (state is AnalysisCompleteState) {
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
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: barWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question $currentStep',
                      style: AppTextStyles.font14Black,
                    ),
                    Text(
                      progressText, // percentage display
                      style: AppTextStyles.font14Black.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueColor,
                      ),
                    ),
                    Text('of $totalSteps', style: AppTextStyles.font14Black),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: realProgress,
                minHeight: 8,
                backgroundColor: AppColors.greyColor.withAlpha(100),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
