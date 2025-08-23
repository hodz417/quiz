import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

class AppLogger {
  static final _talkerBlocObserver = TalkerBlocObserver(
    settings: const TalkerBlocLoggerSettings(
      enabled: true,
      printCreations: true,
      printClosings: true,
      printChanges: true,
    ),
  );

  static TalkerBlocObserver get talkerBlocObserver => _talkerBlocObserver;

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.none,
    ),
  );

  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  // Initialize crashlytics settings
  static Future<void> initCrashlytics() async {
    if (!kDebugMode) {
      await _crashlytics.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = _crashlytics.recordFlutterFatalError;
    }
  }

  // Helper method to record error to crashlytics
  static void _recordToCrashlytics(
    String message,
    dynamic error,
    StackTrace? stackTrace,
  ) {
    if (!kDebugMode) {
      _crashlytics.recordError(
        error ?? message,
        stackTrace,
        reason: message,
        fatal: true,
      );
    }
  }

  static void trace(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void warning(dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    _logger.w(
      message,
      error: error,
      stackTrace: stackTrace,
    );
    if (!kDebugMode) {
      _crashlytics.recordError(
        error ?? message,
        stackTrace,
        reason: message,
        fatal: false,
      );
    }
  }

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
    _recordToCrashlytics(message.toString(), error, stackTrace);
  }

  static void fatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
    _recordToCrashlytics(message.toString(), error, stackTrace);
  }

  // Add custom keys to crashlytics for better error tracking
  static Future<void> setCustomKey(String key, dynamic value) async {
    if (!kDebugMode) {
      await _crashlytics.setCustomKey(key, value);
    }
  }

  // Set user identifier in crashlytics
  static Future<void> setUserIdentifier(String identifier) async {
    if (!kDebugMode) {
      await _crashlytics.setUserIdentifier(identifier);
    }
  }
}
