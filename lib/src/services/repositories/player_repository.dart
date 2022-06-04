import 'package:footballscoreapp/src/models/coache.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/models/team_player_model.dart';
import 'package:footballscoreapp/src/services/data_providers/player_data_provider.dart';

class PlayerRepository {
  final PlayerDataProvider dataProvider;
  PlayerRepository({
    required this.dataProvider,
  });

  // get player squad
  Future<List<TeamPlayerModel>> getPlayersForTheTeam(int teamId) async {
    final _jsonResponse = await dataProvider.getPlayersForTheTeam(teamId);
    final _response = _jsonResponse['response'] as List;
    final _responseFirst = _response.first as Map<String, dynamic>;
    final _players = _responseFirst['players'] as List;

    return _players.map((player) => TeamPlayerModel.fromJson(player)).toList();
  }

  Future<List<PlayerStatistics>> getPlayerStatistics(
      int leagueId, int season, int teamId) async {
    final _jsonResponse =
        await dataProvider.getPlayerStatistics(leagueId, season, teamId);
    final _response = _jsonResponse['response'] as List;
    return _response
        .map((jsonStatistics) => PlayerStatistics.fromJson(jsonStatistics))
        .toList();
  }

  Future<List<CoachModel>> getCoach(int teamId) async{
    final _jsonResponse = await dataProvider.getCoaches(teamId);
    final _response = _jsonResponse['response'] as List;
    return _response.map((coachJson) => CoachModel.fromJson(coachJson)).toList();
  } 

  Future<List<PlayerStatistics>> getTopScoreress(int leagueId, int season) async {
    final _jsonResponse = await dataProvider.getTopScoreress(leagueId, season);
      final _response = _jsonResponse['response'] as List;
    return _response
        .map((jsonStatistics) => PlayerStatistics.fromJson(jsonStatistics))
        .toList();
  }
}
