import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/config/themes/theme_preference.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final DarkThemePreference _darkThemePreference = DarkThemePreference();

  final ThemeData themeData;

  ThemeBloc({required this.themeData}) : super(ThemeState(themeData)) {
    on<ThemeChanged>(_mapThemeChage);
  }
  void _mapThemeChage(ThemeChanged event, Emitter<ThemeState> emit) async {
    await _darkThemePreference.setDarkTheme(event.isDarkThemed);

    emit(ThemeState(event.themeData));
  }
}
