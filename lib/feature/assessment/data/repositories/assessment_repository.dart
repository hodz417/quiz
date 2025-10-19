// lib/feature/assessment/data/repositories/assessment_repository.dart
import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentor/core/config/config.dart';
import 'package:mentor/feature/assessment/data/models/analysis_result/analysis_result.dart';

class AssessmentRepository {
  final GenerativeModel analysisModel;

  AssessmentRepository()
      : analysisModel = FirebaseAI.googleAI(auth: FirebaseAuth.instance).generativeModel(
          model: AppConfig.analysisModel,
          generationConfig: AppConfig.analysisGenerationConfig,
        );

  Future<AnalysisResult> analyzeResponses(
    List<Map<String, dynamic>> responses,
  ) async {
    // Condense responses to reduce prompt tokens
    final condensed = _condenseResponses(responses);
    final payload = {'responses': condensed};

    final isArabic = _detectLanguage(responses);
    final prompt = isArabic ? _buildArabicPrompt(payload) : _buildEnglishPrompt(payload);

    try {
      // 1) Call the model
      final result = await analysisModel.generateContent([Content.text(prompt)]);

      // 2) Try convenience getter
      String raw = (result.text ?? '').trim();

      // 3) If empty, aggregate from candidates and log diagnostics
      if (raw.isEmpty) {
        final buf = StringBuffer();
        // Debug info
        // ignore: avoid_print
        print('PF.blockReason: ${result.promptFeedback?.blockReason}');
        // ignore: avoid_print
        print('PF.safetyRatings: ${result.promptFeedback?.safetyRatings}');
        final candidates = result.candidates;
        for (var i = 0; i < candidates.length; i++) {
          final c = candidates[i];
          // ignore: avoid_print
          print('Candidate[$i] finishReason=${c.finishReason} safetyRatings=${c.safetyRatings}');
          for (final part in c.content.parts) {
            if (part is TextPart) buf.write(part.text);
          }
        }
        raw = buf.toString().trim();
      }

      // 4) Still empty? return a safe empty object
      if (raw.isEmpty) {
        // ignore: avoid_print
        print('Model returned no text. Returning AnalysisResult.empty().');
        return AnalysisResult.empty();
      }

      // 5) Safe JSON parse
      Map<String, dynamic> safeParseJson(String s) {
        // direct
        try {
          return jsonDecode(s) as Map<String, dynamic>;
        } catch (_) {}

        // code fence
        final fence = RegExp(r'```(?:json)?\s*([\s\S]*?)```', multiLine: true).firstMatch(s);
        if (fence != null) {
          final inner = fence.group(1)!.trim();
          try {
            return jsonDecode(inner) as Map<String, dynamic>;
          } catch (_) {}
        }

        // first {...}
        final start = s.indexOf('{');
        final end = s.lastIndexOf('}');
        if (start != -1 && end != -1 && end > start) {
          final slice = s.substring(start, end + 1);
          try {
            return jsonDecode(slice) as Map<String, dynamic>;
          } catch (_) {}
        }

        throw const FormatException('Non-JSON or truncated JSON from model');
      }

      Map<String, dynamic> parsed;
      try {
        parsed = safeParseJson(raw);
      } catch (e) {
        // ignore: avoid_print
        final previewLen = raw.length > 500 ? 500 : raw.length;
        print('AI raw (first 500): ${raw.substring(0, previewLen)}');
        rethrow;
      }

      // ---- NORMALIZE LEARNING STYLE PERCENTAGES BEFORE DESERIALIZATION ----
      parsed['learningStylePercentages'] =
          _normalizeLearningStyles(parsed['learningStylePercentages']);

      // (Optional) ensure required collections exist if model omitted them
      parsed.putIfAbsent('inferredGoals', () => <String>[]);
      parsed.putIfAbsent('keyStrengths', () => <String>[]);
      parsed.putIfAbsent('freelanceJobs', () => {'uiList': <String>[], 'wordList': <String>[]});
      parsed.putIfAbsent('practicalSteps', () => <String>[]);
      parsed.putIfAbsent('learningResources', () => <Map<String, dynamic>>[]);
      parsed.putIfAbsent('roadmap', () => {'levelA': <String>[], 'levelB': <String>[], 'levelC': <String>[]});

      return AnalysisResult.fromJson(parsed);
    } catch (e, st) {
      // ignore: avoid_print
      print('analyzeResponses error: $e\n$st');
      return AnalysisResult.empty();
    }
  }

  // ===================== NORMALIZATION =====================

