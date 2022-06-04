import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/services/data_providers/team_data_provider.dart';
import 'package:footballscoreapp/src/services/repositories/team_repository.dart';
import 'package:http/http.dart' as http;

class TeamForCountryLeagus {
  final TeamRepository _repository = TeamRepository(
    dataProvider: TeamDataProvider(
      httpClient: http.Client(),
    ),
  );

  // get Teams using league Id
  Future<List<TeamModel>> getTeamsByLeagueId(int leagueId, int season) async {
    try {
      return await _repository.getTeamsByLeagueId(leagueId, season);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
