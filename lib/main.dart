import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tamer/pages/splash_page.dart';

import 'env/env.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tamer/theme/app_theme.dart';
import 'package:task_tamer/theme/cubit/theme_cubit.dart';
import 'package:task_tamer/theme/cubit/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Supabase.initialize(
      url: Env.supabaseUrl.trim(),
      publishableKey: Env.supabaseAnonKey.trim(),
    );
  } catch (e) {
    debugPrint('Error inicializando Supabase: $e');
  }

  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Task Tamer',
          themeMode: state.themeMode,
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme, // Si se implementa
          home: const SplashPage(),
        );
      },
    );
  }
}