  Map<String, int> _normalizeLearningStyles(dynamic raw) {
    // Canonical keys used by the UI
    const vKey = 'Visual';
    const verbKey = 'Verbal';
    const kinKey = 'Kinesthetic';

    // Common aliases → canonical
    const aliases = <String, String>{
      // Visual
      'visual': vKey,
      'spatial': vKey,
      'visual/spatial': vKey,

      // Verbal (LLMs often output Auditory/Aural/Reading-Writing)
      'verbal': verbKey,
      'linguistic': verbKey,
      'reading/writing': verbKey,
      'reading-writing': verbKey,
      'read/write': verbKey,
      'read & write': verbKey,
      'aural': verbKey,
      'auditory': verbKey,
      'listening': verbKey,

      // Kinesthetic
      'kinesthetic': kinKey,
      'kinaesthetic': kinKey,
      'physical': kinKey,
      'hands-on': kinKey,
      'tactile': kinKey,
      'bodily-kinesthetic': kinKey,
    };

    // Extract a Map<String, dynamic>
    Map<String, dynamic> asMap;
    if (raw is Map) {
      asMap = raw.map((k, v) => MapEntry(k.toString(), v));
    } else {
      asMap = {};
    }

    // Initialize with zeros
    final tmp = <String, int>{vKey: 0, verbKey: 0, kinKey: 0};

    int _toInt(dynamic v) {
      if (v is int) return v;
      if (v is num) return v.round();
      if (v is String) {
        // Handles "34%", " 33 ", etc.
        final m = RegExp(r'-?\d+').firstMatch(v);
        if (m != null) return int.tryParse(m.group(0)!) ?? 0;
      }
      return 0;
    }

    // Read via aliases
    asMap.forEach((k, v) {
      final canon = aliases[k.trim().toLowerCase()];
      if (canon != null && tmp.containsKey(canon)) {
        tmp[canon] = _toInt(v);
      }
    });

    // If canonical keys already present, prefer them
    for (final k in [vKey, verbKey, kinKey]) {
      if (asMap.containsKey(k)) tmp[k] = _toInt(asMap[k]);
    }

    // Clamp individual values
    tmp.updateAll((_, val) => val.clamp(0, 100));

    // If all zero → default split
    final sum0 = tmp.values.fold<int>(0, (a, b) => a + b);
    if (sum0 == 0) return {vKey: 34, verbKey: 33, kinKey: 33};

    // Normalize to sum = 100 using largest remainder method
    final totals = [tmp[vKey]!, tmp[verbKey]!, tmp[kinKey]!];
    final keys = [vKey, verbKey, kinKey];
    final sum = totals.reduce((a, b) => a + b);

    final base = <String, int>{};
    final remainders = <String, double>{};
    int used = 0;
    for (var i = 0; i < keys.length; i++) {
      final proportion = (totals[i] / sum) * 100.0;
      final floorVal = proportion.floor();
      base[keys[i]] = floorVal;
      remainders[keys[i]] = proportion - floorVal;
      used += floorVal;
    }

    int remain = 100 - used;
    final order = remainders.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    for (var i = 0; i < remain; i++) {
      final k = order[i % order.length].key;
      base[k] = base[k]! + 1;
    }

    return {
      vKey: base[vKey]!,
      verbKey: base[verbKey]!,
      kinKey: base[kinKey]!,
    };
  }

  // ===================== HELPERS =====================

  // Make payload compact: keep id, weight, short answer; drop question/level
  List<Map<String, dynamic>> _condenseResponses(List<Map<String, dynamic>> responses) {
    const maxAnswerLen = 120; // trim very long text answers
    return responses.map((r) {
      final ans = (r['answer'] ?? '').toString();
      final trimmed = ans.length > maxAnswerLen ? '${ans.substring(0, maxAnswerLen)}…' : ans;
      return {
        'id': r['id'],
        'answer': trimmed,
        'weight': r['weight'],
      };
    }).toList();
  }

  // Detect if responses are in Arabic
  bool _detectLanguage(List<Map<String, dynamic>> responses) {
    for (var response in responses) {
      final answer = (response['answer'] ?? '').toString();
      if (RegExp(r'[\u0600-\u06FF]').hasMatch(answer)) {
        return true;
      }
    }
    return false;
  }

  // ===================== PROMPTS (compact, bounded, UI=3 items) =====================

