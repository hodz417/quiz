import 'package:flutter/material.dart';
import 'package:quiz/core/utils/l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
