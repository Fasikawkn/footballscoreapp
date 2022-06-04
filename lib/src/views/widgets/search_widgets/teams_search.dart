import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/team_widget/team_detail.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TeamsSearchPage extends StatelessWidget {
  const TeamsSearchPage({required this.searchedTeams, Key? key})
      : super(key: key);
  final List<TeamModel> searchedTeams;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: ListView(
        children: searchedTeams
            .map((_searchedTeam) => TeamSearchTile(teamModel: _searchedTeam))
            .toList(),
      ),
    );
  }
}

class TeamSearchTile extends StatelessWidget {
  const TeamSearchTile({required this.teamModel, Key? key}) : super(key: key);
  final TeamModel teamModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        pushNewScreenWithRouteSettings(
          context,
          screen: TeamDetailPage(
            teamDetail: TeamDetailRouteArgument(
              league: RouteLeagueModel(),
              team: teamModel,
              isFromSearch: true
            ),
          ),
          settings: RouteSettings(
            name: TeamDetailPage.routeName,
            arguments: teamModel,
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
              const Icon(
                Icons.group_outlined,
                color: kgreyColor,
                size: 30.0,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teamModel.team!.name.toString(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyText1!.fontSize! + 2
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    teamModel.team!.country.toString(),
                    style: const TextStyle(
                        color: kgreyColor,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700),
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
