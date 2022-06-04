import 'package:footballscoreapp/src/models/league.dart';
import 'package:footballscoreapp/src/services/data_providers/data_providers.dart';
import 'package:footballscoreapp/src/services/repositories/leagues.dart';
import 'package:http/http.dart' as http;

class CountryLeague {
  static final LeaguesRepository _leaguesRepository = LeaguesRepository(
    leaguesDataProvider: LeaguesDataProvider(
      httpClient: http.Client(),
    ),
  );

  static Future<List<League>> getCountryLeague(String countryName) async {
    try {
      final _response =
          await _leaguesRepository.getLeagueByCountryName(countryName);
          if(_response.length >= 10){
            return _response.sublist(0,10);
          }else {
            return _response;
          }
      
    } catch (e) {

      throw Exception(e.toString());
    }
  }

  // get leagues all
   static Future<List<League>> getAllLeaguesData() async{
      try {
        final _response = await _leaguesRepository.getAllLeaguesData();
        return _response;
        
      } catch (e) {
        throw Exception(e.toString());
      }

    }

    // get league by teamId
     Future<List<League>> getLeagueByTeamId(int teamId) async{
       try {
         final _jsonResponse = await _leaguesRepository.getLeagueByTeamId(teamId);
         return _jsonResponse;
       } catch (e) {
         throw Exception(e.toString());
       }
     }
}
