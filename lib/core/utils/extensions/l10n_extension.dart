import 'package:flutter/material.dart';
import 'package:mentor/core/utils/l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
