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
      Map<String, dynamic> _safeParseJson(String s) {
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
        parsed = _safeParseJson(raw);
      } catch (e) {
        // ignore: avoid_print
        final previewLen = raw.length > 500 ? 500 : raw.length;
        print('AI raw (first 500): ${raw.substring(0, previewLen)}');
        rethrow;
      }

      return AnalysisResult.fromJson(parsed);
    } catch (e, st) {
      // ignore: avoid_print
      print('analyzeResponses error: $e\n$st');
      return AnalysisResult.empty();
    }
  }

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

  // ===================== PROMPTS (STRICT: EXACT MODEL SHAPE & TYPES) =====================

  String _buildArabicPrompt(Map<String, dynamic> payload) {
    return '''
أنت محلّل تقييم لمنصة Multiverse Mentor. أرجِع **كائن JSON واحد فقط صالحاً** بدون أي نص إضافي أو Markdown أو تعليقات.

## قواعد صارمة للغاية
- أعد **كائن JSON واحد فقط** بمفاتيح **مطابقة تمامًا** للأسماء التالية وفي نفس الأنواع.
- **ممنوع** إضافة أو حذف مفاتيح. **ممنوع** إرجاع null. إذا تعذر الاستدلال، استخدم "" أو [] أو القيم الافتراضية الموضحة.
- جميع القيم النصية تكون جمل قصيرة، بلا تنسيق، بلا أسطر جديدة قدر الإمكان.
- القوائم عناصرها نصوص غير فارغة، **بدون تكرار**.
- **learningStylePercentages** يحتوي **تمامًا** على المفاتيح: "Visual", "Verbal", "Kinesthetic" بقيم صحيحة (int) ومجموعها **= 100**. إذا لم تكن النِسَب واضحة، استخدم 34/33/33 مع تفسير موجز في الحقل النصي المخصص (وليس داخل الخريطة).
- حد الطول: 
  - uiSummary ≤ 45 كلمة
  - personalityExplanation ≤ 80 كلمة
  - detailedSummary ≤ 150 كلمة
- **inferredGoals**: بالضبط 3 عناصر موجزة للواجهة.
- **keyStrengths**: بالضبط 3 عناصر موجزة للواجهة.
- **learningResources** يجب أن تكون قائمة فارغة [] (النظام يملؤها لاحقًا).

## البنية المطلوبة (الأسماء والأنواع ثابتة)
{
  "uiSummary": "string",
  "personalityType": "string",
  "personalityExplanation": "string",
  "learningStylePercentages": {"Visual": 50, "Verbal": 10, "Kinesthetic": 40},
  "inferredGoals": ["string", "string", "string"],
  "keyStrengths": ["string", "string", "string"],
  "detailedSummary": "string",
  "personalityDetails": "string",
  "learningStyleDetails": "string",
  "goalsDetails": ["string", "..."],
  "strengthsDetails": ["string", "..."],
  "developmentAreas": ["string", "..."],
  "careerSuggestions": ["string", "..."],
  "suggestedSkills": ["string", "..."],
  "freelanceJobs": { "uiList": ["string", "..."], "wordList": ["Title - one line", "..."] },
  "practicalSteps": ["string", "..."],
  "inspirationalQuote": "string",
  "learningResources": [],
  "roadmap": { "levelA": ["string", "..."], "levelB": ["string", "..."], "levelC": ["string", "..."] }
}

## بيانات الإدخال (مكثفة)
${jsonEncode(payload)}
''';
  }

  String _buildEnglishPrompt(Map<String, dynamic> payload) {
    return '''
You are an analyzer for Multiverse Mentor. Return **one valid JSON object only** — no prose, no Markdown, no comments.

## Hard rules
- Return **exactly one** JSON object whose keys **exactly match** the names below and whose types match the model.
- Do **not** add or omit keys. Do **not** output null. If a value is uncertain, use "" or [] or the defaults indicated.
- Text values must be short plain sentences without formatting.
- Lists contain non-empty, **deduplicated** strings.
- **learningStylePercentages** must include **exactly**: "Visual", "Verbal", "Kinesthetic" as **integers** that **sum to 100**. If unsure, use 34/33/33 and keep any rationale in text fields (not inside the map).
- Length limits:
  - uiSummary ≤ 45 words
  - personalityExplanation ≤ 80 words
  - detailedSummary ≤ 150 words
- **inferredGoals**: exactly 3 concise, UI-ready strings.
- **keyStrengths**: exactly 3 concise, UI-ready strings.
- **learningResources** MUST be an empty list [] (system fills it later).

## Required shape (keys & types fixed)
{
  "uiSummary": "string",
  "personalityType": "string",
  "personalityExplanation": "string",
  "learningStylePercentages": {"Visual": 34, "Verbal": 33, "Kinesthetic": 33},
  "inferredGoals": ["string", "string", "string"],
  "keyStrengths": ["string", "string", "string"],
  "detailedSummary": "string",
  "personalityDetails": "string",
  "learningStyleDetails": "string",
  "goalsDetails": ["string", "..."],
  "strengthsDetails": ["string", "..."],
  "developmentAreas": ["string", "..."],
  "careerSuggestions": ["string", "..."],
  "suggestedSkills": ["string", "..."],
  "freelanceJobs": { "uiList": ["string", "..."], "wordList": ["Title - one line", "..."] },
  "practicalSteps": ["string", "..."],
  "inspirationalQuote": "string",
  "learningResources": [],
  "roadmap": { "levelA": ["string", "..."], "levelB": ["string", "..."], "levelC": ["string", "..."] }
}

## Condensed input data
${jsonEncode(payload)}
''';
  }
}
