

import 'package:footballscoreapp/src/models/team_model.dart';
import 'package:footballscoreapp/src/services/data_providers/team_data_provider.dart';

class TeamRepository{
  final TeamDataProvider dataProvider;

  TeamRepository({
    required this.dataProvider,
  });

  // get Teams by CountryName

  Future<List<TeamModel>> getTeamsByLeagueId(int leagueId, int season) async{
    final _jsonResponse = await  dataProvider.getTeamsByLeagueId(leagueId, season);
    final _response = _jsonResponse['response'] as List;
    
    return _response.map((team) => TeamModel.fromJson(team)).toList();
  }
}