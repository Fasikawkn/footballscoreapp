import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/team_widget/team_matches_tile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LeagueMatchesTile extends StatelessWidget {
  const LeagueMatchesTile(
      {required this.league, required this.gameMatch, Key? key})
      : super(key: key);

  final LeagueGameMatch gameMatch;
  final League league;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3.0),
      child: ExpansionTile(
        textColor: kWhiteColor,
        iconColor: kgreyColor,
        initiallyExpanded: false,
        collapsedIconColor: kgreyColor,
        collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        childrenPadding: EdgeInsets.zero,
        title: Text(
          gameMatch.date,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        children: gameMatch.games
            .map((game) => GestureDetector(
                  child: GestureDetector(
                    onTap: () {
                      pushNewScreenWithRouteSettings(
                        context,
                        screen: MatchDetail(
                          matchDetailRouteArgument: MatchDetailRouteArgument(
                              gameMatch: game, 
                              league: RouteLeagueModel.fromJson(
                                league.toJson()
                              )
                              ),
                        ),
                        settings: const RouteSettings(
                          name: MatchDetail.routeName,
                        ),
                      );
                    },
                    child: MatchTeamDetail(
                      gameMatch: game,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
