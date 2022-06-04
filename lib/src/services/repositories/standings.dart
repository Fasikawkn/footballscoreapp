import 'package:footballscoreapp/src/models/team_table_data.dart';
import 'package:footballscoreapp/src/services/data_providers/standings.dart';

class StandingsRepository {
  final StandingsDataProvider dataProvider;

  StandingsRepository({
    required this.dataProvider,
  });

  // Get All Standing Informations

  Future<LeagueTable> getStandingInfo(int leagueId, int season) async {
    final _jsonResponse = await dataProvider.getStandingData(leagueId, season);
    final _response = _jsonResponse['response'] as List;
    final _league = _response.first['league'] as Map<String, dynamic>;
    final _standings = _league['standings'] as List;
    final _standingsFirst = _standings.first as List;
    LeagueTable _leagueTable = LeagueTable.fromJson(_league);

    List<TableData> _tableData = _standingsFirst
        .map((tableData) => TableData.fromJson(tableData))
        .toList();
    LeagueTable _leagueTableData = _leagueTable.copyWith(tableData: _tableData);

    return _leagueTableData;
  }

  // get stat for the team
  Future<LeagueTable> getStateDataForTeam(int leagueId, int season, int teamId) async{
     final _jsonResponse = await dataProvider.getStateDataForTeam(leagueId, season, teamId);
    final _response = _jsonResponse['response'] as List;
    final _league = _response.first['league'] as Map<String, dynamic>;
    final _standings = _league['standings'] as List;
    final _standingsFirst = _standings.first as List;
    LeagueTable _leagueTable = LeagueTable.fromJson(_league);

    List<TableData> _tableData = _standingsFirst
        .map((tableData) => TableData.fromJson(tableData))
        .toList();
    LeagueTable _leagueTableData = _leagueTable.copyWith(tableData: _tableData);

    return _leagueTableData;
  }
}
