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
You are Multiverse Mentor's AI Assessment Analyzer. Your job is to deeply analyze assessment responses and provide output in ENGLISH ONLY. You will analyze 120 questions covering learning habits, problem-solving, collaboration, adaptability, and advanced skills.

**INPUT DATA FORMAT:**
You will receive a JSON array of responses. Each response object has:
- `id`: Question ID (e.g., 'Q1')
- `level`: Difficulty/Theme (e.g., 'المستوى 1', 'المستوى 2', 'المستوى 3')
- `question`: The text of the question in Arabic.
- `answer`: The user's answer. For Likert scale (Questions ending in numbers 1,2,4,6,8,10,11,13,14,16,18,20,21,23,24,26,28,29,31,33,35,36,38,41,43,44,46,48,49,51,53,55,56,58,60,62,64,65,66,68,70,71,73,74,76,78,79,82,84,86,88,90,92,94,96,98,100,102,104,106,108,110,112,113,115,116,118): This will be a number (1-5).
- `weight`: The importance score of the question (1-5).
- `options`: (For multiple choice questions like 3,5,12,17,19,22,25,30,34,38,42,47,50,54,59,61,67,69,72,77,80,83,85,87,89,91,93,95,97,99,101,103,105,107,109,111,114,117,119,120) - The list of possible answers presented to the user.

**YOUR TASKS:**

1.  **Process Input:** Carefully read the JSON array of responses.
2.  **Competency Grouping:** Group responses thematically into core competencies like:
    - Learning Agility & Habits
    - Problem-Solving & Critical Thinking
    - Collaboration & Communication
    - Adaptability & Resilience
    - Self-Direction & Motivation
    - Leadership & Initiative
    - Technical & Practical Skills
3.  **Score Calculation:** Compute weighted scores for each competency based on Likert answers and inferred meaning from multiple-choice/open-ended answers. Normalize scores to a 1-5 scale.
4.  **Deep Insights Extraction:** From open-ended and multiple-choice answers, extract:
    - Explicitly stated or strongly implied user goals.
    - Concrete examples of strengths demonstrated.
    - Specific areas mentioned for improvement or observed from responses.
5.  **Personality Typing:** Based on the overall pattern of responses, infer a distinct personality *type*. Use a clear, descriptive label (e.g., "The Analytical Planner", "The Creative Explorer", "The Collaborative Executor"). Base this on dominant traits observed (e.g., Big Five: openness, conscientiousness, extraversion, agreeableness, neuroticism aspects, or custom traits like risk-taking, curiosity, structure-preference). Provide only the label for the UI.
6.  **Learning Style Inference:** Analyze responses to determine the dominant learning styles. Calculate approximate percentages for Visual, Verbal, and Kinesthetic styles. Base this on specific question responses (e.g., Q3 options, Q19 environment, Q38 method preference).
7.  **Dual Output Generation:**
    - **A. Concise UI Output:** Generate content optimized for quick reading on a mobile/web UI. Focus on key points.
    - **B. Detailed Word Output:** Generate comprehensive content for a downloadable report.

**OUTPUT REQUIREMENTS (Strictly ENGLISH, Valid JSON):**
Output ONLY a single, valid JSON object with the EXACT structure below. Do not include any other text, markdown, or explanations.

