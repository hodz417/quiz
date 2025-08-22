class AnalysisResult {
  final String summary;
  final String personality; // new
  final Map<String, int> learningStylePercentages;
  final List<String> goals; // new
  final List<String> strengths;
  final List<String> developmentAreas;
  final List<String> careerSuggestions;

  AnalysisResult({
    required this.summary,
    required this.personality,
    required this.learningStylePercentages,
    required this.goals,
    required this.strengths,
    required this.developmentAreas,
    required this.careerSuggestions,
  });

  factory AnalysisResult.empty() => AnalysisResult(
        summary: 'No summary',
        personality: '',
        learningStylePercentages: {'Visual': 0, 'Verbal': 0, 'Kinesthetic': 0},
        goals: [],
        strengths: [],
        developmentAreas: [],
        careerSuggestions: [],
      );

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    // helper to ensure int values
    Map<String, int> parseLearning(Map<String, dynamic>? m) {
      if (m == null) return {'Visual': 0, 'Verbal': 0, 'Kinesthetic': 0};
      return {
        'Visual': (m['Visual'] ?? 0) is int ? (m['Visual'] ?? 0) as int : int.tryParse((m['Visual'] ?? '0').toString()) ?? 0,
        'Verbal': (m['Verbal'] ?? 0) is int ? (m['Verbal'] ?? 0) as int : int.tryParse((m['Verbal'] ?? '0').toString()) ?? 0,
        'Kinesthetic': (m['Kinesthetic'] ?? 0) is int ? (m['Kinesthetic'] ?? 0) as int : int.tryParse((m['Kinesthetic'] ?? '0').toString()) ?? 0,
      };
    }

    return AnalysisResult(
      summary: json['summary'] as String? ?? '',
      personality: json['personality'] as String? ?? '',
      learningStylePercentages: parseLearning(json['learningStylePercentages'] as Map<String, dynamic>?),
      goals: (json['goals'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      strengths: (json['strengths'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      developmentAreas: (json['developmentAreas'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      careerSuggestions: (json['careerSuggestions'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
