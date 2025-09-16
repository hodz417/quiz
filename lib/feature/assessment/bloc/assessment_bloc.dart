// feature/assessment/presentation/bloc/assessment_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz/feature/assessment/data/helper/questions_en.dart';
import 'package:quiz/feature/assessment/data/helper/questions_ar.dart';
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart';
import 'package:quiz/feature/assessment/data/models/assessment_question/assessment_question.dart';
import 'package:quiz/feature/assessment/data/repositories/assessment_repository.dart';
import 'package:quiz/core/utils/di.dart';
import 'package:quiz/core/local_settings/local_settings_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quiz/feature/assessment/data/service/firestore_service.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';
part 'assessment_bloc.freezed.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final AssessmentRepository repository;
  final FirestoreService _firestoreService;
  final LocalSettingsBloc _localSettingsBloc;

  final List<Map<String, dynamic>> messages = [];
  final Map<String, String> answers = {};

  List<AssessmentQuestion> levelQuestions = [];
  String? selectedLevel;
  int currentQuestionIndex = 0;
  bool analysisComplete = false;

  AssessmentBloc(this.repository)
      : _firestoreService = getIt<FirestoreService>(),
        _localSettingsBloc = getIt<LocalSettingsBloc>(),
        super(const AssessmentState.initial()) {
    on<AssessmentEvent>((event, emit) async {
      await event.when(
        started: (level) => _onAssessmentStarted(level, emit),
        answerSubmitted: (questionId, answer) => _onAnswerSubmitted(questionId, answer, emit),
        prevQuestion: () => _onPrevQuestion(emit),
        analysisRequested: () => _onAnalysisRequested(emit),
        analysisComplete: (result) => _onAnalysisComplete(result, emit),
        reset: () => _onResetAssessment(emit),
        saveResult: (result) => _onSaveResult(result, emit),
      );
    });
  }

  // Helper method to get the current locale from LocalSettingsBloc
  String get _currentLocale {
    try {
      return _localSettingsBloc.state.local;
    } catch (e) {
      return 'en'; // Fallback to English
    }
  }

  // Helper method to get the right question set based on locale
  List<AssessmentQuestion> get _questions {
    return _currentLocale == 'ar' ? questionsAr : questionsEn;
  }

  double get progress {
    final total = levelQuestions.fold<int>(0, (s, q) => s + q.weight);
    final answered = levelQuestions
        .where((q) => answers.containsKey(q.id))
        .fold<int>(0, (s, q) => s + q.weight);
    if (total == 0) return 0.0;
    return answered / total;
  }

  void _addBot(String content, {bool isLoading = false}) {
    messages.add({
      'sender': 'bot',
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
      'isLoading': isLoading,
    });
  }

  void _addUser(String content) {
    messages.add({
      'sender': 'user',
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
      'isLoading': false,
    });
  }

  FutureOr<void> _onAssessmentStarted(String? level, Emitter<AssessmentState> emit) {
    selectedLevel = level ?? 'Level 1';

    // Use the appropriate question set based on locale
    final questions = _questions;

    // Filter questions by selected level
    switch (selectedLevel) {
      case 'Level 1':
        // Q1 to Q20
        levelQuestions = questions
            .where((q) {
              final idNumber = int.tryParse(
                q.id.replaceAll(RegExp(r'[^0-9]'), ''),
              );
              return idNumber != null && idNumber >= 1 && idNumber <= 20;
            })
            .toList();
        break;
      case 'Level 2':
        // Q1 to Q60
        levelQuestions = questions
            .where((q) {
              final idNumber = int.tryParse(
                q.id.replaceAll(RegExp(r'[^0-9]'), ''),
              );
              return idNumber != null && idNumber >= 1 && idNumber <= 60;
            })
            .toList();
        break;
      case 'Level 3':
        // All questions
        levelQuestions = List.from(questions);
        break;
      default:
        levelQuestions = questions
            .where((q) {
              final idNumber = int.tryParse(
                q.id.replaceAll(RegExp(r'[^0-9]'), ''),
              );
              return idNumber != null && idNumber >= 1 && idNumber <= 20;
            })
            .toList();
    }

    messages.clear();
    answers.clear();
    currentQuestionIndex = 0;
    analysisComplete = false;

    _addBot(
      "Starting $selectedLevel assessment. ${levelQuestions.length} questions.",
    );
    if (levelQuestions.isNotEmpty) {
      final q = levelQuestions[currentQuestionIndex];
      _addBot("[${q.level}] ${q.text}\n(Estimated: ${q.timeSeconds} seconds)");
      emit(
        AssessmentState.loaded(
          messages: List.from(messages),
          currentQuestion: q,
          progress: progress,
          currentIndex: currentQuestionIndex,
        ),
      );
    } else {
      emit(
        AssessmentState.loaded(
          messages: List.from(messages),
          currentQuestion: null,
          progress: 0.0,
          currentIndex: 0,
        ),
      );
    }
  }

  FutureOr<void> _onAnswerSubmitted(
    String questionId,
    String answer,
    Emitter<AssessmentState> emit,
  ) async {
    if (analysisComplete) {
      _addBot("Analysis is already complete. Answers cannot be modified.");
      emit(
        AssessmentState.loaded(
          messages: List.from(messages),
          currentQuestion: null,
          progress: progress,
          currentIndex: currentQuestionIndex,
        ),
      );
      return;
    }

    final idx = currentQuestionIndex;
    if (idx < 0 || idx >= levelQuestions.length) return;
    final currentQ = levelQuestions[idx];

    answers[currentQ.id] = answer;
    _addUser(answer);

    if (messages.isNotEmpty && messages.last['isLoading'] == true) {
      messages.removeLast();
    }

    currentQuestionIndex++;
    if (currentQuestionIndex < levelQuestions.length) {
      final next = levelQuestions[currentQuestionIndex];
      _addBot(
        "[${next.level}] ${next.text}\n(Estimated: ${next.timeSeconds} seconds)",
      );
      emit(
        AssessmentState.loaded(
          messages: List.from(messages),
          currentQuestion: next,
          progress: progress,
          currentIndex: currentQuestionIndex,
        ),
      );
    } else {
      add(const AssessmentEvent.analysisRequested());
    }
  }

  FutureOr<void> _onPrevQuestion(Emitter<AssessmentState> emit) {
    if (analysisComplete) {
      _addBot("Analysis is already complete. You cannot go back.");
      emit(
        AssessmentState.loaded(
          messages: List.from(messages),
          currentQuestion: null,
          progress: progress,
          currentIndex: currentQuestionIndex,
        ),
      );
      return null;
    }
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      final q = levelQuestions[currentQuestionIndex];
      _addBot("Returning to the previous question:\n[${q.level}] ${q.text}");
      emit(
        AssessmentState.loaded(
          messages: List.from(messages),
          currentQuestion: q,
          progress: progress,
          currentIndex: currentQuestionIndex,
        ),
      );
    } else {
      _addBot("You are already at the first question.");
      emit(
        AssessmentState.loaded(
          messages: List.from(messages),
          currentQuestion: levelQuestions.isNotEmpty
              ? levelQuestions.first
              : null,
          progress: progress,
          currentIndex: currentQuestionIndex,
        ),
      );
    }
  }

  Future<void> _onAnalysisRequested(Emitter<AssessmentState> emit) async {
    EasyLoading.show(status: 'Analyzing responses...');

    _addBot("Analyzing responses...", isLoading: true);
    emit(
      AssessmentState.loaded(
        messages: List.from(messages),
        currentQuestion: null,
        progress: progress,
        currentIndex: currentQuestionIndex,
      ),
    );

    try {
      final payload = levelQuestions
          .map(
            (q) => {
              'id': q.id,
              'level': q.level,
              'question': q.text,
              'answer': answers[q.id] ?? '',
              'weight': q.weight,
            },
          )
          .toList();

      final result = await repository.analyzeResponses(payload);
      analysisComplete = true;

      await EasyLoading.dismiss();
      add(AssessmentEvent.analysisComplete(result));
    } catch (e) {
      await EasyLoading.dismiss();
      if (messages.isNotEmpty && messages.last['isLoading'] == true) {
        messages.removeLast();
      }
      _addBot("Analysis failed: ${e.toString()}");
      emit(AssessmentState.error(e.toString()));
    }
  }

  FutureOr<void> _onAnalysisComplete(
    AnalysisResult result,
    Emitter<AssessmentState> emit,
  ) async {
    if (messages.isNotEmpty && messages.last['isLoading'] == true) {
      messages.removeLast();
    }
    
    // Add event to save the result
    add(AssessmentEvent.saveResult(result));
    
    final formatted = '''
${result.uiSummary}

Personality:
${result.personalityType}

Learning Style:
- Visual: ${result.learningStylePercentages['Visual']}%
- Verbal: ${result.learningStylePercentages['Verbal']}%
- Kinesthetic: ${result.learningStylePercentages['Kinesthetic']}%

Goals:
${result.inferredGoals.map((g) => '- $g').join('\n')}

Strengths:
${result.keyStrengths.map((s) => '- $s').join('\n')}

Development Areas:
${result.developmentAreas.map((d) => '- $d').join('\n')}

Career Suggestions:
${result.careerSuggestions.map((c) => '- $c').join('\n')}

Learning Resources:
${result.learningResources.map((r) {
  final name = r['name'] ?? '';
  final description = r['description'] ?? '';
  return '- $name: $description';
}).join('\n')}
''';

    _addBot(formatted);

    emit(
      AssessmentState.analysisComplete(
        result: result,
        messages: List.from(messages),
      ),
    );
  }

  FutureOr<void> _onSaveResult(
    AnalysisResult result,
    Emitter<AssessmentState> emit,
  ) async {
    try {
      await _firestoreService.saveAnalysisResult(
        result: result,
        assessmentLevel: selectedLevel ?? 'Unknown',
      );
      _addBot("Result saved successfully!");
    } catch (e) {
      _addBot("Failed to save result: $e");
      print('Error saving result: $e');
    }
  }

  FutureOr<void> _onResetAssessment(Emitter<AssessmentState> emit) {
    messages.clear();
    answers.clear();
    levelQuestions.clear();
    currentQuestionIndex = 0;
    analysisComplete = false;
    selectedLevel = null;
    emit(const AssessmentState.initial());
  }
}