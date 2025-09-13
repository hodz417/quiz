// lib/core/prompts.dart
import 'package:quiz/core/local_settings/local_settings_bloc.dart';
import 'package:quiz/core/utils/di.dart';


/// Returns the appropriate prompt depending on the current locale in LocalSettingsBloc.
/// If the locale indicates Arabic (startsWith 'ar' or contains 'arab'), returns [ar].
/// Otherwise returns [en].
String getPrompt({required String ar, required String en}) {
  try {
    final LocalSettingsBloc bloc = getIt<LocalSettingsBloc>();
    final dynamic state = bloc.state;

    // Try to extract a locale code from common shapes of bloc.state
    String? localeCode;
    try {
      // common shape: state.locale (Locale or String)
      final dynamic localeProp = state.locale;
      if (localeProp != null) {
        if (localeProp is String) {
          localeCode = localeProp;
        } else {
          // toString fallback (Locale objects usually toString like 'Locale("ar")' or 'en_US')
          localeCode = localeProp.toString();
        }
      }
    } catch (_) {
      // fallback to state's toString
      final s = state.toString();
      if (s.isNotEmpty) localeCode = s;
    }

    if (localeCode != null) {
      final lc = localeCode.toLowerCase();
      if (lc.startsWith('ar') || lc.contains('arab')) return ar;
    }
  } catch (_) {
    // ignore and fallback to en
  }

  return en;
}
