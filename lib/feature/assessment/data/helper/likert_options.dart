import 'package:flutter/material.dart';
import 'package:quiz/core/utils/extensions/l10n_extension.dart';

List<Map<String, String>> likertOptions(BuildContext context) {
  final loc = context.l10n;

  final options = [
    {'value': '5', 'label': loc.stronglyAgree},
    {'value': '4', 'label': loc.agree},
    {'value': '3', 'label': loc.neutral},
    {'value': '2', 'label': loc.disagree},
    {'value': '1', 'label': loc.stronglyDisagree},
  ];

  return options;
}
