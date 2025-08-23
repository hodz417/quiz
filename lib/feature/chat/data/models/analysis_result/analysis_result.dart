// lib/feature/chat/data/models/analysis_result.dart
class AnalysisResult {
  final String summary;
  final String personality;
  final Map<String, int> learningStylePercentages;
  final List<String> goals;
  final List<String> strengths;
  final List<String> developmentAreas;
  final List<String> careerSuggestions;

  // NEW fields
  final List<String> suggestedSkills; // skills to learn (short actionable)
  final List<String> freelanceJobs; // suggested freelance job titles / gigs

  AnalysisResult({
    required this.summary,
    required this.personality,
    required this.learningStylePercentages,
    required this.goals,
    required this.strengths,
    required this.developmentAreas,
    required this.careerSuggestions,
    required this.suggestedSkills,
    required this.freelanceJobs,
  });

  factory AnalysisResult.empty() => AnalysisResult(
        summary: 'No summary',
        personality: '',
        learningStylePercentages: {'Visual': 0, 'Verbal': 0, 'Kinesthetic': 0},
        goals: [],
        strengths: [],
        developmentAreas: [],
        careerSuggestions: [],
        suggestedSkills: [],
        freelanceJobs: [],
      );

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    Map<String, int> parseLearning(Map<String, dynamic>? m) {
      if (m == null) return {'Visual': 0, 'Verbal': 0, 'Kinesthetic': 0};
      int toInt(dynamic v) {
        if (v == null) return 0;
        if (v is int) return v;
        if (v is double) return v.round();
        if (v is String) return int.tryParse(v.replaceAll('%', '').trim()) ?? 0;
        return 0;
      }

      return {
        'Visual': toInt(m['Visual']),
        'Verbal': toInt(m['Verbal']),
        'Kinesthetic': toInt(m['Kinesthetic']),
      };
    }

    List<String> toStringList(dynamic v) {
      if (v == null) return [];
      if (v is List) return v.map((e) => e.toString()).toList();
      return [v.toString()];
    }

    return AnalysisResult(
      summary: json['summary']?.toString() ?? '',
      personality: json['personality']?.toString() ?? '',
      learningStylePercentages: parseLearning(json['learningStylePercentages'] as Map<String, dynamic>?),
      goals: toStringList(json['goals']),
      strengths: toStringList(json['strengths']),
      developmentAreas: toStringList(json['developmentAreas']),
      careerSuggestions: toStringList(json['careerSuggestions']),
      suggestedSkills: toStringList(json['suggestedSkills']),
      freelanceJobs: toStringList(json['freelanceJobs']),
    );
  }
}
