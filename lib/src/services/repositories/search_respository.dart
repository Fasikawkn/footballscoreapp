

import 'package:footballscoreapp/src/models/league.dart' as league;
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/models/team_model.dart';

import 'package:footballscoreapp/src/services/data_providers/search_data_provider.dart';

class SearchRespository{
  final SearchDataProvider _searchDataProvider = SearchDataProvider();

  // search in leagues
  Future<List<league.League>> searchLeague(String search) async{

    final _response = await _searchDataProvider.searchLeague(search);
    final _responseList = _response['response'] as List;
    return _responseList.map((response) => league.League.fromJson(response)).toList();
  }

  // search in teams 
  Future<List<TeamModel>> searchTeam(String search) async{
      final _jsonResponse = await _searchDataProvider.searchTeams(search);
      final _response = _jsonResponse['response'] as List;
    
    return _response.map((team) => TeamModel.fromJson(team)).toList();

  }

  // Search in players
  Future<List<PlayerStatistics>> searchPlayer(String search, int leagueId) async{
    final _jsonResponse = await _searchDataProvider.searchPlayer(search, leagueId);
      final _response = _jsonResponse['response'] as List;
    return _response
        .map((jsonStatistics) => PlayerStatistics.fromJson(jsonStatistics))
        .toList();
  }
}