
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz/core/utils/constants/routes.dart';

void startLevel(BuildContext context, String level) {
  // Navigate via GoRouter and pass the level as a query parameter
  GoRouter.of(context).go('${Routes.quize}?level=${Uri.encodeComponent(level)}');
}