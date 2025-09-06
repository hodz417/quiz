// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssessmentQuestionImpl _$$AssessmentQuestionImplFromJson(
  Map<String, dynamic> json,
) => _$AssessmentQuestionImpl(
  id: json['id'] as String,
  level: json['level'] as String,
  text: json['text'] as String,
  kind: $enumDecode(_$QuestionKindEnumMap, json['kind']),
  weight: (json['weight'] as num).toInt(),
  timeSeconds: (json['timeSeconds'] as num).toInt(),
  options: (json['options'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$AssessmentQuestionImplToJson(
  _$AssessmentQuestionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'level': instance.level,
  'text': instance.text,
  'kind': _$QuestionKindEnumMap[instance.kind]!,
  'weight': instance.weight,
  'timeSeconds': instance.timeSeconds,
  'options': instance.options,
};

const _$QuestionKindEnumMap = {
  QuestionKind.likert: 'likert',
  QuestionKind.multipleChoice: 'multipleChoice',
  QuestionKind.openEnded: 'openEnded',
};
