import 'package:get_it/get_it.dart';
import 'package:quiz/feature/assessment/bloc/assessment_bloc.dart';
import 'package:quiz/feature/assessment/data/repositories/assessment_repository.dart';
import '../local_settings/local_settings_bloc.dart';

final getIt = GetIt.instance;

void setupDependencyInjections() {
  // Keep existing singletons
  getIt.registerSingleton<LocalSettingsBloc>(LocalSettingsBloc());

  // Register repository (implementation assumed: ChatRepositoryImpl)
  // Use lazySingleton so it is created only when needed
  getIt.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepository(),
  );

  // Register AssessmentBloc as a factory so each route gets a fresh instance
  getIt.registerFactory<AssessmentBloc>(
    () => AssessmentBloc(getIt<AssessmentRepository>()),
  );
}
