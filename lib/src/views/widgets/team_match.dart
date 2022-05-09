import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';


class TeamMatch extends StatelessWidget {
  const TeamMatch({
    Key? key,
  }) : super(key: key);

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
        title: Row(
          children:  [
              Image.asset('assets/images/ball_two.png',
                        width: 20.0,
                        ),
            const SizedBox(
              width: 20.0,
            ),
            const Text(
              'GERMANY - BUNDESLIGA',
              style: kLeagueNameTextStyle,
            ),
          ],
        ),
        children: [
          Container(
            color: kPrimaryColor2,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0,),
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
                       const Text(
                          'Wolfsburg',
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
                       const Text(
                          'Mainz 05',
                          style: kTeamNameTextStyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: const [
                        Text('ESPN+, ', style: kTeamMatchSponsorName),
                        Text('ESPN App',
                            style: kTeamMatchSponsorName),
                      ],
                    )
                  ],
                ),
                const Icon(
                  Icons.notification_add,
                  color: kgreyColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}