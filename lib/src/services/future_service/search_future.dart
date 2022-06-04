


import 'package:footballscoreapp/src/models/league.dart' as league;
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/services/repositories/search_respository.dart';

class SearchFuture{
  final SearchRespository _searchRespository = SearchRespository();

  // Search in Future in leagues
  Future<List<league.League>> searchLeagues(String search) async{
    try {
      final _responseJson = await _searchRespository.searchLeague(search);
      return _responseJson;
     
      
    } catch (e) {
      throw Exception(e.toString());
    }
    
  }

  // search Future in teams
  Future<List<TeamModel>> searchTeams(String search) async{
    try {
      final _responseJson = await _searchRespository.searchTeam(search);
      return _responseJson;
     
    } catch (e) {
      throw Exception(e.toString());
    }
   
  }

  // Search in Future in player
   Future<List<PlayerStatistics>> searchPlayers(String search, int leagueId) async{
   
    try {
      final _responseJson = await _searchRespository.searchPlayer(search, leagueId);
      return _responseJson;
     
    } catch (e) {
      print('search player error is ${e.toString()}');
      throw Exception(e.toString());
    }
    
  }


}