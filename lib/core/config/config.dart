import 'package:google_generative_ai/google_generative_ai.dart';

class AppConfig {
  static const String geminiApiKey = 'AIzaSyC1U7JIZxgJve5kRJ0ons27dEZq-4IZCk4';
  static const String chatModel = 'gemini-1.5-flash';
  static const String analysisModel = 'gemini-1.5-flash';

  static final GenerationConfig chatGenerationConfig = GenerationConfig(
    maxOutputTokens: 1000,
    temperature: 0.7,
  );

  static final GenerationConfig analysisGenerationConfig = GenerationConfig(
    maxOutputTokens: 1500,
    temperature: 0.3,
  );

  static final String serperApiKey = '9b512d478096d672310db2d91912c78657a81a49';
  static final String baseUrl = 'https://google.serper.dev';
}
