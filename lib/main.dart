import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mentor/core/utils/app_logger.dart';
import 'package:mentor/core/utils/di.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mentor/core/utils/l10n/app_localizations.dart';
import 'package:mentor/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';
import 'core/local_settings/local_settings_bloc.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy(); // remove # from web URL

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HydratedBloc.storage = storage;

  setupDependencyInjections();
  Bloc.observer = AppLogger.talkerBlocObserver;
  runApp(MyApp(appRouter: AppRouter()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalSettingsBloc, LocalSettingsState>(
      bloc: getIt<LocalSettingsBloc>(),
      buildWhen: (p, c) => p != c,
      builder: (context, state) {
        return ScreenUtilInit(
      designSize: const Size(1440, 900),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              title: 'Mentor',
              routerConfig: appRouter.router,
              locale: Locale(state.local),
              builder: EasyLoading.init(),
            );
          },
        );
      },
    );
  }
}
