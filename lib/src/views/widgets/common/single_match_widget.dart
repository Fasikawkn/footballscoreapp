import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/views/widgets/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SingleMatchWidget extends StatelessWidget {
  const SingleMatchWidget({
    Key? key,
    required this.match,
  }) : super(key: key);
  final GameMatch match;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      margin: const EdgeInsets.only(bottom: 1.5),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MatchTimeFTHalfWidget(match: match),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomCachedNetworkImage(
                    width: 20.0,
                    url: match.teams!.home!.logo!,
                    placeholder: 'assets/images/team_placeholder_image.png',
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    match.teams!.home!.name!,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCachedNetworkImage(
                    width: 20.0,
                    url: match.teams!.away!.logo!,
                    placeholder: 'assets/images/team_placeholder_image.png',
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    match.teams!.away!.name!,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              // Row(
              //   children: const [
              //     Text('ESPN+, ',
              //         style: kTeamMatchSponsorName),
              //     Text('ESPN App',
              //         style: kTeamMatchSponsorName),
              //   ],
              // )
            ],
          ),
          match.fixture!.status!.long == 'Not Started' || match.fixture!.status!.long == 'Time to be defined'
              ? const Icon(
                  Icons.notification_add,
                  color: kgreyColor,
                )
              : Column(
                  children:  [
                    Text(
                      match.goals!.home.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                    Text(
                      match.goals!.away.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                )
        ],
      ),
    );
  }
}

class MatchTimeFTHalfWidget extends StatelessWidget {
  const MatchTimeFTHalfWidget({
    Key? key,
    required this.match,
  }) : super(key: key);

  final GameMatch match;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatDate(match.fixture!.timestamp!),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        if (match.fixture!.status!.short == 'FT')
          const Text(
            'FT',
            style: TextStyle(
              color: kgreyColor,
              height: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (match.fixture!.status!.short == '2H' ||
            match.fixture!.status!.short == '1H')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 6.0,
              ),
              LinearPercentIndicator(
                lineHeight: 6.0,
                isRTL: false,
                padding: EdgeInsets.zero,
                width: 60.0,
                progressColor: Colors.red,
                percent: match.fixture!.status!.elapsed! / 90,
                backgroundColor: Colors.red.withOpacity(0.5),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                "${match.fixture!.status!.elapsed!}'",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
      ],
    );
  }
}

class TimeState extends StatelessWidget {
  const TimeState({
    Key? key,
    required this.match,
    required this.fontSize,
    required this.top,
  }) : super(key: key);

  final GameMatch match;
  final double fontSize;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (match.fixture!.status!.long == 'Not Started' || match.fixture!.status!.long == 'Time to be defined')
         Text(
                formatDate(match.fixture!.timestamp!),
                style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 14.0
                ),
              ),
        if (match.fixture!.status!.short == 'FT'||match.fixture!.status!.short == '2H' ||
            match.fixture!.status!.short == '1H')
          Column(
            children: [
              Text(
                '${match.goals!.home}-${match.goals!.away}',
                style: Theme.of(context).textTheme.headline1,
              ),
          if(top> 120)  if(match.fixture!.status!.short == 'FT')  Text(
                'FULL TIME',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 10.0
                ),
              )
            ],
          ),
        if (match.fixture!.status!.short == '2H' ||
            match.fixture!.status!.short == '1H')
        if(top > 120)  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 6.0,
              ),
              LinearPercentIndicator(
                lineHeight: 6.0,
                isRTL: false,
                padding: EdgeInsets.zero,
                width: 60.0,
                progressColor: Colors.red,
                percent: match.fixture!.status!.elapsed! / 90,
                backgroundColor: Colors.red.withOpacity(0.5),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                "${match.fixture!.status!.elapsed!}'",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red),
              )
            ],
          )
      ],
    );
  }
}
