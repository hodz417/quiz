// feature/assessment/data/models/analysis_result/analysis_result.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_result.freezed.dart';
part 'analysis_result.g.dart';

/// Normalizes learning styles into canonical {Visual, Verbal, Kinesthetic}
/// with integer values that sum to 100.
class LearningStyleMapConverter
    implements JsonConverter<Map<String, int>, dynamic> {
  const LearningStyleMapConverter();

  static const _vKey = 'Visual';
  static const _verbKey = 'Verbal';
  static const _kinKey = 'Kinesthetic';

  static const Map<String, String> _aliases = {
    // Visual
    'visual': _vKey,
    'spatial': _vKey,
    'visual/spatial': _vKey,

    // Verbal (LLMs often use Auditory/Aural/Reading-Writing)
    'verbal': _verbKey,
    'linguistic': _verbKey,
    'reading/writing': _verbKey,
    'reading-writing': _verbKey,
    'read/write': _verbKey,
    'read & write': _verbKey,
    'aural': _verbKey,
    'auditory': _verbKey,
    'listening': _verbKey,

    // Kinesthetic
    'kinesthetic': _kinKey,
    'kinaesthetic': _kinKey,
    'physical': _kinKey,
    'hands-on': _kinKey,
    'tactile': _kinKey,
    'bodily-kinesthetic': _kinKey,
  };

  int _toInt(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.round();
    if (v is String) {
      final m = RegExp(r'-?\d+').firstMatch(v);
      if (m != null) return int.tryParse(m.group(0)!) ?? 0;
    }
    return 0;
  }

  Map<String, int> _largestRemainderNormalize(
      Map<String, int> input, List<String> keys) {
    // Clamp 0..100 and handle all-zero → default
    final clamped = <String, int>{
      for (final k in keys) k: (input[k] ?? 0).clamp(0, 100),
    };

    final initialSum =
        clamped.values.fold<int>(0, (a, b) => a + b);

    if (initialSum == 0) {
      // Default split
      return {_vKey: 34, _verbKey: 33, _kinKey: 33};
    }

    // Proportional → floor + largest remainders
    final proportions = <String, double>{
      for (final k in keys) k: (clamped[k]! / initialSum) * 100.0,
    };

    final base = <String, int>{
      for (final k in keys) k: proportions[k]!.floor(),
    };
    int used = base.values.fold(0, (a, b) => a + b);

    int remain = 100 - used;
    final remainders = proportions.entries.toList()
      ..sort((a, b) => (b.value - b.value.floor())
          .compareTo(a.value - a.value.floor()));

    for (var i = 0; i < remain; i++) {
      final k = remainders[i % remainders.length].key;
      base[k] = base[k]! + 1;
    }
    return base;
  }

  @override
  Map<String, int> fromJson(dynamic json) {
    // Accept any shape; try to map to canonical keys.
    Map<String, dynamic> raw;
    if (json is Map) {
      raw = json.map((k, v) => MapEntry(k.toString(), v));
    } else {
      raw = {};
    }

    // Start zeros
    final tmp = <String, int>{_vKey: 0, _verbKey: 0, _kinKey: 0};

    // Read canonical keys if present
    for (final k in [_vKey, _verbKey, _kinKey]) {
      if (raw.containsKey(k)) tmp[k] = _toInt(raw[k]);
    }

    // Read aliases
    raw.forEach((k, v) {
      final canon = _aliases[k.trim().toLowerCase()];
      if (canon != null) tmp[canon] = _toInt(v);
    });

    // Normalize to 100
    return _largestRemainderNormalize(tmp, [_vKey, _verbKey, _kinKey]);
  }

  @override
  dynamic toJson(Map<String, int> json) {
    // Ensure canonical keys only
    return <String, int>{
      _vKey: json[_vKey] ?? 0,
      _verbKey: json[_verbKey] ?? 0,
      _kinKey: json[_kinKey] ?? 0,
    };
  }
}

@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult({
    required String uiSummary,
    required String personalityType,
    required String personalityExplanation,

    /// This will ALWAYS be normalized to Visual/Verbal/Kinesthetic that sum to 100.
    @LearningStyleMapConverter()
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

    /// Expect: {'uiList': [...], 'wordList': [...]}
    required Map<String, List<String>> freelanceJobs,

    required List<String> practicalSteps,
    required String inspirationalQuote,

    /// Intentionally kept empty by the model; system fills later.
    required List<Map<String, dynamic>> learningResources,

    /// Expect: {'levelA': [...], 'levelB': [...], 'levelC': [...]}
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
