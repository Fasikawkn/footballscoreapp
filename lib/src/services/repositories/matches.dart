import 'package:footballscoreapp/src/models/fixture_event.dart';
import 'package:footballscoreapp/src/models/fixture_lineups.dart';
import 'package:footballscoreapp/src/models/fixture_statistics.dart';
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/services/data_providers/maches.dart';

class GameMatchesRepository {
  final MatchesDataProvider matchesDataProvider;

  GameMatchesRepository({
    required this.matchesDataProvider,
  });

  // Get GameMatches by Date
  Future<List<GameMatch>> getFixtureByDate(DateTime dateTime) async{
    final _jsonResponse =
        await matchesDataProvider.getFixtureByDate(dateTime);
    final _responseList = _jsonResponse['response'] as List;
    return _responseList
        .map((response) => GameMatch.fromJson(response))
        .toList();

  }


  // Get Maches by League Id;

  Future<List<GameMatch>> getMachesByLeagueId(
      String date, int season, String leagueId) async {
    final _jsonResponse =
        await matchesDataProvider.getMachesByLeagueId(date, season, leagueId);
    final _responseList = _jsonResponse['response'] as List;
    return _responseList
        .map((response) => GameMatch.fromJson(response))
        .toList();
  }

  Future<List<GameMatch>> getMatchesByLeagueIdTeamId(
      int leagueId, int season, int teamId) async {
    final _jsonResponse = await matchesDataProvider.getMatchesByLeagueIdTeamId(
        leagueId, season, teamId);
    final _responseList = _jsonResponse['response'] as List;
    return _responseList
        .map((response) => GameMatch.fromJson(response))
        .toList();
  }

  // Get Matches by leagueId;
  Future<List<GameMatch>> getMatchesByLeagueIdAndDate(int leagueId, int season) async{
final _jsonResponse = await matchesDataProvider.getMatchesByLeagueIdAndDate(leagueId, season);
    final _responseList = _jsonResponse['response'] as List;
    return _responseList
        .map((response) => GameMatch.fromJson(response))
        .toList();
  }


  // Get Fixture statistics
  Future<List<FixtureStatistics>> getFixtureStatisticsById(int fixtureId) async{
    final _jsonResponse = await matchesDataProvider.getFixtureStatisticsById(fixtureId);
    final _response = _jsonResponse['response'] as List;
    return _response.map((stats) => FixtureStatistics.fromJson(stats)).toList();
  }

  // get fixture lineups
  Future<List<TeamLineupModel>> getFixtureLineups(int fixtureId) async{

    final _jsonResponse = await matchesDataProvider.getFixtureLineups(fixtureId);
    final _response = _jsonResponse['response'] as List;
    return _response.map((stats) => TeamLineupModel.fromJson(stats)).toList();
  }

  // get Fixture events

  Future<List<FixtureEvent>> getFixtureEvents(int fixtureId) async{
    final _jsonResponse = await matchesDataProvider.getFixtureEvents(fixtureId);
    final _response = _jsonResponse['response'] as List;
    return _response.map((events) => FixtureEvent.fromJson(events)).toList();
  }
}
