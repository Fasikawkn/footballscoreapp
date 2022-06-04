import 'dart:math';

import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/fixture_statistics.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TeamsStatistics extends StatelessWidget {
  const TeamsStatistics({required this.fixtureStatistcs, Key? key})
      : super(key: key);
  final List<FixtureStatistics> fixtureStatistcs;

  @override
  Widget build(BuildContext context) {
    int _homePossession =
        _getValue('Ball Possession', fixtureStatistcs.first.statistics!);
    int _awayPossession =
        _getValue('Ball Possession', fixtureStatistcs.last.statistics!);

    int _homeShotsTotal =
        _getValue('Total Shots', fixtureStatistcs.first.statistics!);
    int _awayShotsTotal =
        _getValue('Total Shots', fixtureStatistcs.last.statistics!);

    int _homeShotsOnGoal =
        _getValue('Shots on Goal', fixtureStatistcs.first.statistics!);
    int _awayShotsOnGoal =
        _getValue('Shots on Goal', fixtureStatistcs.last.statistics!);

    int _homeFouls = _getValue('Fouls', fixtureStatistcs.first.statistics!);
    int _awayFouls = _getValue('Fouls', fixtureStatistcs.last.statistics!);

    int _homeOffsides =
        _getValue('Offsides', fixtureStatistcs.first.statistics!);
    int _awayOffsides =
        _getValue('Offsides', fixtureStatistcs.last.statistics!);

    int _homeCorners =
        _getValue('Corner Kicks', fixtureStatistcs.first.statistics!);
    int _awayCorners =
        _getValue('Corner Kicks', fixtureStatistcs.last.statistics!);

    int _homeYellowCards =
        _getValue('Yellow Cards', fixtureStatistcs.first.statistics!);
    int _awayYellowCards =
        _getValue('Yellow Cards', fixtureStatistcs.last.statistics!);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
           Text(
            'Team Possession',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$_homePossession%',
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0),
              ),
              CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 15.0,
                percent: _awayPossession / (_homePossession + _awayPossession),
                backgroundColor: Colors.blue.withOpacity(0.5),
                progressColor: Colors.blue,
              ),
              Text(
                '$_awayPossession%',
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0),
              ),
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          _buildEvents(_homeShotsTotal, 'Shots Total', _awayShotsTotal),
          _buildEvents(_homeShotsOnGoal, 'Shots on Goal', _awayShotsOnGoal),
          _buildEvents(_homeFouls, 'Fouls', _awayFouls),
          _buildEvents(_homeOffsides, 'Offsides', _awayOffsides),
          _buildEvents(_homeCorners, 'Corners', _awayCorners),
          _buildEvents(_homeYellowCards, 'Yellow Cards', _awayYellowCards),
        ],
      ),
    );
  }

  int _getValue(String type, List<Statistics> stats) {
    int _value = 0;
    for (var element in stats) {
      if (element.type == type) {
        _value = element.value ?? 0;
      }
    }
    return _value;
  }

  Widget _buildEvents(int leftCount, String name, int rightCount) {
    int value = leftCount + rightCount;
    double leftValue = leftCount / value;
    double rightValue = rightCount / value;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              leftCount.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: LinearPercentIndicator(
              lineHeight: 25.0,
              isRTL: true,
              barRadius: const Radius.circular(5.0),
              width: 100.0,
              progressColor: Colors.blue,
              percent: leftValue,
              backgroundColor: Colors.blue.withOpacity(0.5),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: LinearPercentIndicator(
              lineHeight: 25.0,
              isRTL: false,
              barRadius: const Radius.circular(5.0),
              width: 100.0,
              progressColor: Colors.blue,
              percent: rightValue,
              backgroundColor: Colors.blue.withOpacity(0.5),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              rightCount.toString(),
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
