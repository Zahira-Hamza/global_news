import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache/shared_pref_utils.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String _languageKey = 'language_code';

  LanguageBloc() : super(LanguageInitial()) {
    on<LoadLanguage>(_onLoadLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
    add(LoadLanguage()); // Load language when BLoC starts
  }

  Future<void> _onLoadLanguage(
      LoadLanguage event, Emitter<LanguageState> emit) async {
    final savedCode = SharedPrefUtils.getData(key: _languageKey) as String?;
    Locale locale = const Locale('en'); // Default to English
    if (savedCode == 'ar') locale = const Locale('ar');
    emit(LanguageLoaded(locale));
  }

  Future<void> _onChangeLanguage(
      ChangeLanguage event, Emitter<LanguageState> emit) async {
    await SharedPrefUtils.saveData(
        key: _languageKey, value: event.locale.languageCode);
    emit(LanguageLoaded(event.locale));
  }
}
