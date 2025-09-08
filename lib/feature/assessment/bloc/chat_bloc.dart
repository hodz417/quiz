// chat_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:quiz/core/utils/constants/questions_en.dart';
import 'package:quiz/core/utils/constants/questions_ar.dart';
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart';
import 'package:quiz/feature/assessment/data/models/assessment_question/assessment_question.dart';
import 'package:quiz/feature/assessment/data/repositories/chat_repository.dart';
import 'package:quiz/core/utils/di.dart';
import 'package:quiz/core/local_settings/local_settings_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart'; 

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;

  final List<Map<String, dynamic>> messages = [];
  final Map<String, String> answers = {};

  List<AssessmentQuestion> levelQuestions = [];
  String? selectedLevel;
  int currentQuestionIndex = 0;
  bool analysisComplete = false;

  ChatBloc(this.repository) : super(ChatInitial()) {
    on<ChatStarted>(_onChatStarted);
    on<AnswerSubmitted>(_onAnswerSubmitted);
    on<PrevQuestion>(_onPrevQuestion);
    on<AnalysisRequested>(_onAnalysisRequested);
    on<AnalysisComplete>(_onAnalysisComplete);
    on<ResetChat>(_onResetChat);
  }

  // Helper method to get the current locale from LocalSettingsBloc
  String get _currentLocale {
    try {
      final settingsBloc = getIt<LocalSettingsBloc>();
      return settingsBloc.state.local;
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

  FutureOr<void> _onChatStarted(ChatStarted event, Emitter<ChatState> emit) {
    selectedLevel = event.level ?? 'Level 1';

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
        ChatLoaded(
          messages: List.from(messages),
          currentQuestion: q,
          progress: progress,
          currentIndex: currentQuestionIndex,
        ),
      );
    } else {
      emit(
        ChatLoaded(
          messages: List.from(messages),
          currentQuestion: null,
          progress: 0.0,
          currentIndex: 0,
        ),
      );
    }
  }

  FutureOr<void> _onAnswerSubmitted(
    AnswerSubmitted event,
    Emitter<ChatState> emit,
  ) async {
    if (analysisComplete) {
      _addBot("Analysis is already complete. Answers cannot be modified.");
      emit(
        ChatLoaded(
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

    answers[currentQ.id] = event.answer;
    _addUser(event.answer);

    if (messages.isNotEmpty && messages.last['isLoading'] == true)
      messages.removeLast();

    currentQuestionIndex++;
    if (currentQuestionIndex < levelQuestions.length) {
      final next = levelQuestions[currentQuestionIndex];
      _addBot(
        "[${next.level}] ${next.text}\n(Estimated: ${next.timeSeconds} seconds)",
      );
      emit(
        ChatLoaded(
          messages: List.from(messages),
          currentQuestion: next,
          progress: progress,
          currentIndex: currentQuestionIndex,
        ),
      );
    } else {
      add(AnalysisRequested());
    }
  }

  FutureOr<void> _onPrevQuestion(PrevQuestion event, Emitter<ChatState> emit) {
    if (analysisComplete) {
      _addBot("Analysis is already complete. You cannot go back.");
      emit(
        ChatLoaded(
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
        ChatLoaded(
          messages: List.from(messages),
          currentQuestion: q,
          progress: progress,
          currentIndex: currentQuestionIndex,
        ),
      );
    } else {
      _addBot("You are already at the first question.");
      emit(
        ChatLoaded(
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

  Future<void> _onAnalysisRequested(
    AnalysisRequested event,
    Emitter<ChatState> emit,
  ) async {
    // show easy loading overlay
    EasyLoading.show(status: 'Analyzing responses...');

    _addBot("Analyzing responses...", isLoading: true);
    emit(
      ChatLoaded(
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

      // dismiss easy loading before emitting result
      await EasyLoading.dismiss();

      add(AnalysisComplete(result));
    } catch (e) {
      // dismiss easy loading on error as well
      await EasyLoading.dismiss();
      if (messages.isNotEmpty && messages.last['isLoading'] == true)
        messages.removeLast();
      _addBot("Analysis failed: ${e.toString()}");
      emit(ChatError(e.toString()));
    }
  }

  FutureOr<void> _onAnalysisComplete(
    AnalysisComplete event,
    Emitter<ChatState> emit,
  ) {
    if (messages.isNotEmpty && messages.last['isLoading'] == true)
      messages.removeLast();
    final formatted =
        '''
${event.result.uiSummary}

Personality:
${event.result.personalityType}

Learning Style:
- Visual: ${event.result.learningStylePercentages['Visual']}%
- Verbal: ${event.result.learningStylePercentages['Verbal']}%
- Kinesthetic: ${event.result.learningStylePercentages['Kinesthetic']}

Goals:
${event.result.inferredGoals.map((g) => '- $g').join('\n')}

Strengths:
${event.result.keyStrengths.map((s) => '- $s').join('\n')}

Development Areas:
${event.result.developmentAreas.map((d) => '- $d').join('\n')}

Career Suggestions:
${event.result.careerSuggestions.map((c) => '- $c').join('\n')}
''';
    _addBot(formatted);
    emit(
      AnalysisCompleteState(
        result: event.result,
        messages: List.from(messages),
      ),
    );
  }

  FutureOr<void> _onResetChat(ResetChat event, Emitter<ChatState> emit) {
    messages.clear();
    answers.clear();
    levelQuestions.clear();
    currentQuestionIndex = 0;
    analysisComplete = false;
    selectedLevel = null;
    emit(ChatInitial());
  }
}
