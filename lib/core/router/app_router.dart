// File: lib/core/router/app_router.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor/core/utils/widgets/donation_button.dart';

import 'package:mentor/feature/landing/ui/pages/landing_page.dart';
import 'package:mentor/feature/assessment/ui/pages/assessment_screen.dart';
import 'package:mentor/feature/assessment/bloc/assessment_bloc.dart';


import '../utils/constants/routes.dart';
import '../utils/di.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      debugLogDiagnostics: kDebugMode,
      initialLocation: Routes.landing,
      routes: [
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {

            return Stack(
              children: [
                // The child is the page content (LandingPage, Quiz, ...)
                child,
                  // Positioned in the bottom-right with SafeArea
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: SafeArea(
                      child: Material(
                        color: Colors.transparent,
                        elevation: 6,
                        borderRadius: BorderRadius.circular(12),
                        child: DonationButton(), 
                      ),
                    ),
                  ),
              ],
            );
          },
          // All app routes go under the shell
          routes: [
            GoRoute(
              path: Routes.landing,
              name: 'landing',
              builder: (_, __) => const LandingPage(),
            ),

            // Quiz route with the same bloc provider logic as before
            GoRoute(
              path: Routes.quize,
              name: 'quiz',
              builder: (context, state) {
                final raw = state.uri.queryParameters['level'] ?? 'Level 1';
                String level;

                if (raw == '1' ||
                    raw.toLowerCase() == '1' ||
                    raw.toLowerCase() == 'level1' ||
                    raw.toLowerCase() == 'level 1' ||
                    raw.toLowerCase().contains('level 1')) {
                  level = 'Level 1';
                } else if (raw == '2' ||
                    raw.toLowerCase() == '2' ||
                    raw.toLowerCase() == 'level2' ||
                    raw.toLowerCase() == 'level 2' ||
                    raw.toLowerCase().contains('level 2')) {
                  level = 'Level 2';
                } else if (raw == '3' ||
                    raw.toLowerCase() == '3' ||
                    raw.toLowerCase() == 'level3' ||
                    raw.toLowerCase() == 'level 3' ||
                    raw.toLowerCase().contains('level 3')) {
                  level = 'Level 3';
                } else {
                  level = 'Level 1';
                }

                return BlocProvider<AssessmentBloc>(
                  create: (_) =>
                      getIt<AssessmentBloc>()..add(AssessmentStarted(level: level)),
                  child: QuizPage(selectedLevel: level),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
