
import 'package:get_it/get_it.dart';

import '../local_settings/local_settings_bloc.dart';

final getIt = GetIt.instance;

void setupDependencyInjections() {
  getIt.registerSingleton<LocalSettingsBloc>(LocalSettingsBloc());


}