import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/league.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/league_widget/league_detail_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LeaguesSearchPage extends StatelessWidget {
  const LeaguesSearchPage({required this.searchedLeagues, Key? key})
      : super(key: key);
  final List<League> searchedLeagues;

  @override
  Widget build(BuildContext context) {
    debugPrint(searchedLeagues.toString());
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: ListView(
        children: searchedLeagues
            .map(
              (league) => LeagueSearchTile(
                leagueModel: RouteLeagueModel(
                  country: league.country!.name,
                  flag: league.country!.flag,
                  id: league.league!.id,
                  logo: league.league!.logo,
                  name: league.league!.name,
                  round: "League game",
                  season: league.seasons!.last.year,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class LeagueSearchTile extends StatelessWidget {
  final RouteLeagueModel leagueModel;
  const LeagueSearchTile({
    required this.leagueModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        pushNewScreenWithRouteSettings(
          context,
          screen: LeagueDetailView(league: leagueModel),
          settings: const RouteSettings(
            name: LeagueDetailView.routeName,
            arguments: 2,
          ),
        );
      }),
      child: Container(
        padding: const EdgeInsets.only(left: 20.0),
        color: Theme.of(context).colorScheme.secondary,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: kgreyColor,
            width: 0.4,
          ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCachedNetworkImage(
                url: leagueModel.logo.toString(),
                placeholder: 'assets/images/ball_one.png',
                width: 40.0,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leagueModel.name.toString(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyText1!.fontSize! + 2
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  Text(
                    leagueModel.country.toString(),
                    style: const TextStyle(
                      color: kgreyColor,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
