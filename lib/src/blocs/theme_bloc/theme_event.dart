part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}


class ThemeChanged extends ThemeEvent{
  final bool isDarkThemed;
  final ThemeData themeData;
  const ThemeChanged({
    required this.themeData,
    required this.isDarkThemed,
  });
}