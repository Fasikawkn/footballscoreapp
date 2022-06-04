import 'package:collection/collection.dart';
import 'package:footballscoreapp/src/models/coache.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/models/team_player_model.dart';
import 'package:footballscoreapp/src/models/team_table_data.dart';
import 'package:footballscoreapp/src/services/data_providers/player_data_provider.dart';
import 'package:footballscoreapp/src/services/data_providers/standings.dart';
import 'package:footballscoreapp/src/services/repositories/player_repository.dart';
import 'package:footballscoreapp/src/services/repositories/standings.dart';
import 'package:http/http.dart' as http;

class TeamStatData {
  static final StandingsRepository _standingRepository = StandingsRepository(
    dataProvider: StandingsDataProvider(httpClient: http.Client()),
  );

  static final PlayerRepository _playerRepository = PlayerRepository(
      dataProvider: PlayerDataProvider(httpClient: http.Client()));

  static Future<LeagueTable> getTeamState(
      int leagueId, int season, int teamId) async {
    try {
      final _response = await _standingRepository.getStateDataForTeam(
          leagueId, season, teamId);
      return _response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<LeagueTable> getStandingInfo(int leagueId, int season) async {
    try {
      final _response =
          await _standingRepository.getStandingInfo(leagueId, season);
      return _response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // static Future<List<TeamPlayerModel>> getPlayersForTheTeam(int teamId) async{
  //   try {
  //     final _response = await _playerRepository.getPlayersForTheTeam(teamId);
  //     return _response;

  //   } catch (e) {
  //   }
  // }
  static Future<Map<String?, List<PlayerStatistics>>>
      getTeamPlayerStatisticsByPosition(
          int leagueId, int season, int teamId) async {
    try {
      final _response =
          await _playerRepository.getPlayerStatistics(leagueId, season, teamId);
      final _group = groupBy(_response, (PlayerStatistics statistics) {
        return statistics.statistics!.first.games!.position;
      });
      return _group;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<PlayerStatistics>> getTeamPlayerStatistics(
      int leagueId, int season, int teamId) async {
    try {
      final _response =
          await _playerRepository.getPlayerStatistics(leagueId, season, teamId);
      return _response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<CoachModel>> getTeamCoach(int teamId) async {
    try {
      final _response = await _playerRepository.getCoach(teamId);

      return _response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<PlayerStatistics>> getTopScorrers(
      int leagueId, int season) async {
        
    try {
      final _response =
          await _playerRepository.getTopScoreress(leagueId, season);
     
      return _response;
    } catch (e) {
     

      throw Exception(e.toString());
    }
  }
}
