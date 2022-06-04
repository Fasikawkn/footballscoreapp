import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/fixture_event.dart';
import 'package:footballscoreapp/src/models/match.dart';

class TeamEvents extends StatelessWidget {
  const TeamEvents({required this.gameMatch, required this.events, Key? key})
      : super(key: key);
  final List<FixtureEvent> events;
  final GameMatch gameMatch;

  @override
  Widget build(BuildContext context) {
    debugPrint('game Match team home name ${gameMatch.teams!.home!.name}');
    debugPrint('game Match team away name ${gameMatch.teams!.away!.name}');
    debugPrint('Event team home name $events');
    // debugPrint('Event team away name ${gameMatch.teams!.home!.name}');

    int _index = 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: events.reversed.map((event) {
        Widget _widget = Container();
        if (event.team!.id == gameMatch.teams!.home!.id) {
          _widget = _buildStatsRowLeft(
              (_index % 2) == 0 ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary ,
              context,
              event);
        } else {
          _widget = _buildStatsRowRight(
              (_index % 2) == 0 ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary ,
              context,
              event);
        }
        _index++;
        return _widget;
      }).toList(),
    );
  }

  Container _buildStatsRowLeft(
      Color backgroundColor, BuildContext context, FixtureEvent event) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      color: backgroundColor,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (event.type == "subst") _buildForSubstTypeLeft(context, event),
            if (event.type == 'Goal') _buildForGoalTypeLeft(context, event),
            if (event.type == 'Card') _buildForCardTypeLeft(context, event),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              '${event.time!.elapsed}\'',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width * 0.5) - 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForCardType(BuildContext context, FixtureEvent event) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.5) - 50,
      child: Row(
        children: [
          Image.asset(
            event.detail.toString() == 'Yellow Card'
                ? 'assets/images/yellow_card_icon.png'
                : 'assets/images/red_card.png',
            width: 20.0,
            height: 20.0,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              event.player!.name.toString(),
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForSubstType(BuildContext context, FixtureEvent event) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.5) - 50,
      child: Row(
        children: [
          const Icon(
            Icons.cached,
            color: Colors.green,
            size: 30.0,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.assist!.name.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Colors.green),
                ),
                Text(
                  event.player!.name.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForGoalType(BuildContext context, FixtureEvent event) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.5) - 50,
      child: Row(
        children: [
          Image.asset(
            'assets/images/ball_two.png',
            width: 20,
            height: 20.0,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            event.player!.name.toString(),
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }

  Widget _buildForCardTypeLeft(BuildContext context, FixtureEvent event) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.5) - 50,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text(
              event.player!.name.toString(),
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Image.asset(
            event.detail.toString() == 'Yellow Card'
                ? 'assets/images/yellow_card_icon.png'
                : 'assets/images/red_card.png',
            width: 20.0,
            height: 20.0,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  Widget _buildForSubstTypeLeft(BuildContext context, FixtureEvent event) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.5) - 50,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.assist!.name.toString(),
                  maxLines: 1,
                  
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Colors.green),
                ),
                AutoSizeText(
                  event.player!.name.toString(),
                  maxLines: 1,
                  maxFontSize: 16,
                  minFontSize: 10,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          const Icon(
            Icons.cached,
            color: Colors.green,
            size: 30.0,
          ),
        ],
      ),
    );
  }

  Widget _buildForGoalTypeLeft(BuildContext context, FixtureEvent event) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * 0.5) - 50,
      child: Row(
        children: [
          Text(
            event.player!.name.toString(),
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Image.asset(
            'assets/images/ball_two.png',
            width: 20,
            height: 20.0,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRowRight(
      Color backgroundColor, BuildContext context, FixtureEvent event) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      color: backgroundColor,
      child: Center(
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width * 0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${event.time!.elapsed}\'',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                if (event.type == "subst") _buildForSubstType(context, event),
                if (event.type == 'Goal') _buildForGoalType(context, event),
                if (event.type == 'Card') _buildForCardType(context, event)
              ],
            )
          ],
        ),
      ),
    );
  }
}
