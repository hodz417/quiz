// feature/assessment/data/repositories/assessment_repository.dart
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:quiz/core/config/config.dart';
import 'package:quiz/feature/assessment/data/models/analysis_result/analysis_result.dart';

class AssessmentRepository {
  final GenerativeModel chatModel;

  AssessmentRepository()
      : chatModel = GenerativeModel(
          model: AppConfig.chatModel,
          apiKey: AppConfig.geminiApiKey,
          generationConfig: AppConfig.chatGenerationConfig,
        );

  Future<AnalysisResult> analyzeResponses(
    List<Map<String, dynamic>> responses,
  ) async {
    final payload = {'responses': responses};

    // Detect language from responses
    final isArabic = _detectLanguage(responses);

    final prompt = isArabic
        ? _buildArabicPrompt(payload)
        : _buildEnglishPrompt(payload);

    try {
      final model = GenerativeModel(
        model: AppConfig.analysisModel,
        apiKey: AppConfig.geminiApiKey,
        generationConfig: GenerationConfig(
          temperature: 0.1,
          topK: 40,
          topP: 0.9,
          maxOutputTokens: 4096,
        ),
      );

      final response = await model.generateContent([Content.text(prompt)]);
      var jsonText = (response.text ?? '').trim();

      // Extract codeblock JSON if present
      final fenceRegex = RegExp(
        r'```(?:json)?\s*([\s\S]*?)```',
        multiLine: true,
      );
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
      return AnalysisResult.fromJson(parsedRaw);
    } catch (e, st) {
      print('analyzeResponses error: $e\n$st');
      // Consider re-throwing or returning a specific error state
      // instead of returning an empty result silently.
      return AnalysisResult.empty();
    }
  }

  // Detect if responses are in Arabic
  bool _detectLanguage(List<Map<String, dynamic>> responses) {
    for (var response in responses) {
      final answer = response['answer'].toString();
      // Check for Arabic characters
      if (RegExp(r'[\u0600-\u06FF]').hasMatch(answer)) {
        return true;
      }
    }
    return false;
  }

