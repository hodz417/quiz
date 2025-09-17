// feature/assessment/presentation/bloc/assessment_event.dart
part of 'assessment_bloc.dart';

@freezed
class AssessmentEvent with _$AssessmentEvent {
  const factory AssessmentEvent.started({String? level}) = AssessmentStarted;
  const factory AssessmentEvent.answerSubmitted(String questionId, String answer) = AnswerSubmitted;
  const factory AssessmentEvent.prevQuestion() = PrevQuestion;
  const factory AssessmentEvent.analysisRequested() = AnalysisRequested;
  const factory AssessmentEvent.saveResult(AnalysisResult result) = _SaveResult;
  const factory AssessmentEvent.analysisComplete(AnalysisResult result) = AnalysisComplete;
  const factory AssessmentEvent.reset() = ResetAssessment;
}