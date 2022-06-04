import 'package:footballscoreapp/favorite/favorite.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/models/team_model.dart';
import 'package:footballscoreapp/src/views/views.dart';

class FavoriteProvider {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertLeague(RouteLeagueModel leagueModel) async {
    final _leagueJson = {
      "leagueId": leagueModel.id,
      "leagueName": leagueModel.name,
      "leagueCountry": leagueModel.country,
      "leagueLogo": leagueModel.logo,
      "leagueCountryFlag": leagueModel.flag,
      "leagueSeason": leagueModel.season,
      "leagueRound": leagueModel.round ?? "League Match",
      
    };

    return await dbHelper.insertLeague(_leagueJson);
  }

  Future<int> insertTeams(TeamDetailRouteArgument leagueModel) async {
    final _leagueJson = {
      "teamId": leagueModel.team.team!.id,
      "teamName": leagueModel.team.team!.name,
      "teamCountryCode": leagueModel.team.team!.code,
      "teamCountry": leagueModel.team.team!.country,
      "teamFounded": leagueModel.team.team!.founded,
      "teamNational": leagueModel.team.team!.national,
      "teamLogo": leagueModel.team.team!.logo,
      "leagueId": leagueModel.league.id,
      "leagueName": leagueModel.league.name,
      "leagueCountry": leagueModel.league.country,
      "leagueLogo": leagueModel.league.logo,
      "leagueCountryFlag": leagueModel.league.flag,
      "leagueSeason": leagueModel.league.season,
      "leagueRound": leagueModel.league.round ?? "League Match",
    };
    return await dbHelper.insertTeam(_leagueJson);
  }

  Future<List<RouteLeagueModel>> getAllLeagues() async {
   try {
      final _dbData = await dbHelper.getAllLeagues();
    print('Leagues Data is $_dbData');
    final _favLeagues =  _dbData
        .map((_leagueMap) => RouteLeagueModel(
        id: _leagueMap['leagueId'],
        name: _leagueMap['leagueName'],
        country: _leagueMap['leagueCountry'],
        logo: _leagueMap['leagueLogo'],
        flag: _leagueMap['leagueCountryFlag'],
        season: _leagueMap['leagueSeason'],
        round: _leagueMap['leagueRound'],
      ))
        .toList();
      print('the falv leagues are $_favLeagues');

    return _favLeagues;
     
   } catch (e) {
     print("Get all leagues error ${e.toString()}");
     throw Exception(e.toString());
   }
  }

  Future<List<TeamDetailRouteArgument>> getAllTeams() async {
    
    final _dbData = await dbHelper.getAllTeams();
    print('Team National ${_dbData.first['teamNational']}');
    return _dbData.map((_dbMap) {
      final _team = TeamModel(
          team: Team(
        id: _dbMap['teamId'],
        name: _dbMap['teamName'],
        code: _dbMap['teamCountryCode'],
        country: _dbMap['teamCountry'],
        founded: 1990,
        logo: _dbMap['teamLogo'],
        national:  false,
      ));
      final _league = RouteLeagueModel(
        id: _dbMap['leagueId'],
        name: _dbMap['leagueName'],
        country: _dbMap['leagueCountry'],
        logo: _dbMap['leagueLogo'],
        flag: _dbMap['leagueCountryFlag'],
        season: _dbMap['leagueSeason'],
        round: _dbMap['leagueRound'],
      );
      return TeamDetailRouteArgument(league: _league, team: _team);
    }).toList();
  }

  Future<int?> leaguesQueryRowCount() async {
    return await dbHelper.leaguesQueryRowCount();
  }

  Future<int?> teamsQueryRowCount() async {
    return await dbHelper.teamsQueryRowCount();
  }

  Future<int> deleteLeague(int id) async {
    return await dbHelper.deleteLeague(id);
  }

  Future<int> deleteTeam(int id) async {
    return await dbHelper.deleteTeam(id);
  }

  Future<bool> isLeagueFavorite(int id) async{
    final _response = await dbHelper.isLeagueFound(id);
    return _response.isNotEmpty;
  }
  Future<bool> isTeamFavorite(int id) async{
    final _response = await dbHelper.isTeamFound(id);
    return _response.isNotEmpty;
  }
}
