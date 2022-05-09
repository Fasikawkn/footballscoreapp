import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';


class MatchesDetailPageTile extends StatelessWidget {
  const MatchesDetailPageTile({ 
    required this.date,
    required this.children,
    Key? key }) : super(key: key);
  final String date;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3.0),
      child: ExpansionTile(
        textColor: kWhiteColor,
        iconColor: kgreyColor,

        initiallyExpanded: true,
        collapsedIconColor: kgreyColor,
        collapsedBackgroundColor: kPrimaryColor,
        backgroundColor: kPrimaryColor,
        childrenPadding: EdgeInsets.zero,
        title:  Text(
              date,
              style: kLeagueNameTextStyle.copyWith(
                color: kgreyColor
              ),
            ),
        children: children,
      ),
    );
  }
}

class DetailMatchItems extends StatelessWidget {
  const DetailMatchItems({
    required this.teamOne,
    required this.teamTwo,
    Key? key,
  }) : super(key: key);
  final String teamOne;
  final String teamTwo;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2.0),
      color: kPrimaryColor2,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '09:30 AM',
            style: kTeamMatchPlayTimeTextStyle,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children:  [
                  Image.asset('assets/images/ball_one.png',
                  width: 20.0,
                  ),
                 const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    teamOne,
                    style: kTeamNameTextStyle,
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
                  Image.asset('assets/images/ball_one.png',
                  width: 20.0,
                  ),
                 const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    teamTwo,
                    style: kTeamNameTextStyle,
                  )
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              // Row(
              //   children: const [
              //     Text('ESPN+, ', style: kTeamMatchSponsorName),
              //     Text('ESPN App',
              //         style: kTeamMatchSponsorName),
              //   ],
              // )
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