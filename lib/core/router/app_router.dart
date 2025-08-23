import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz/feature/chat/ui/pages/assessment_screen.dart';
import 'package:quiz/feature/landing/ui/pages/landing_page.dart';


import '../utils/constants/routes.dart';

class AppRouter {
  final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: Routes.landing,
    routes: [
    
      GoRoute(path: Routes.landing, builder: (_, __) => const LandingPage()),

      GoRoute(path: Routes.quize, builder: (_, _) => QuizPage(selectedLevel: '1',)),
    ],
  );

}