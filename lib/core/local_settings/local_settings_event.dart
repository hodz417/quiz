part of 'local_settings_bloc.dart';

abstract class LocalSettingsEvent {}

class ChangeLocale extends LocalSettingsEvent {
  final String newLocale;
  ChangeLocale(this.newLocale);
}

class ChangeColorScheme extends LocalSettingsEvent {
  final FlexScheme newScheme;
  ChangeColorScheme(this.newScheme);
}

class ToggleTheme extends LocalSettingsEvent {}

class _ConfigureEasyLoading extends LocalSettingsEvent {}

class ChangeFont extends LocalSettingsEvent {
  final String newFont;
  final bool isArabic;
  ChangeFont(this.newFont, this.isArabic);
}




class IsShowTable extends LocalSettingsEvent {
  final bool isTable ;
  IsShowTable(this.isTable);
}