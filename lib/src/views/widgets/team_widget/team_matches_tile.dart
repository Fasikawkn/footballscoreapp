import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/views/views.dart';

class TeamDetailMatchTile extends StatelessWidget {
  const TeamDetailMatchTile({ 
    required this.child,
    required this.date,
    Key? key }) : super(key: key);
  final String date;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 1.0),
      child: ExpansionTile(
        textColor: kWhiteColor,
        iconColor: kgreyColor,

        initiallyExpanded: true,
        collapsedIconColor: kgreyColor,
        collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        childrenPadding: EdgeInsets.zero,
        title:  Text(
              date,
              style: Theme.of(context).textTheme.bodyText1,
            ),
        children: [child],
      ),
    );
  }
}


class MatchTeamDetail extends StatelessWidget {
  const MatchTeamDetail({
    required this.gameMatch,
     Key? key }) : super(key: key);

  final GameMatch gameMatch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2.0),
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            formatDate(gameMatch.fixture!.timestamp!),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children:  [
                  CustomCachedNetworkImage(
                    url: gameMatch.teams!.home!.logo.toString(), 
                    placeholder: 'assets/images/ball_one.png', 
                    width: 20.0,
                    ),
                  
                 const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    gameMatch.teams!.home!.name.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children:  [
                    CustomCachedNetworkImage(
                    url: gameMatch.teams!.away!.logo.toString(), 
                    placeholder: 'assets/images/ball_one.png', 
                    width: 20.0,),
                 const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                     gameMatch.teams!.away!.name.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
          const Icon(
            Icons.notification_add,
            color: kgreyColor,
          )
        ],
      ),
    );
  }
}