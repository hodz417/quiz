import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mentor/core/utils/theme/theme_constants.dart';

part 'local_settings_event.dart';
part 'local_settings_state.dart';
part 'local_settings_bloc.g.dart';
part 'local_settings_bloc.freezed.dart';

class LocalSettingsBloc
    extends HydratedBloc<LocalSettingsEvent, LocalSettingsState> {
  LocalSettingsBloc() : super(const LocalSettingsState()) {
    on<ChangeLocale>(_onChangeLocale);
    on<ChangeFont>(_onChangeFont);
    on<_ConfigureEasyLoading>(_onConfigureEasyLoading);
    add(_ConfigureEasyLoading());
  }

  void _onConfigureEasyLoading(
      _ConfigureEasyLoading event, Emitter<LocalSettingsState> emit) {
    state.isDarkMode
        ? ThemeConstants.configureEasyLoadingDark()
        : ThemeConstants.configureEasyLoadingLight();
  }

  void _onChangeLocale(ChangeLocale event, Emitter<LocalSettingsState> emit) {
    emit(state.copyWith(local: event.newLocale));
  }

  void _onChangeFont(ChangeFont event, Emitter<LocalSettingsState> emit) {
    if (event.isArabic) {
      emit(state.copyWith(arabicFont: event.newFont));
    } else {
      emit(state.copyWith(englishFont: event.newFont));
    }
  }



  @override
  LocalSettingsState? fromJson(Map<String, dynamic> json) {
    return LocalSettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LocalSettingsState state) {
    return state.toJson();
  }
}
