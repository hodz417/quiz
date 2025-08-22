import 'package:freezed_annotation/freezed_annotation.dart';

part 'assessment_question.freezed.dart';
part 'assessment_question.g.dart';

enum QuestionKind {
  likert,
  multipleChoice,
  openEnded,
}

@freezed
class AssessmentQuestion with _$AssessmentQuestion {
  const factory AssessmentQuestion({
    required String id,
    required String level,
    required String text,
    required QuestionKind kind,
    required int weight,
    required int timeSeconds,
    List<String>? options,
  }) = _AssessmentQuestion;

  factory AssessmentQuestion.fromJson(Map<String, dynamic> json) =>
      _$AssessmentQuestionFromJson(json);
}
