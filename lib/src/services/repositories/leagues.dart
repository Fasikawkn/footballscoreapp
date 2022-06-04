import 'package:footballscoreapp/src/models/league.dart';
import 'package:footballscoreapp/src/services/data_providers/leagues.dart';


class LeaguesRepository{
  final LeaguesDataProvider leaguesDataProvider;

  LeaguesRepository({
    required this.leaguesDataProvider,
  });

  // Get all leagues data -> names, season, id...

  Future<List<League>> getAllLeaguesData() async{

    final _jsonResponse = await leaguesDataProvider.getAllLeaguesData();
    final _responseList = _jsonResponse['response'] as List;
    return _responseList.map((response) => League.fromJson(response)).toList();
    

  }

  // Get all leages if a country;
  Future<List<League>> getLeagueByCountryName(String name) async{
    final _jsonResponse = await leaguesDataProvider.getLeagueByCountryName(name);
    final _response = _jsonResponse['response'] as List;
    return _response.map((country) => League.fromJson(country)).toList();
  }

  // get leagues by teamId
  Future<List<League>> getLeagueByTeamId(int teamId) async{
    final _jsonResponse = await leaguesDataProvider.getLeagueByTeamId(teamId);
    final _response = _jsonResponse['response'] as List;
    return _response.map((league) => League.fromJson(league)).toList();
  }

  
}