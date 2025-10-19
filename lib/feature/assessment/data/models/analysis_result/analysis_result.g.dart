// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnalysisResultImpl _$$AnalysisResultImplFromJson(Map<String, dynamic> json) =>
    _$AnalysisResultImpl(
      uiSummary: json['uiSummary'] as String,
      personalityType: json['personalityType'] as String,
      personalityExplanation: json['personalityExplanation'] as String,
      learningStylePercentages: const LearningStyleMapConverter().fromJson(
        json['learningStylePercentages'],
      ),
      inferredGoals: (json['inferredGoals'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      keyStrengths: (json['keyStrengths'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      detailedSummary: json['detailedSummary'] as String,
      personalityDetails: json['personalityDetails'] as String,
      learningStyleDetails: json['learningStyleDetails'] as String,
      goalsDetails: (json['goalsDetails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      strengthsDetails: (json['strengthsDetails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      developmentAreas: (json['developmentAreas'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      careerSuggestions: (json['careerSuggestions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      suggestedSkills: (json['suggestedSkills'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      freelanceJobs: (json['freelanceJobs'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      practicalSteps: (json['practicalSteps'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      inspirationalQuote: json['inspirationalQuote'] as String,
      learningResources: (json['learningResources'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      roadmap: (json['roadmap'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$$AnalysisResultImplToJson(
  _$AnalysisResultImpl instance,
) => <String, dynamic>{
  'uiSummary': instance.uiSummary,
  'personalityType': instance.personalityType,
  'personalityExplanation': instance.personalityExplanation,
  'learningStylePercentages': const LearningStyleMapConverter().toJson(
    instance.learningStylePercentages,
  ),
  'inferredGoals': instance.inferredGoals,
  'keyStrengths': instance.keyStrengths,
  'detailedSummary': instance.detailedSummary,
  'personalityDetails': instance.personalityDetails,
  'learningStyleDetails': instance.learningStyleDetails,
  'goalsDetails': instance.goalsDetails,
  'strengthsDetails': instance.strengthsDetails,
  'developmentAreas': instance.developmentAreas,
  'careerSuggestions': instance.careerSuggestions,
  'suggestedSkills': instance.suggestedSkills,
  'freelanceJobs': instance.freelanceJobs,
  'practicalSteps': instance.practicalSteps,
  'inspirationalQuote': instance.inspirationalQuote,
  'learningResources': instance.learningResources,
  'roadmap': instance.roadmap,
};
