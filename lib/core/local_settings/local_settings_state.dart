part of 'local_settings_bloc.dart';

@freezed
class LocalSettingsState with _$LocalSettingsState {
  const factory LocalSettingsState({
    @Default('ar') String local,
    @Default(false) bool isDarkMode,
    @Default("SAR") String currencyCode,
    @Default('Roboto') String englishFont,
    @Default('Cairo') String arabicFont,
    @Default(false) bool isTable,
  }) = _LocalSettingsState;

  factory LocalSettingsState.fromJson(Map<String, dynamic> json) =>
      _$LocalSettingsStateFromJson(json);
}

extension LocalSettingsExtension on LocalSettingsState {
  TextTheme get currentTextTheme => local == 'ar'
      ? GoogleFonts.getTextTheme(arabicFont)
      : GoogleFonts.getTextTheme(englishFont);

}
