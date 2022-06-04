import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballscoreapp/favorite/favorite_provide.dart';
import 'package:footballscoreapp/src/blocs/blocs.dart';
import 'package:footballscoreapp/src/blocs/standing_bloc/standing_bloc.dart';
import 'package:footballscoreapp/src/blocs/team_player_boc/teamplayer_bloc.dart';
import 'package:footballscoreapp/src/blocs/theme_bloc/theme_bloc.dart';
import 'package:footballscoreapp/src/config/themes/theme_data.dart';
import 'package:footballscoreapp/src/config/themes/theme_preference.dart';
import 'package:footballscoreapp/src/config/routes/routes.dart';
import 'package:footballscoreapp/src/services/data_providers/data_providers.dart';
import 'package:footballscoreapp/src/services/data_providers/player_data_provider.dart';
import 'package:footballscoreapp/src/services/data_providers/standings.dart';
import 'package:footballscoreapp/src/services/repositories/player_repository.dart';
import 'package:footballscoreapp/src/services/repositories/repositories.dart';
import 'package:footballscoreapp/src/services/repositories/standings.dart';
import 'package:http/http.dart' as http;

import 'src/blocs/country_bloc/country_bloc.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  FavoriteProvider();

  final LeaguesRepository _leaguesRepository = LeaguesRepository(
    leaguesDataProvider: LeaguesDataProvider(
      httpClient: http.Client(),
    ),
  );

  final CountryRepository _countryRepository = CountryRepository(
    dataProvider: CountryDataProvider(
      httpClient: http.Client(),
    ),
  );
  final GameMatchesRepository _gameMatchesRepository = GameMatchesRepository(
    matchesDataProvider: MatchesDataProvider(
      httpClient: http.Client(),
    ),
  );
  final StandingsRepository _standingsRepository = StandingsRepository(
    dataProvider: StandingsDataProvider(
      httpClient: http.Client(),
    ),
  );
  final PlayerRepository _playerRepository = PlayerRepository(
      dataProvider: PlayerDataProvider(httpClient: http.Client()));
  DarkThemePreference _darkThemePreference = DarkThemePreference();

  bool _isDarkTheme = await _darkThemePreference.getTheme();
  String _fontSize = await _darkThemePreference.getFontSize();
  ThemeData _themeData = Styles().themeData(_isDarkTheme, _fontSize);
  ThemeBloc _themeBloc = ThemeBloc(themeData: _themeData);

  runApp(FootballScoreApp(
    leaguesRepository: _leaguesRepository,
    countryRepository: _countryRepository,
    gameMatchesRepository: _gameMatchesRepository,
    standingsRepository: _standingsRepository,
    playerRepository: _playerRepository,
    themeBloc: _themeBloc,
  ));
}

class FootballScoreApp extends StatelessWidget {
  const FootballScoreApp(
      {required this.leaguesRepository,
      required this.countryRepository,
      required this.gameMatchesRepository,
      required this.standingsRepository,
      required this.playerRepository,
      required this.themeBloc,
      Key? key})
      : super(key: key);
  final LeaguesRepository leaguesRepository;
  final CountryRepository countryRepository;
  final GameMatchesRepository gameMatchesRepository;
  final StandingsRepository standingsRepository;
  final PlayerRepository playerRepository;
  final ThemeBloc themeBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => LeagueBloc(leaguesRepository: leaguesRepository)
            ..add(
              GetLeaguesEvent(),
            )),
        ),
        BlocProvider(
          create: (context) => CountryBloc(repository: countryRepository)
            ..add(FetchAllCountries()),
        ),
        BlocProvider(
          create: ((context) =>
              GamematchBloc(gameMatchesRepository: gameMatchesRepository)),
        ),
        BlocProvider(
          create: ((context) => StandingBloc(repository: standingsRepository)),
        ),
        BlocProvider(
            create: (create) => TeamplayerBloc(repository: playerRepository)),
            BlocProvider<ThemeBloc>(
        create: (context) => themeBloc)
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          debugPrint('THe Material theme state is ${state.themeData.scaffoldBackgroundColor}');
          return MaterialApp(
            onGenerateRoute: AppRoute.generateRoute,
            theme: state.themeData,
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


// ThemeData(
//                 primarySwatch: createMaterialColor(kPrimaryColor2),
//                 primaryColor: kPrimaryColor,
//               )