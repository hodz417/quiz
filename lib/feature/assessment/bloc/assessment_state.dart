
// assessment_state.dart
part of 'assessment_bloc.dart';

@freezed
class AssessmentState with _$AssessmentState {
  const factory AssessmentState.initial() = AssessmentInitial;
  
  const factory AssessmentState.loading() = AssessmentLoading;
  
  const factory AssessmentState.loaded({
    required List<Map<String, dynamic>> messages,
    required AssessmentQuestion? currentQuestion,
    required double progress,
    required int currentIndex,
  }) = AssessmentLoaded;
  
  const factory AssessmentState.analysisComplete({
    required AnalysisResult result,
    required List<Map<String, dynamic>> messages,
  }) = AssessmentAnalysisComplete;
  
  const factory AssessmentState.error(String message) = AssessmentError;
}