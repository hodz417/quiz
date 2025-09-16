// feature/assessment/data/models/analysis_result/analysis_result.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_result.freezed.dart';
part 'analysis_result.g.dart';

/// نموذج واحد فقط لنتيجة التحليل (بدون موديلات فرعية منفصلة).
@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult({
    required String uiSummary,
    required String personalityType,
    required String personalityExplanation,
    required Map<String, int> learningStylePercentages,
    required List<String> inferredGoals,
    required List<String> keyStrengths,
    required String detailedSummary,
    required String personalityDetails,
    required String learningStyleDetails,
    required List<String> goalsDetails,
    required List<String> strengthsDetails,
    required List<String> developmentAreas,
    required List<String> careerSuggestions,
    required List<String> suggestedSkills,
    /// خريطة لقوائم الوظائف الحرة حسب فئاتها
    required Map<String, List<String>> freelanceJobs,
    required List<String> practicalSteps,
    required String inspirationalQuote,
    /// موارد التعلم كقائمة خرائط (يمكن أن تمثل أي بنية JSON لكل مورد)
    required List<Map<String, dynamic>> learningResources,
    /// الخريطة العامة للـ roadmap: على سبيل المثال {"levelA": [...], "levelB": [...], "levelC": [...]}
    required Map<String, List<String>> roadmap,
  }) = _AnalysisResult;

  factory AnalysisResult.empty() => const AnalysisResult(
        uiSummary: 'No summary available.',
        personalityType: 'Explorer',
        personalityExplanation: 'Curious and adaptable.',
        learningStylePercentages: {'Visual': 34, 'Verbal': 33, 'Kinesthetic': 33},
        inferredGoals: [],
        keyStrengths: [],
        detailedSummary: 'No detailed analysis available.',
        personalityDetails: 'No personality details available.',
        learningStyleDetails: 'No learning style details available.',
        goalsDetails: [],
        strengthsDetails: [],
        developmentAreas: [],
        careerSuggestions: [],
        suggestedSkills: [],
        freelanceJobs: {'uiList': [], 'wordList': []},
        practicalSteps: [],
        inspirationalQuote: 'Believe in yourself and all that you are.',
        learningResources: [],
        roadmap: {'levelA': [], 'levelB': [], 'levelC': []},
      );

  factory AnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultFromJson(json);
}
