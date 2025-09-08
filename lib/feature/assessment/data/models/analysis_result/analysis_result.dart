class AnalysisResult {
  // --- Fields for Dual Output ---

  // --- FOR UI SUMMARY CARD ---
  final String uiSummary;

  // --- FOR UI RESULT CARDS ---
  final String personalityType;
  final String personalityExplanation;
  final Map<String, int> learningStylePercentages;
  final List<String> inferredGoals; // For UI Card
  final List<String> keyStrengths;  // For UI Card

  // --- FOR DETAILED WORD REPORT ---
  final String detailedSummary;
  final String personalityDetails;
  final String learningStyleDetails;
  final List<String> goalsDetails;
  final List<String> strengthsDetails;
  final List<String> developmentAreas; // For Detailed Report
  final List<String> careerSuggestions; // For Detailed Report
  final List<String> suggestedSkills; // For Detailed Report

  // --- FOR UI RECOMMENDATIONS & WORD REPORT ---
  final Map<String, List<String>> freelanceJobs; // Keys: 'uiList', 'wordList'

  AnalysisResult({
    required this.uiSummary,
    required this.personalityType,
    required this.personalityExplanation,
    required this.detailedSummary,
    required this.personalityDetails,
    required this.learningStyleDetails,
    required this.goalsDetails,
    required this.strengthsDetails,
    required this.inferredGoals,
    required this.keyStrengths,
    required this.learningStylePercentages,
    required this.developmentAreas,
    required this.careerSuggestions,
    required this.suggestedSkills,
    required this.freelanceJobs,
  });

  factory AnalysisResult.empty() => AnalysisResult(
        uiSummary: 'No summary available.',
        personalityType: 'Explorer',
        personalityExplanation: 'Curious and adaptable.',
        detailedSummary: 'No detailed analysis available.',
        personalityDetails: 'No personality details available.',
        learningStyleDetails: 'No learning style details available.',
        goalsDetails: [],
        strengthsDetails: [],
        inferredGoals: [],
        keyStrengths: [],
        learningStylePercentages: {'Visual': 34, 'Verbal': 33, 'Kinesthetic': 33},
        developmentAreas: [],
        careerSuggestions: [],
        suggestedSkills: [],
        freelanceJobs: {'uiList': [], 'wordList': []},
      );

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    // Helper functions
    Map<String, int> parseLearning(Map<String, dynamic>? m) {
      if (m == null) return {'Visual': 34, 'Verbal': 33, 'Kinesthetic': 33};
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

    // Parse the new freelanceJobs structure
    Map<String, List<String>> parseFreelanceJobs(dynamic v) {
      if (v is Map<String, dynamic>) {
        return {
          'uiList': toStringList(v['uiList']),
          'wordList': toStringList(v['wordList']),
        };
      }
      // Fallback if structure is not as expected
      return {'uiList': [], 'wordList': toStringList(v)};
    }

    return AnalysisResult(
      uiSummary: json['uiSummary']?.toString() ?? 'Summary not available.',
      personalityType: json['personalityType']?.toString() ?? 'Type Unknown',
      personalityExplanation: json['personalityExplanation']?.toString() ?? '',
      detailedSummary: json['detailedSummary']?.toString() ?? 'Detailed summary not available.',
      personalityDetails: json['personalityDetails']?.toString() ?? 'Personality details not available.',
      learningStyleDetails: json['learningStyleDetails']?.toString() ?? 'Learning style details not available.',
      goalsDetails: toStringList(json['goalsDetails']),
      strengthsDetails: toStringList(json['strengthsDetails']),
      inferredGoals: toStringList(json['inferredGoals']),
      keyStrengths: toStringList(json['keyStrengths']),
      learningStylePercentages: parseLearning(json['learningStylePercentages'] as Map<String, dynamic>?),
      developmentAreas: toStringList(json['developmentAreas']),
      careerSuggestions: toStringList(json['careerSuggestions']),
      suggestedSkills: toStringList(json['suggestedSkills']),
      freelanceJobs: parseFreelanceJobs(json['freelanceJobs']),
    );
  }
}