  String _buildArabicPrompt(Map<String, dynamic> payload) {
    return '''
أنت محلّل تقييم لمنصة Multiverse Mentor. هدفك إخراج **JSON صالح فقط** بالعربية.

قواعد عامة قوية لضبط الطول والمحتوى:
- لا تُكرر نص الأسئلة أو المدخلات.
- استخدم جُملاً قصيرة، لغة بسيطة، بدون رموز تعبيرية.
- أعد **كائن JSON واحد فقط** دون أي سطور تفسيرية أو تعليمات برمجية أو Markdown.
- تأكد أن جميع القوائم خالية من العناصر الفارغة أو المكررة.
- تأكد أن "learningStylePercentages" أعداد صحيحة ومجموعها = 100.

قيود صارمة (لتفادي تجاوز الحدود):
- uiSummary ≤ 45 كلمة
- personalityExplanation ≤ 80 كلمة
- detailedSummary ≤ 150 كلمة
- **inferredGoals: 3 عناصر بالضبط (مهيأة للواجهة)**
- **keyStrengths: 3 عناصر بالضبط (مهيأة للواجهة)**
- goalsDetails ≤ 6 عناصر، strengthsDetails ≤ 6 عناصر
- developmentAreas ≤ 4 عناصر
- careerSuggestions ≤ 6 عناصر
- suggestedSkills ≤ 6 عناصر
- freelanceJobs.uiList ≤ 4 عناوين قصيرة، wordList ≤ 6 عناصر (سطر واحد لكل عنصر)
- roadmap: كل مستوى ≤ 4 خطوات
- **learningResources يجب أن تكون [] فارغة** (النظام سيملؤها لاحقًا)

بنية الإخراج (املأ كل الحقول بالقيم المناسبة):
{
  "uiSummary": "...",
  "personalityType": "...",
  "personalityExplanation": "...",
  "detailedSummary": "...",
  "personalityDetails": "...",
  "learningStyleDetails": "...",
  "goalsDetails": ["...", "..."],
  "strengthsDetails": ["...", "..."],
  "inferredGoals": ["...", "...", "..."],      // بالضبط 3 عناصر موجزة للواجهة
  "keyStrengths": ["...", "...", "..."],        // بالضبط 3 عناصر موجزة للواجهة
  "learningStylePercentages": {"Visual": 34, "Verbal": 33, "Kinesthetic": 33},
  "developmentAreas": ["...", "..."],
  "careerSuggestions": ["...", "..."],
  "suggestedSkills": ["...", "..."],
  "freelanceJobs": {
    "uiList": ["...", "..."],
    "wordList": ["عنوان - وصف سطر واحد", "..."]
  },
  "practicalSteps": ["...", "..."],
  "inspirationalQuote": "...",
  "learningResources": [],
  "roadmap": {
    "levelA": ["...", "..."],
    "levelB": ["...", "..."],
    "levelC": ["...", "..."]
  }
}

بيانات الإدخال (مكثفة):
${jsonEncode(payload)}
''';
  }

  String _buildEnglishPrompt(Map<String, dynamic> payload) {
    return '''
You are an analyzer for Multiverse Mentor. Produce **a single valid JSON object only** in English.

Strong content rules:
- Do not echo questions or input text.
- Use short sentences, simple wording, no emojis.
- Output **JSON only** (no prose/markdown/fences).
- Lists must not contain empty or duplicate items.
- "learningStylePercentages" must be integers that sum to 100.

Tight limits (to avoid token overruns):
- uiSummary ≤ 45 words
- personalityExplanation ≤ 80 words
- detailedSummary ≤ 150 words
- **inferredGoals: exactly 3 items (UI-focused)**
- **keyStrengths: exactly 3 items (UI-focused)**
- goalsDetails ≤ 6 items, strengthsDetails ≤ 6 items
- developmentAreas ≤ 4 items
- careerSuggestions ≤ 6 items
- suggestedSkills ≤ 6 items
- freelanceJobs.uiList ≤ 4 short titles, wordList ≤ 6 items (one line each)
- roadmap: ≤ 4 steps per level
- **learningResources MUST be an empty list []** (system will fill later)

Output schema (fill all fields):
{
  "uiSummary": "...",
  "personalityType": "...",
  "personalityExplanation": "...",
  "detailedSummary": "...",
  "personalityDetails": "...",
  "learningStyleDetails": "...",
  "goalsDetails": ["...", "..."],
  "strengthsDetails": ["...", "..."],
  "inferredGoals": ["...", "...", "..."],      // exactly 3 short UI items
  "keyStrengths": ["...", "...", "..."],        // exactly 3 short UI items
  "learningStylePercentages": {"Visual": 34, "Verbal": 33, "Kinesthetic": 33},
  "developmentAreas": ["...", "..."],
  "careerSuggestions": ["...", "..."],
  "suggestedSkills": ["...", "..."],
  "freelanceJobs": {
    "uiList": ["...", "..."],
    "wordList": ["Title - one-line desc", "..."]
  },
  "practicalSteps": ["...", "..."],
  "inspirationalQuote": "...",
  "learningResources": [],
  "roadmap": {
    "levelA": ["...", "..."],
    "levelB": ["...", "..."],
    "levelC": ["...", "..."]
  }
}

Condensed input data:
${jsonEncode(payload)}
''';
  }
}
