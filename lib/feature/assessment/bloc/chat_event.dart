part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ChatStarted extends ChatEvent {
  final String? level;
  ChatStarted({this.level});
}

class AnswerSubmitted extends ChatEvent {
  final String questionId;
  final String answer;
  AnswerSubmitted(this.questionId, this.answer);
}

class PrevQuestion extends ChatEvent {}

class AnalysisRequested extends ChatEvent {}

class AnalysisComplete extends ChatEvent {
  final AnalysisResult result;
  AnalysisComplete(this.result);
}

class ResetChat extends ChatEvent {}
