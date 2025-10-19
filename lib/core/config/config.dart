import 'package:firebase_ai/firebase_ai.dart';

class AppConfig {
  static const String analysisModel = 'gemini-2.5-flash';

  static final GenerationConfig analysisGenerationConfig = GenerationConfig(
 maxOutputTokens: 8192,
     temperature: 0.2,
    responseMimeType: 'application/json',
  );

  static final String serperApiKey = '9b512d478096d672310db2d91912c78657a81a49';
  static final String baseUrl = 'https://google.serper.dev';
}