  String _buildArabicPrompt(Map<String, dynamic> payload) {
    return '''
أنت محلل تقييم الذكاء الاصطناعي لـ Multiverse Mentor. قم بتحليل استجابات التقييم وأنشئ *مستويين من الإخراج:

1. **إخراج واجهة المستخدم (UI)** → قصير، مشجع، موجه للطلاب (14–22 سنة) بلغة بسيطة ومحفزة.
2. **تقرير مفصل** → تحليلي واحترافي للمشرفين أو المستثمرين أو المعلمين، مع رؤى قابلة للتطبيق.

--- شرط اللغة ---
- إذا كانت الإجابات (answers) في الإدخال بالعربية → اجعل كل التقرير والإخراج بالعربية.
- إذا كانت الإجابات بالإنجليزية → اجعل كل التقرير والإخراج بالإنجليزية.
- لا تخلط بين اللغتين أبداً.

--- تنسيق الإدخال ---
مصفوفة JSON تحتوي على استجابات، كل استجابة تشمل:
- id
- level
- question
- answer (مقياس 1–5، متعدد اختيارات، أو نص)
- weight

--- المهام ---
1. *تجميع الاستجابات* حسب المهارات:
   - مرونة التعلم والعادات
   - حل المشكلات والتفكير النقدي
   - التعاون والتواصل
   - التكيف والصمود
   - التوجيه الذاتي والتحفيز
   - القيادة والمبادرة
   - المهارات التقنية والعملية

2. *حساب الدرجات* (بوزن، متجانسة من 1 إلى 5).

3. *استخلاص الرؤى:
   - الأهداف (صريحة أو ضمنية).
   - النقاط القوية (مع اقتباسات قصيرة لو متاحة).
   - المجالات اللي محتاجة تطوير (واضحة، قابلة للتطبيق، مع أمثلة).
   - نوع الشخصية (اسم قصير للواجهة + وصف أطول للتقرير).
   - أسلوب التعلم (نِسب Visual / Verbal / Kinesthetic % مع شرح مبسط).

4. **توليد التوصيات:
   - **المهارات للتعلم: 4–6 مهارات عملية.
   - **وظائف العمل الحر:
     *واجهة المستخدم: 3–5 عناوين قصيرة.
     التقرير: 8–12 خيار مع وصف سطر واحد لكل وظيفة.
   - *الدورات والموارد: 2–3 موارد مجانية (YouTube, FreeCodeCamp, Coursera free, ...).
   - **الخطوات العملية التالية: 2–3 خطوات يومية/أسبوعية بسيطة.

5. **خريطة طريق (Roadmap)*:
   - مستوى A (أساسيات/مبتدئ): 3–6 شهور.
   - مستوى B (متقدم): 6–12 شهر.
   - مستوى C (احتراف/قيادة): 12–24 شهر.

--- تنسيق الإخراج ---
يجب أن يكون الإخراج كائن JSON صالح فقط بالهيكل التالي:

{
  "uiSummary": "ملخص قصير للواجهة",
  "personalityType": "نوع الشخصية",
  "personalityExplanation": "شرح الشخصية",
  "detailedSummary": "ملخص مفصل",
  "personalityDetails": "تفاصيل الشخصية",
  "learningStyleDetails": "تفاصيل أسلوب التعلم",
  "goalsDetails": ["هدف 1", "هدف 2"],
  "strengthsDetails": ["قوة 1", "قوة 2"],
  "inferredGoals": ["هدف 1", "هدف 2"],
  "keyStrengths": ["قوة 1", "قوة 2"],
  "learningStylePercentages": {"Visual": 40, "Verbal": 30, "Kinesthetic": 30},
  "developmentAreas": ["مجال 1", "مجال 2"],
  "careerSuggestions": ["مسار 1", "مسار 2"],
  "suggestedSkills": ["مهارة 1", "مهارة 2"],
  "freelanceJobs": {"uiList": ["وظيفة 1", "وظيفة 2"], "wordList": ["وظيفة 1 - وصف", "وظيفة 2 - وصف"]},
  "practicalSteps": ["خطوة 1", "خطوة 2"],
  "inspirationalQuote": "اقتباس ملهم",
  "learningResources": [
    {"name": "freeCodeCamp", "type": "Course & Docs", "url": "https://www.freecodecamp.org/", "description": "مسار عملي شامل لتعلم تطوير الويب (HTML/CSS/JS) مناسب لبداية العمل الحر كمطور Front-end."},
    {"name": "Figma Learn", "type": "UI/UX Learning", "url": "https://www.figma.com/resources/learn-design/", "description": "دروس وموارد رسمية لتعلم تصميم واجهات وتجهيز نماذج أولية — مورد مهم لمن يريد العمل الحر في UI/UX."},
    {"name": "Upwork Resources", "type": "Freelancing Platform Guide", "url": "https://www.upwork.com/resources", "description": "دليل رسمي ومقالات عن كيفية إنشاء ملف مهني، البحث عن وظائف، وتحديد أسعار مناسبة للمطورين والمصممين والكتاب."},
    {"name": "Fiverr Resources", "type": "Freelancing Platform Guide", "url": "https://www.fiverr.com/resources", "description": "مصادر ودروس لعرض خدماتك على Fiverr، بناء باقات جذابة، وتحسين ظهور الخدمات — مفيد لكتّاب المحتوى ومقدمي الخدمات السريعة."}
  ],
  "roadmap": {
    "levelA": ["خطوة 1", "خطوة 2", "خطوة 3"],
    "levelB": ["خطوة 1", "خطوة 2", "خطوة 3"],
    "levelC": ["خطوة 1", "خطوة 2", "خطوة 3"]
  }
}

--- بيانات الإدخال ---
${jsonEncode(payload)}
''';
  }

