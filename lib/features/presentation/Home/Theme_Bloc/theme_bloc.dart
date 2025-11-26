import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache/shared_pref_utils.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';

  ThemeBloc() : super(ThemeInitial()) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<SetThemeMode>(_onSetThemeMode);
    add(LoadTheme());
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final savedMode = SharedPrefUtils.getData(key: _themeKey) as String?;
    ThemeMode mode = ThemeMode.system;
    if (savedMode == 'light') mode = ThemeMode.light;
    if (savedMode == 'dark') mode = ThemeMode.dark;
    emit(ThemeLoaded(mode));
  }

  Future<void> _onToggleTheme(
      ToggleTheme event, Emitter<ThemeState> emit) async {
    if (state is ThemeLoaded) {
      final currentMode = (state as ThemeLoaded).themeMode;
      ThemeMode newMode =
          currentMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      await SharedPrefUtils.saveData(
          key: _themeKey, value: newMode == ThemeMode.light ? 'light' : 'dark');
      emit(ThemeLoaded(newMode));
    }
  }

  Future<void> _onSetThemeMode(
      SetThemeMode event, Emitter<ThemeState> emit) async {
    await SharedPrefUtils.saveData(
        key: _themeKey,
        value: event.themeMode == ThemeMode.light
            ? 'light'
            : event.themeMode == ThemeMode.dark
                ? 'dark'
                : 'system');
    emit(ThemeLoaded(event.themeMode));
  }
}