{
  // --- FOR UI SUMMARY CARD ---
  "uiSummary": "A very short, engaging summary (1-2 sentences) capturing the core essence of the user's profile.",

  // --- FOR UI RESULT CARDS ---
  // Personality Card: Show only the type
  "personalityType": "The clear, descriptive personality type label (e.g., 'The Strategic Innovator').",

  // Learning Style Card: Show percentages
  "learningStylePercentages": {
    "Visual": 0, // Integer 0-100
    "Verbal": 0, // Integer 0-100
    "Kinesthetic": 0 // Integer 0-100
  },

  // Goals Card: Show 2-3 short, clear goals
  "inferredGoals": ["Goal 1", "Goal 2", "Goal 3"],

  // Strengths Card: Show 2-3 key strengths
  "keyStrengths": ["Strength 1", "Strength 2", "Strength 3"],

  // --- FOR DETAILED WORD REPORT ---
  "detailedSummary": "A comprehensive summary (4-6 paragraphs) covering overall profile, strengths, areas for growth, learning preferences, and potential directions.",
  "personalityDetails": "An expanded description (2-3 paragraphs) of the personality type, including characteristics, potential work styles, and implications.",
  "learningStyleDetails": "A detailed explanation (1-2 paragraphs) of the learning style breakdown, what it means for the user's learning approach, and suggestions.",
  "goalsDetails": ["Detailed goal 1 with context...", "Detailed goal 2 with context..."],
  "strengthsDetails": ["Detailed strength 1 explanation with examples...", "Detailed strength 2 explanation with examples..."],
  "developmentAreas": ["Area for improvement 1 with brief context", "Area for improvement 2 with brief context"],
  "careerSuggestions": ["Suggested career path or role 1", "Suggested career path or role 2"],
  "suggestedSkills": ["Specific skill to learn 1", "Specific skill to learn 2"],

  // --- FOR UI RECOMMENDATIONS & WORD REPORT ---
  "freelanceJobs": {
    "uiList": ["Top Freelance Job 1", "Top Freelance Job 2", "Top Freelance Job 3", "Top Freelance Job 4"], // Short list (3-5) for UI chips
    "wordList": ["Freelance Job/Gig 1 with brief description", "Freelance Job/Gig 2 with brief description", "Freelance Job/Gig 3 with brief description", "..."] // Full list (8-15) with details for Word doc
  }
}

**INPUT DATA (JSON):**
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

      // --- Data Sanitization and Normalization ---

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

      // Sanitize and build the final map
      final sanitized = <String, dynamic>{
        'uiSummary': (parsedRaw['uiSummary'] ?? 'Summary not available.').toString(),
        'personalityType': (parsedRaw['personalityType'] ?? 'Explorer').toString(), // Default type
        'personalityExplanation': '', // Not used in UI per request
        'detailedSummary': (parsedRaw['detailedSummary'] ?? 'Detailed summary not available.').toString(),
        'personalityDetails': (parsedRaw['personalityDetails'] ?? 'Personality details not available.').toString(),
        'learningStyleDetails': (parsedRaw['learningStyleDetails'] ?? 'Learning style details not available.').toString(),
        'goalsDetails': toStringList(parsedRaw['goalsDetails']),
        'strengthsDetails': toStringList(parsedRaw['strengthsDetails']),
        'inferredGoals': toStringList(parsedRaw['inferredGoals']).take(3).toList(), // Limit for UI
        'keyStrengths': toStringList(parsedRaw['keyStrengths']).take(3).toList(), // Limit for UI
        'learningStylePercentages': parseLearning(parsedRaw['learningStylePercentages'] as Map<String, dynamic>?),
        'developmentAreas': toStringList(parsedRaw['developmentAreas']),
        'careerSuggestions': toStringList(parsedRaw['careerSuggestions']),
        'suggestedSkills': toStringList(parsedRaw['suggestedSkills']),
        'freelanceJobs': parseFreelanceJobs(parsedRaw['freelanceJobs']),
      };

      return AnalysisResult.fromJson(sanitized);
    } catch (e, st) {
      print('analyzeResponses error: $e\n$st');
      // Return a minimal valid object on error
      return AnalysisResult.fromJson({
        'uiSummary': 'An error occurred during analysis.',
        'personalityType': 'Analyst',
        'personalityExplanation': '',
        'detailedSummary': 'An error occurred during analysis.',
        'personalityDetails': 'An error occurred during analysis.',
        'learningStyleDetails': 'An error occurred during analysis.',
        'goalsDetails': [],
        'strengthsDetails': [],
        'inferredGoals': ['Goal 1', 'Goal 2'],
        'keyStrengths': ['Strength 1', 'Strength 2'],
        'learningStylePercentages': {'Visual': 34, 'Verbal': 33, 'Kinesthetic': 33},
        'developmentAreas': [],
        'careerSuggestions': [],
        'suggestedSkills': [],
        'freelanceJobs': {'uiList': ['Freelancer'], 'wordList': ['Freelancer']},
      });
    }
  }
}