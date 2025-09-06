part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Map<String, dynamic>> messages;
  final AssessmentQuestion? currentQuestion;
  final double progress;
  final int currentIndex;

  ChatLoaded({
    required this.messages,
    required this.currentQuestion,
    required this.progress,
    required this.currentIndex,
  });
}

class AnalysisCompleteState extends ChatState {
  final AnalysisResult result;
  final List<Map<String, dynamic>> messages;

  AnalysisCompleteState({required this.result, required this.messages});
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
