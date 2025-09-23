// feature/assessment/presentation/bloc/assessment_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mentor/feature/assessment/data/helper/questions_en.dart';
import 'package:mentor/feature/assessment/data/helper/questions_ar.dart';
import 'package:mentor/feature/assessment/data/models/analysis_result/analysis_result.dart';
import 'package:mentor/feature/assessment/data/models/jop_search/search_model.dart';
import 'package:mentor/feature/assessment/data/models/assessment_question/assessment_question.dart';
import 'package:mentor/feature/assessment/data/repositories/assessment_repository.dart';
import 'package:mentor/core/utils/di.dart';
import 'package:mentor/core/local_settings/local_settings_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mentor/feature/assessment/data/repositories/search_repositories.dart';
import 'package:mentor/feature/assessment/data/service/firestore_service.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';
part 'assessment_bloc.freezed.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final AssessmentRepository repository;
  final FirestoreService _firestoreService;
  final LocalSettingsBloc _localSettingsBloc;
  final SearchRepository _searchRepository;
  final List<Map<String, dynamic>> messages = [];
  final Map<String, String> answers = {};
  List<AssessmentQuestion> levelQuestions = [];
  String? selectedLevel;
  int currentQuestionIndex = 0;
  bool analysisComplete = false;

  AssessmentBloc(this.repository)
      : _firestoreService = getIt<FirestoreService>(),
        _localSettingsBloc = getIt<LocalSettingsBloc>(),
        _searchRepository = SearchRepository(),
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

  String get _currentLocale {
    try {
      return _localSettingsBloc.state.local;
    } catch (e) {
      return 'en';
    }
  }

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
    final questions = _questions;
    switch (selectedLevel) {
      case 'Level 1':
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
      _addBot("[${q.level}] ${q.text} (Estimated: ${q.timeSeconds} seconds)");
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
        "[${next.level}] ${next.text} (Estimated: ${next.timeSeconds} seconds)",
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
      _addBot("Returning to the previous question: [${q.level}] ${q.text}");
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

    // Create an empty list for learning resources - we'll replace AI resources with search results
    List<Map<String, dynamic>> searchLearningResources = [];
    
    // Extract search query from freelance jobs
    String? searchQuery;
    final freelanceJobsList = result.freelanceJobs['uiList'] as List?;
    if (freelanceJobsList != null && freelanceJobsList.isNotEmpty) {
      final firstJob = freelanceJobsList.first.toString().trim();
      if (firstJob.isNotEmpty) {
        searchQuery = "best free online courses or tutorials for $firstJob freelance skills";
      }
    }

    // Fallback if no job found
    if (searchQuery == null || searchQuery.isEmpty) {
      final freelanceJobsWordList = result.freelanceJobs['wordList'] as List?;
      if (freelanceJobsWordList != null && freelanceJobsWordList.isNotEmpty) {
        final firstJobDescription = freelanceJobsWordList.first.toString().split(' - ').firstOrNull ?? "";
        if (firstJobDescription.trim().isNotEmpty) {
          searchQuery = "best free online courses or tutorials for $firstJobDescription freelance skills";
        }
      }
    }

    // Final fallback
    if (searchQuery == null || searchQuery.isEmpty) {
      searchQuery = "freelance skills for beginners";
    }

    // Perform search if query exists
    if (searchQuery.isNotEmpty) {
      try {
        _addBot("Searching for learning resources related to: $searchQuery...");
        emit(
          AssessmentState.loaded(
            messages: List.from(messages),
            currentQuestion: null,
            progress: progress,
            currentIndex: currentQuestionIndex,
          ),
        );

        final searchResultsEither = await _searchRepository.searchQuery(searchQuery);

        await searchResultsEither.fold(
          (error) async {
            _addBot("Could not fetch resources via search: $error");
          },
          (organicResults) async {
            searchLearningResources = organicResults.map((organicResult) {
              return {
                'name': organicResult.title,
                'type': 'Course/Playlist/YouTube/Guide',
                'url': organicResult.link,
                'description': 'Resource found via search for: $searchQuery',
                'lastUpdated': null,
              };
            }).toList();

            if (searchLearningResources.isNotEmpty) {
              _addBot("Found ${searchLearningResources.length} learning resources from search.");
            } else {
              _addBot("Search completed, but no resources were found.");
            }
          },
        );
      } catch (searchError) {
        _addBot("An unexpected error occurred during the search.");
      }
    } else {
      _addBot("No specific freelance job found to search for learning resources.");
    }

    // Create updated result with ONLY search learning resources (replacing AI resources)
    final AnalysisResult updatedResult = result.copyWith(
      learningResources: searchLearningResources, // Use only search results
    );

    // Save the updated result
    add(AssessmentEvent.saveResult(updatedResult));

    // Display the updated result
    final formatted = '''
${updatedResult.uiSummary}
Personality:
${updatedResult.personalityType}
Learning Style:
- Visual: ${updatedResult.learningStylePercentages['Visual']}%
- Verbal: ${updatedResult.learningStylePercentages['Verbal']}%
- Kinesthetic: ${updatedResult.learningStylePercentages['Kinesthetic']}%
Goals:
${updatedResult.inferredGoals.map((g) => '- $g').join('\n')}
Strengths:
${updatedResult.keyStrengths.map((s) => '- $s').join('\n')}
Development Areas:
${updatedResult.developmentAreas.map((d) => '- $d').join('\n')}
Career Suggestions:
${updatedResult.careerSuggestions.map((c) => '- $c').join('\n')}
Learning Resources:
${updatedResult.learningResources.map((r) {
  final name = r['name'] ?? '';
  final description = r['description'] ?? '';
  final url = r['url'] ?? '';
  return '- $name: $description (Link: $url)';
}).join('\n')}
''';

    _addBot(formatted);
    emit(
      AssessmentState.analysisComplete(
        result: updatedResult,
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
      _addBot("Result and learning resources saved successfully!");
    } catch (e) {
      _addBot("Failed to save result: $e");
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