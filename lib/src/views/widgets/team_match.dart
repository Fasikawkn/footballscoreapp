import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/league_widget/league_detail_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TeamMatch extends StatelessWidget {
  // final leag.League league;
  const TeamMatch(
      {required this.games, required this.date, Key? key})
      : super(key: key);
  final String date;
  final List<GameMatch> games;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 1.0),
      child: ExpansionTile(
        textColor: kWhiteColor,
        iconColor: kgreyColor,
        initiallyExpanded: false,
        collapsedIconColor: kgreyColor,
        collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        childrenPadding: EdgeInsets.zero,
        title: Row(
          children: [
            CustomCachedNetworkImage(
              width: 20.0,
              url: games.first.league!.logo.toString(),
              placeholder: 'assets/images/team_placeholder_image.png',
            ),
            const SizedBox(
              width: 20.0,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    screen: LeagueDetailView(
                      league: RouteLeagueModel.fromJson(games.first.league!.toJson())
                      
                    ),
                    settings: const RouteSettings(
                      name: LeagueDetailView.routeName,
                      arguments: 2,
                    ),
                  );
                },
                child: Text(
                  '${games.first.league!.country!} - ${ games.first.league!.name}',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
        children: games
            .map((match) => GestureDetector(
                  onTap: () {
                    pushNewScreenWithRouteSettings(
                      context,
                      screen: MatchDetail(
                        matchDetailRouteArgument: MatchDetailRouteArgument(
                            gameMatch: match, 
                            league: RouteLeagueModel.fromJson(match.league!.toJson()),
                            ),
                      ),
                      settings: const RouteSettings(
                        name: MatchDetail.routeName,
                      ),
                    );
                  },
                  child: SingleMatchWidget(
                    match: match,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
