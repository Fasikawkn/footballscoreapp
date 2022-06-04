import 'package:collection/collection.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/fixture_event.dart';
import 'package:footballscoreapp/src/models/fixture_lineups.dart';
import 'package:footballscoreapp/src/models/fixture_statistics.dart';
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/services/services.dart';
import 'package:http/http.dart' as http;

class MatchesFuture {
  static final GameMatchesRepository _gameMatchesRepository =
      GameMatchesRepository(
    matchesDataProvider: MatchesDataProvider(
      httpClient: http.Client(),
    ),
  );

  static Future<List<GameMatchesHome>> getHomeGameMatches(
      DateTime dateTime) async {
    try {
      final _response = await _gameMatchesRepository.getFixtureByDate(dateTime);
      final _groupResponse = groupBy(_response, (GameMatch gamematch) {
        return gamematch.league!.id;
      });
      return _groupResponse.entries
          .map((entry) =>
              GameMatchesHome(gameMatches: entry.value, leagueId: entry.key!))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<GameMatch>> getMatchesByLeagueIdTeamId(
      int leagueId, int season, int teamId) async {
    try {
      final _response = await _gameMatchesRepository.getMatchesByLeagueIdTeamId(
          leagueId, season, teamId);
      return _response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<GameMatch>> getMatchesByleagueId(
      String date, int season, String leagueId) async {
    try {
      final _response = await _gameMatchesRepository.getMachesByLeagueId(
          date, season, leagueId);
      return _response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<LeagueGameMatch>> getLeagueGamesMatches(
    int leagueId,
    int season,
  ) async {
    try {
      final _response = await _gameMatchesRepository
          .getMatchesByLeagueIdAndDate(leagueId, season);
      final _group = groupBy(_response, (GameMatch match) {
        String _date = formatDateBySlash(match.fixture!.date!);
        return _date;
      });

      List<LeagueGameMatch> _leagueGames = _group.entries
          .map((entry) => LeagueGameMatch(date: entry.key, games: entry.value))
          .toList();
      return _leagueGames;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<FixtureStatistics>> getFixtureStatisticsById(
      int fixtureId) async {
    try {
      final _response =
          await _gameMatchesRepository.getFixtureStatisticsById(fixtureId);
      return _response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // get Fixture lineups
  static Future<List<TeamLineupModel>> getTeamLineUps(int fixtureId) async {
    print(
        'The fixureId is $fixtureId==========================================');
    try {
      final _response =
          await _gameMatchesRepository.getFixtureLineups(fixtureId);
      return _response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<FixtureEvent>> getFixtureEvents(int fixtureId) async {
    try {
      final _response =
          await _gameMatchesRepository.getFixtureEvents(fixtureId);
      return _response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
