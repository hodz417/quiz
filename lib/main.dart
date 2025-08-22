// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/feature/chat/bloc/chat_bloc.dart';
import 'package:quiz/feature/chat/data/repositories/chat_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quiz/feature/landing/ui/pages/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return RepositoryProvider(
          create: (_) => ChatRepository(),
          child: BlocProvider(
            create: (context) => ChatBloc(context.read<ChatRepository>()),
            child: const MyApp(),
          ),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'منتور المتعدد العوالم',
      locale: const Locale('ar'), // 👈 إجبار التطبيق على العربية
      supportedLocales: const [Locale('ar')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const LandingPage(),
    );
  }
}
