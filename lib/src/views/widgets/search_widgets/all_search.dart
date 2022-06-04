import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/models/team_model.dart';
import 'package:footballscoreapp/src/models/league.dart' as league;
import 'package:footballscoreapp/src/views/widgets/search_widgets/leagues_search.dart';
import 'package:footballscoreapp/src/views/widgets/search_widgets/players_search.dart';
import 'package:footballscoreapp/src/views/widgets/search_widgets/teams_search.dart';


class AllSearchPage extends StatelessWidget {
  const AllSearchPage({
    required this.allSearchedData,
     Key? key }) : super(key: key);
 final List allSearchedData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: ListView(
        children: allSearchedData
            .map((_model) {
              if(_model is TeamModel){
                return TeamSearchTile(teamModel: _model);

              }else if(_model is league.League){
                var league = _model;
                return LeagueSearchTile(
                  leagueModel: RouteLeagueModel(
                    country: league.country!.name,
                    flag: league.country!.flag,
                    id: league.league!.id,
                    logo: league.league!.logo,
                    name: league.league!.name,
                    round: "League game",
                    season: league.seasons!.last.year,
                  ),
                );
              }else{
                PlayerStatistics p = _model as PlayerStatistics;
                return SearchPlayerTile(player: p);
              }
              
            }
                )
            .toList(),
      ),
    );
  }
}