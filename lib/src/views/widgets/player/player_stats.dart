import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/constants/textstyles.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:group_button/group_button.dart';

class PlayerStats extends StatefulWidget {
  const PlayerStats({required this.player, Key? key}) : super(key: key);
  final PlayerStatistics player;

  @override
  State<PlayerStats> createState() => _PlayerStatsState();
}

class _PlayerStatsState extends State<PlayerStats> {
  int _index = 0;
  Statistics? _statistice;
  @override
  void initState() {
    _setInitialStatistics();
    super.initState();
  }

  _setInitialStatistics() {
    _statistice = widget.player.statistics!.first;
  }

  @override
  Widget build(BuildContext context) {
    for (var item in widget.player.statistics!) {
      debugPrint(item.toJson().toString());
    }
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GroupButton(
                      options: groupButtonOptions(),
                      buttons: [widget.player.statistics!.first.league!.name],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        CustomCachedNetworkImage(
                          url: _statistice!.league!.logo.toString(),
                          placeholder: 'assets/images/ball_two.ong',
                          width: 20.0,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          _statistice!.league!.name ?? 'N?A',
                          style: Theme.of(context).textTheme.headline1
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildPos('MINUTES PLAYED',
                              '${_statistice!.games!.minutes ?? 0}'),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: _buildPos(
                              "GOALS", '${_statistice!.goals!.total ?? 0}'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPos('APPEARANCE',
                              '${_statistice!.games!.appearences ?? 0}'),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: _buildPos("YELLOW + RED",
                              '${_statistice!.cards!.yellowred ?? 0}'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPos('YELLOW CARDS',
                              '${_statistice!.cards!.yellow ?? 0}'),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: _buildPos(
                              "RED CARD", '${_statistice!.cards!.red ?? 0}'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPos('SUBSTITUTION ON',
                              '${_statistice!.substitutes!.inS ?? 0}'),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: _buildPos("SUBSTITUTION OFF",
                              '${_statistice!.substitutes!.out ?? 0}'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPos(
                              'LINEUPS', '${_statistice!.games!.lineups ?? 0}'),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: _buildPos("SUBSTITUTION ON",
                              '${_statistice!.substitutes!.bench ?? 0}'),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPos(String top, String bottom) {
    return _buildWrapper(
      top,
      Text(
        bottom,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _buildWrapper(
    String top,
    Widget child,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            top,
            style: const TextStyle(
              color: kgreyColor,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          child
        ],
      ),
    );
  }
}
