import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  void toggleTheme() {
    final isLight = state.themeMode == ThemeMode.light || state.themeMode == ThemeMode.system;
    emit(state.copyWith(themeMode: isLight ? ThemeMode.dark : ThemeMode.light));
  }

  void setThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }
}
