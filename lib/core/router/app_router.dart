// File: lib/core/router/app_router.dart
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/feature/landing/ui/pages/landing_page.dart';
import 'package:quiz/feature/assessment/ui/pages/assessment_screen.dart';
import 'package:quiz/feature/assessment/bloc/chat_bloc.dart';
import '../utils/constants/routes.dart';
import '../utils/di.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      debugLogDiagnostics: kDebugMode,
      initialLocation: Routes.landing,
      routes: [
        GoRoute(
          path: Routes.landing,
          name: 'landing',
          builder: (_, __) => const LandingPage(),
        ),

        // Quiz route accepts a query parameter: level
        GoRoute(
          path: Routes.quize,
          name: 'quiz',
          builder: (context, state) {
            // normalize input using if / else so we never accidentally pass an unexpected value
            final raw = state.uri.queryParameters['level'] ?? 'Level 1';
            String level;

            // map a variety of possible inputs to strict internal level strings
            if (raw == '1' || raw.toLowerCase() == '1' || raw.toLowerCase() == 'level1' || raw.toLowerCase() == 'level 1' || raw.toLowerCase().contains('level 1')) {
              level = 'Level 1';
            } else if (raw == '2' || raw.toLowerCase() == '2' || raw.toLowerCase() == 'level2' || raw.toLowerCase() == 'level 2' || raw.toLowerCase().contains('level 2')) {
              level = 'Level 2';
            } else if (raw == '3' || raw.toLowerCase() == '3' || raw.toLowerCase() == 'level3' || raw.toLowerCase() == 'level 3' || raw.toLowerCase().contains('level 3')) {
              level = 'Level 3';
            } else {
              // fallback to Level 1 for any unexpected input
              level = 'Level 1';
            }

            // Use the DI-provided ChatBloc which already has the locale set
            return BlocProvider<ChatBloc>(
              create: (_) => getIt<ChatBloc>()..add(ChatStarted(level: level)),
              child: QuizPage(selectedLevel: level),
            );
          },
        ),
      ],
    );
  }
}