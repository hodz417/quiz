import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:quiz/core/config/config.dart';
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart';

class ChatRepository {
  final GenerativeModel chatModel;
  final GenerativeModel analysisModel;

  ChatRepository()
      : chatModel = GenerativeModel(
          model: AppConfig.chatModel,
          apiKey: AppConfig.geminiApiKey,
          generationConfig: AppConfig.chatGenerationConfig,
        ),
        analysisModel = GenerativeModel(
          model: AppConfig.analysisModel,
          apiKey: AppConfig.geminiApiKey,
          generationConfig: AppConfig.analysisGenerationConfig,
        );

  Future<AnalysisResult> analyzeResponses(List<Map<String, dynamic>> responses) async {
    final payload = {'responses': responses};
    final prompt = '''
You are Multiverse Mentor's AI Assessment Analyzer. Your job is to analyze assessment responses and provide output in ENGLISH ONLY.

Perform these tasks:
1. Process the JSON array of responses with id, level, question, answer, weight
2. Group questions into competencies (e.g., Leadership, Communication, Problem-Solving)
3. Compute weighted scores for each competency (normalized to 1-5 scale)
4. Extract key strengths and areas for improvement from open-ended responses
5. Infer learning style percentages (Visual, Verbal, Kinesthetic)
6. Infer realistic career goals
7. Provide tailored recommendations
8. Suggest specific skills to learn
9. Suggest freelance job titles

OUTPUT REQUIREMENTS:
- All output must be in ENGLISH only
- Use exactly this JSON structure:
{
  "summary": "English summary here",
  "personality": "English personality description",
  "learningStylePercentages": {"Visual": 0, "Verbal": 0, "Kinesthetic": 0},
  "goals": ["English goal 1", "English goal 2"],
  "strengths": ["English strength 1", "English strength 2"],
  "developmentAreas": ["English area 1", "English area 2"],
  "careerSuggestions": ["English suggestion 1", "English suggestion 2"],
  "suggestedSkills": ["English skill 1", "English skill 2"],
  "freelanceJobs": ["English job 1", "English job 2"]
}

Input data (JSON):
${jsonEncode(payload)}
''';

    try {
      final response = await analysisModel.generateContent([Content.text(prompt)]);
      var jsonText = (response.text ?? '').trim();

      // Extract codeblock JSON if present
      final fenceRegex = RegExp(r'```(?:json)?\s*([\s\S]*?)```', multiLine: true);
      final fenceMatch = fenceRegex.firstMatch(jsonText);
      if (fenceMatch != null) {
        jsonText = fenceMatch.group(1)!.trim();
      }

      // Extract first JSON object if there is extra prose
      final objRegex = RegExp(r'\{[\s\S]*\}');
      final objMatch = objRegex.firstMatch(jsonText);
      if (objMatch != null) {
        jsonText = objMatch.group(0)!;
      }

      final parsedRaw = jsonDecode(jsonText) as Map<String, dynamic>;

      // Normalize learning style percentages
      Map<String, int> normalizeLearning(Map<String, dynamic>? m) {
        if (m == null) return {'Visual': 34, 'Verbal': 33, 'Kinesthetic': 33};
        int toInt(dynamic v) {
          if (v == null) return 0;
          if (v is int) return v;
          if (v is double) return v.round();
          if (v is String) return int.tryParse(v.replaceAll('%', '').trim()) ?? 0;
          return 0;
        }

        var visual = toInt(m['Visual']);
        var verbal = toInt(m['Verbal']);
        var kin = toInt(m['Kinesthetic']);

        var total = visual + verbal + kin;
        if (total == 0) {
          return {'Visual': 34, 'Verbal': 33, 'Kinesthetic': 33};
        }

        double scale = 100 / total;
        int v1 = (visual * scale).floor();
        int v2 = (verbal * scale).floor();
        int v3 = (kin * scale).floor();
        int sum = v1 + v2 + v3;
        int rem = 100 - sum;
        List<MapEntry<String,int>> entries = [
          MapEntry('Visual', v1),
          MapEntry('Verbal', v2),
          MapEntry('Kinesthetic', v3),
        ];
        for (int i = 0; i < rem; i++) {
          entries[i % entries.length] = MapEntry(entries[i % entries.length].key, entries[i % entries.length].value + 1);
        }
        return {
          entries[0].key: entries[0].value,
          entries[1].key: entries[1].value,
          entries[2].key: entries[2].value,
        };
      }

      // sanitize lists
      List<String> toStringList(dynamic v) {
        if (v == null) return [];
        if (v is List) return v.map((e) => e.toString()).toList();
        return [v.toString()];
      }

      final sanitized = <String, dynamic>{};
      sanitized.addAll(parsedRaw);
      sanitized['learningStylePercentages'] = normalizeLearning(parsedRaw['learningStylePercentages'] as Map<String, dynamic>?);
      sanitized['goals'] = toStringList(parsedRaw['goals']);
      sanitized['strengths'] = toStringList(parsedRaw['strengths']);
      sanitized['developmentAreas'] = toStringList(parsedRaw['developmentAreas']);
      sanitized['careerSuggestions'] = toStringList(parsedRaw['careerSuggestions']);
      sanitized['suggestedSkills'] = toStringList(parsedRaw['suggestedSkills']);
      sanitized['freelanceJobs'] = toStringList(parsedRaw['freelanceJobs']);
      sanitized['summary'] = (parsedRaw['summary'] ?? '').toString();
      sanitized['personality'] = (parsedRaw['personality'] ?? '').toString();

      return AnalysisResult.fromJson(sanitized);
    } catch (e, st) {
      print('analyzeResponses error: $e\n$st');
      return AnalysisResult.empty();
    }
  }
}