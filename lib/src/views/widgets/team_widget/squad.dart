import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballscoreapp/src/blocs/team_player_boc/teamplayer_bloc.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/coache.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/models/team_player_model.dart';
import 'package:footballscoreapp/src/services/future_service/team_stats.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/common/custom_svg_network_image.dart';
import 'package:footballscoreapp/src/views/widgets/player/player_home.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TeamSquadWidget extends StatefulWidget {
  const TeamSquadWidget({required this.league, required this.team, Key? key})
      : super(key: key);
  final TeamModel team;
  final RouteLeagueModel league;

  @override
  State<TeamSquadWidget> createState() => _TeamSquadWidgetState();
}

class _TeamSquadWidgetState extends State<TeamSquadWidget> {
  @override
  void initState() {
    super.initState();
    _fetchCoaches();
    _fetcTeamSquad();
    _fetchPlayerStatisitcs();
  }

  _fetcTeamSquad() {
    BlocProvider.of<TeamplayerBloc>(context)
        .add(GetTeamPlayers(widget.team.team!.id!));
  }

  List<CoachModel> _coaches = [];
  Map<String?, List<PlayerStatistics>> _playerStatistics = {};
  bool _renderCoach = false;
  bool _renderPlayer = false;
  Future _fetchPlayerStatisitcs() async {
    await TeamStatData.getTeamPlayerStatisticsByPosition(
      widget.league.id!,
      widget.league.season!,
      widget.team.team!.id!,
    ).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _playerStatistics = value;
          _renderPlayer = true;
        });
      }
    }).onError((error, stackTrace) {
      setState(() {
        _renderPlayer = false;
      });
    });
  }

  Future _fetchCoaches() async {
    await TeamStatData.getTeamCoach(widget.team.team!.id!).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _coaches = [value.first];
          _renderCoach = true;
        });
      }
    }).onError((error, stackTrace) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamplayerBloc, TeamplayerState>(
      builder: (context, state) {
        if (state is TeamplayerInitial || state is TeamplayerLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: kBlueColor,
            ),
          );
        } else if (state is TeamSquadLoaded) {
          if (_renderWidget()) {
            return const Center(
              child: CircularProgressIndicator(
                color: kBlueColor,
              ),
            );
          } else {
            List<TeamSquad> _teamSquad = state.teamSquad;
            return ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      child: Column(
                        children: _coaches
                            .map(
                              (coach) => _buildCoaches(coach),
                            )
                            .toList(),
                      ),
                    ),
                    Column(
                      children: _playerStatistics.entries
                          .map(
                            (entry) => PlayerDetail(
                              showGoal: _playerStatistics.entries.first.key == entry.key,
                              statistics: entry.value,
                              position: entry.key!.toString(),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              ],
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  bool _renderWidget() {
    if (_renderCoach && _renderPlayer) {
      return false;
    } else {
      return true;
    }
  }

  Widget _buildCoaches(CoachModel coach) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          color: Theme.of(context).colorScheme.secondary,
          child: Text(
            'COACH',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          color: Theme.of(context).colorScheme.secondary,
          child: Row(
            children: [
              ContactNetworkImage(
                url: coach.photo.toString(),
                width: 40,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                coach.name.toString(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize:
                        Theme.of(context).textTheme.bodyText1!.fontSize! + 3),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PlayerDetail extends StatelessWidget {
  const PlayerDetail({
    Key? key,
    required this.statistics,
    required this.position,
    required this.showGoal,
  }) : super(key: key);
  final String position;
  final List<PlayerStatistics> statistics;
  final bool showGoal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            color: Theme.of(context).colorScheme.secondary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  position,
                  style: Theme.of(context).textTheme.headline1,
                ),
                if (showGoal)
                  Row(
                    children: [
                      Text(
                        'GOALS',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .fontSize! +
                                3),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        'A',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .fontSize! +
                                3),
                      )
                    ],
                  )
              ],
            ),
          ),
          Column(
              children: statistics
                  .map((stats) => GestureDetector(
                      onTap: () {
                        pushNewScreenWithRouteSettings(
                          context,
                          screen: PlayerHomePage(
                            player: stats,
                          ),
                          settings: RouteSettings(
                            name: PlayerHomePage.routeName,
                            arguments: statistics,
                          ),
                        );
                      },
                      child: _buildPlayerData(stats, context)))
                  .toList())
        ],
      ),
    );
  }

  Widget _buildPlayerData(PlayerStatistics statistics, BuildContext context) {
    final _goals = statistics.statistics!.first.goals!.total ?? 'N/A';
    final _appearance =
        statistics.statistics!.first.games!.appearences ?? 'N/A';

    return Container(
      padding: const EdgeInsets.only(left: 20.0),
      color: Theme.of(context).colorScheme.secondary,
      child: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          right: 20.0,
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
                        AutoSizeText(
                          '${statistics.player!.firstname} ${statistics.player!.lastname}',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .fontSize! +
                                      3),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const CustomeFlag(
                              size: 80.0,
                              imageData: 'http://images.svg',
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            AutoSizeText(
                              statistics.player!.nationality!,
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
                Text(_goals.toString(),
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(
                  width: 30.0,
                ),
                AutoSizeText(
                  _appearance.toString(),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
