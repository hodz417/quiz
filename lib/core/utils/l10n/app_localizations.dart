import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Name of the Arabic language
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// Name of the English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Name of the application or service
  ///
  /// In en, this message translates to:
  /// **'Multiverse Mentor'**
  String get multiverseMentor;

  /// First line of the hero section title
  ///
  /// In en, this message translates to:
  /// **'Discover your career path'**
  String get heroTitleLine1;

  /// Second line of the hero section title
  ///
  /// In en, this message translates to:
  /// **'with AI'**
  String get heroTitleLine2;

  /// Description text in the hero section
  ///
  /// In en, this message translates to:
  /// **'A comprehensive platform that helps you identify your skills and build your career path through smart guidance and personalized courses'**
  String get heroDescription;

  /// Start now button text in the hero section
  ///
  /// In en, this message translates to:
  /// **'Start Now →'**
  String get heroStartNow;

  /// Login button text in the hero section
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get heroLogin;

  /// Title for the 'How it works' section
  ///
  /// In en, this message translates to:
  /// **'How does Multiverse Mentor work?'**
  String get howItWorksTitle;

  /// Subtitle for the 'How it works' section
  ///
  /// In en, this message translates to:
  /// **'Three simple steps to reach your ideal career path'**
  String get howItWorksSubtitle;

  /// Title for the continuous guidance feature card
  ///
  /// In en, this message translates to:
  /// **'Continuous Guidance'**
  String get featureContinuousGuidanceTitle;

  /// Description for the continuous guidance feature card
  ///
  /// In en, this message translates to:
  /// **'Ongoing follow-up with a smart mentor to help you develop your skills and achieve your goals'**
  String get featureContinuousGuidanceDescription;

  /// Title for the smart recommendations feature card
  ///
  /// In en, this message translates to:
  /// **'Smart Recommendations'**
  String get featureSmartRecommendationsTitle;

  /// Description for the smart recommendations feature card
  ///
  /// In en, this message translates to:
  /// **'Get personalized recommendations for skills and courses based on your personality analysis'**
  String get featureSmartRecommendationsDescription;

  /// Title for the personality analysis feature card
  ///
  /// In en, this message translates to:
  /// **'Personality Analysis'**
  String get featurePersonalityAnalysisTitle;

  /// Description for the personality analysis feature card
  ///
  /// In en, this message translates to:
  /// **'An advanced questionnaire to analyze your personality and learning styles to determine the best path for you'**
  String get featurePersonalityAnalysisDescription;

  /// Footer section title for services
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get footerServices;

  /// Footer service item: Guidance
  ///
  /// In en, this message translates to:
  /// **'Guidance'**
  String get footerServiceGuidance;

  /// Footer service item: Personality Analysis
  ///
  /// In en, this message translates to:
  /// **'Personality Analysis'**
  String get footerServicePersonalityAnalysis;

  /// Footer service item: Courses
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get footerServiceCourses;

  /// Footer section title for quick links
  ///
  /// In en, this message translates to:
  /// **'Quick Links'**
  String get footerQuickLinks;

  /// Footer quick link: Dashboard
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get footerQuickLinksDashboard;

  /// Footer quick link: Projects
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get footerQuickLinksProjects;

  /// Footer quick link: Mentoring
  ///
  /// In en, this message translates to:
  /// **'Mentoring'**
  String get footerQuickLinksMentoring;

  /// Footer description of the platform
  ///
  /// In en, this message translates to:
  /// **'A comprehensive platform for skill development and career guidance'**
  String get footerPlatformDescription;

  /// Footer contact us label
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get footerContactUs;

  /// Footer contact email address
  ///
  /// In en, this message translates to:
  /// **'info@multiversementor.com'**
  String get footerContactEmail;

  /// Footer contact phone number
  ///
  /// In en, this message translates to:
  /// **'+966 13 123 4567'**
  String get footerContactPhone;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// Welcome message below the login title
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Sign in to your account'**
  String get loginSubtitle;

  /// Label for email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Hint text for email field
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// Error message for empty email
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// Error message for invalid email
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// Label for password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Hint text for password field
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// Remember me option in login screen
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// Forgot password button
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Text between traditional and social login options
  ///
  /// In en, this message translates to:
  /// **'Or log with'**
  String get orLoginWith;

  /// Text shown to users who don't have an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// Button to create a new account
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get createAccount;

  /// Sign up screen title
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signUpTitle;

  /// Welcome message below the sign up title
  ///
  /// In en, this message translates to:
  /// **'Join us and start your journey towards a successful career'**
  String get signUpSubtitle;

  /// Label for full name field
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get labelFullname;

  /// Label for confirm password field
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Hint text for full name field
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// Error message when full name is not provided
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// Error message for invalid full name
  ///
  /// In en, this message translates to:
  /// **'Invalid full name'**
  String get fullNameInvalid;

  /// Hint text for confirm password field
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirmPasswordHint;

  /// Text shown to users who already have an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Error message for full name minimum length
  ///
  /// In en, this message translates to:
  /// **'Full name must be at least 3 characters'**
  String get fullNameMinLength;

  /// Error message for password mismatch
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// Text description in the hero section
  ///
  /// In en, this message translates to:
  /// **'Identify your skills and grow with AI.'**
  String get heroShortDescription;

  /// Title for level 1 card
  ///
  /// In en, this message translates to:
  /// **'Level 1 – Quick Check'**
  String get level1Title;

  /// Description for level 1 (mobile/desktop identical)
  ///
  /// In en, this message translates to:
  /// **'Questions: 20\nDuration: 15 – 20 minutes\nFocus: Communication, Initiative, Problem-Solving, Responsibility, Curiosity'**
  String get level1Description;

  /// Title for level 2 card
  ///
  /// In en, this message translates to:
  /// **'Level 2 – In-Depth'**
  String get level2Title;

  /// Description for level 2 shown on mobile (as in mobile layout)
  ///
  /// In en, this message translates to:
  /// **'Questions: 40\nDuration: 30 – 40 minutes\nFocus: Collaboration, Leadership, Flexibility, Time Management, Customer Handling'**
  String get level2DescriptionMobile;

  /// Description for level 2 shown on desktop (as in desktop layout)
  ///
  /// In en, this message translates to:
  /// **'Questions: 60\nDuration: 30 – 40 minutes\nFocus: Collaboration, Leadership, Flexibility, Time Management, Customer Handling'**
  String get level2DescriptionDesktop;

  /// Note that level 2 card uses a green gradient in the UI
  ///
  /// In en, this message translates to:
  /// **'Uses green gradient styling'**
  String get level2CardGradientNote;

  /// Title for level 3 card
  ///
  /// In en, this message translates to:
  /// **'Level 3 – Professional Challenge'**
  String get level3Title;

  /// Description for level 3 shown on mobile
  ///
  /// In en, this message translates to:
  /// **'Questions: 60\nDuration: More than 1 hour\nFocus: Strategic Thinking, Innovation, Long-Term Planning, Entrepreneurial Mindset'**
  String get level3DescriptionMobile;

  /// Description for level 3 shown on desktop
  ///
  /// In en, this message translates to:
  /// **'Questions: +100\nDuration: More than 1 hour\nFocus: Strategic Thinking, Innovation, Long-Term Planning, Entrepreneurial Mindset'**
  String get level3DescriptionDesktop;

  /// Short label used when starting a level (generic action text)
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startLevelAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
