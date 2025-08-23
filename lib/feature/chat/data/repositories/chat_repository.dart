// chat_repository.dart (only relevant method shown/modified)
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:quiz/core/config/config.dart';
import 'package:quiz/feature/chat/data/models/analysis_result/analysis_result.dart';

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

  // ... getChatResponse unchanged ...

  Future<AnalysisResult> analyzeResponses(List<Map<String, dynamic>> responses) async {
    final payload = {'responses': responses};
    final prompt = '''
You are Multiverse Mentor’s AI Assessment Analyzer. Your job is to:
1. Ingest the provided JSON array of responses, each with id, level, question, answer, weight. Assume Likert answers are 1-5 scores (strongly disagree to strongly agree). For multiple-choice, infer sentiment/score if possible. For open-ended, use the text responses.
2. Group questions into competencies (infer themes like Leadership, Communication, Problem-Solving, etc., based on question text).
3. Compute aggregated weighted scores for each competency, normalize to 1-5 scale, and select top 3 competencies with descriptors (e.g., "Leadership: High" if avg >4, "Medium" 3-4, "Low" <3).
4. From open-ended responses (longer answers), extract one key strength and one key area for improvement, with brief supporting quotes.
5. Infer learning style percentages (Visual, Verbal, Kinesthetic) based on dominant competencies and response tones (e.g., descriptive=Visual, explanatory=Verbal, action-oriented=Kinesthetic). Percentages are integers summing to 100.
6. Infer 2-3 realistic career goals from responses.
7. Provide 2-3 tailored recommendations as practical next steps (courses, tasks, activities).
8. Suggest 4-6 concrete **skills to learn** (short phrases, e.g., "React.js", "Figma", "Unit testing") prioritized for the candidate to reach their goals.
9. Suggest 4-6 **freelance job titles or gig types** (e.g., "Frontend Developer - React", "UI/UX Designer - Figma prototyping", "Freelance Data Annotator") that are realistic entry points; optionally add a platform hint like (Upwork, Fiverr) in parentheses.

Produce a precise, insightful analysis in English and return ONLY valid JSON that exactly matches the schema below. Keep the report concise.

Required output JSON schema:
{
  "summary": "A concise 2-3 sentence summary describing the candidate's overall performance and profile, including top 3 competencies.",
  "personality": "A short professional personality profile relevant to work behavior based on top competencies (e.g. detail-oriented problem solver).",
  "learningStylePercentages": {
    "Visual": 0,
    "Verbal": 0,
    "Kinesthetic": 0
  },
  "goals": ["List", "of", "realistic", "career_or_learning_goals"],
  "strengths": ["List", "of", "core", "strengths with quotes if applicable"],
  "developmentAreas": ["List", "of", "priority", "development", "areas with quotes if applicable"],
  "careerSuggestions": ["List", "of", "suitable", "career", "paths or recommendations"],
  "suggestedSkills": ["skill 1", "skill 2", "skill 3"],
  "freelanceJobs": ["job 1", "job 2", "job 3"]
}

Instructions:
- Output ONLY the JSON object (no surrounding text).
- Base inferences on the provided questions and answers.
- Keep lists concise (3-6 items each) and practical.

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

      // NEW sanitization for added fields
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
