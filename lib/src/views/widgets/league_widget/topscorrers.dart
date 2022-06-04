import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/views/widgets/player/player_home.dart';
import 'package:footballscoreapp/src/views/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TopScorrers extends StatelessWidget {
  const TopScorrers({required this.stats, Key? key}) : super(key: key);
  final List<PlayerStatistics> stats;

  @override
  Widget build(BuildContext context) {
    int _index = 1;
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Column(children: [
            _buildHeader(context),
            Column(
                children: stats.map((stats) {
              Widget _child = _buildPlayerData(_index, stats, context);
              _index++;
              return _child;
            }).toList())
          ]),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('#',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: kgreyColor,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize! +
                                2,
                      )),
              const SizedBox(
                width: 20.0,
              ),
              Text('PLAYER',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: kgreyColor,
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize! +
                                2,
                      ))
            ],
          ),
          Row(
            children: [
              Text(
                'GOALS',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: kgreyColor,
                      fontSize:
                          Theme.of(context).textTheme.bodyText1!.fontSize! + 2,
                    ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                'Pen',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: kgreyColor,
                      fontSize:
                          Theme.of(context).textTheme.bodyText1!.fontSize! + 2,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPlayerData(
      int index, PlayerStatistics statistics, BuildContext context) {
    final _goals = statistics.statistics!.first.goals!.total ?? 'N/A';
    final _appearance = statistics.statistics!.first.penalty!.scored ?? 'N/A';

    return GestureDetector(
      onTap: () {
        pushNewScreenWithRouteSettings(
          context,
          screen: PlayerHomePage(
            player: statistics,
          ),
          settings: RouteSettings(
            name: PlayerHomePage.routeName,
            arguments: statistics,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20.0),
        color: Theme.of(context).colorScheme.secondary,
        child: Container(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
            right: 20.0,
            left: 10.0,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: kgreyColor, width: 0.4),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      index.toString(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: kgreyColor,
                            fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .fontSize! +
                                2,
                          ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ContactNetworkImage(
                      url: statistics.player!.photo.toString(),
                      width: 40.0,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${statistics.player!.firstname} ${statistics.player!.lastname}',
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Text(
                                statistics.statistics!.first.team!.name!,
                                maxLines: 1,
                                style: const TextStyle(
                                    color: kgreyColor, fontSize: 14.0),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    _goals.toString(),
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  AutoSizeText(
                    _appearance.toString(),
                    maxLines: 1,
                    style:Theme.of(context).textTheme.bodyText1!,
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