  String _buildEnglishPrompt(Map<String, dynamic> payload) {
    return '''
You are Multiverse Mentor's AI Assessment Analyzer. Analyze assessment responses and create *two levels of output:

1. **UI Output** → Short, encouraging, student-oriented (ages 14-22) in simple, motivating language.
2. **Detailed Report** → Analytical and professional for supervisors, investors, or teachers, with actionable insights.

--- Language Requirement ---
- If the answers in the input are in Arabic → Make the entire report and output in Arabic.
- If the answers are in English → Make the entire report and output in English.
- Never mix the two languages.

--- Input Format ---
JSON array containing responses, each response includes:
- id
- level
- question
- answer (scale 1-5, multiple choice, or text)
- weight

--- Tasks ---
1. *Group responses* by skills:
   - Learning agility & habits
   - Problem-solving & critical thinking
   - Collaboration & communication
   - Adaptability & resilience
   - Self-direction & motivation
   - Leadership & initiative
   - Technical & practical skills

2. *Calculate scores* (weighted, normalized from 1 to 5).

3. *Extract insights:
   - Goals (explicit or implicit).
   - Strengths (with short quotes if available).
   - Areas needing development (clear, actionable, with examples).
   - Personality type (short name for UI + longer description for report).
   - Learning style (Visual/Verbal/Kinesthetic % with simple explanation).

4. **Generate recommendations:
   - **Skills to learn: 4-6 practical skills.
   - **Freelance jobs:
     *UI: 3-5 short titles.
     Report: 8-12 options with one-line description each.
   - *Courses & resources: 2-3 free resources (YouTube, FreeCodeCamp, Coursera free, ...).
   - **Next practical steps: 2-3 simple daily/weekly steps.

5. **Roadmap*:
   - Level A (Basics/Beginner): 3-6 months.
   - Level B (Advanced): 6-12 months.
   - Level C (Professional/Leadership): 12-24 months.

--- Output Format ---
Output must be only a valid JSON object with the following structure:

{
  "uiSummary": "Short UI summary",
  "personalityType": "Personality type",
  "personalityExplanation": "Personality explanation",
  "detailedSummary": "Detailed summary",
  "personalityDetails": "Personality details",
  "learningStyleDetails": "Learning style details",
  "goalsDetails": ["Goal 1", "Goal 2"],
  "strengthsDetails": ["Strength 1", "Strength 2"],
  "inferredGoals": ["Goal 1", "Goal 2"],
  "keyStrengths": ["Strength 1", "Strength 2"],
  "learningStylePercentages": {"Visual": 40, "Verbal": 30, "Kinesthetic": 30},
  "developmentAreas": ["Area 1", "Area 2"],
  "careerSuggestions": ["Path 1", "Path 2"],
  "suggestedSkills": ["Skill 1", "Skill 2"],
  "freelanceJobs": {"uiList": ["Job 1", "Job 2"], "wordList": ["Job 1 - description", "Job 2 - description"]},
  "practicalSteps": ["Step 1", "Step 2"],
  "inspirationalQuote": "Inspirational quote",
  "learningResources": [
    {"name": "freeCodeCamp", "type": "Course & Docs", "url": "https://www.freecodecamp.org/", "description": "Hands-on, free curriculum for web development — ideal for starting freelance Front-end work."},
    {"name": "Figma Learn", "type": "UI/UX Learning", "url": "https://www.figma.com/resources/learn-design/", "description": "Official tutorials and resources to learn interface design and prototyping — essential for freelance UI/UX designers."},
    {"name": "Upwork Resources", "type": "Freelancing Platform Guide", "url": "https://www.upwork.com/resources", "description": "Guides and articles on building a strong profile, finding jobs, and setting rates for developers, designers, and writers."},
    {"name": "Fiverr Resources", "type": "Freelancing Platform Guide", "url": "https://www.fiverr.com/resources", "description": "Resources and tips for creating gigs, packaging services, and improving discoverability — useful for writers and quick-sells."}
  ],
  "roadmap": {
    "levelA": ["Step 1", "Step 2", "Step 3"],
    "levelB": ["Step 1", "Step 2", "Step 3"],
    "levelC": ["Step 1", "Step 2", "Step 3"]
  }
}

--- Input Data ---
${jsonEncode(payload)}
''';
  }
}
