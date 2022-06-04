import 'package:flutter/material.dart';
import 'package:footballscoreapp/favorite/favorite_provide.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/models/team_table_data.dart';
import 'package:footballscoreapp/src/services/future_service/country_leagues.dart';
import 'package:footballscoreapp/src/services/future_service/mathes.dart';
import 'package:footballscoreapp/src/services/future_service/team_stats.dart';
import 'package:footballscoreapp/src/models/league.dart' as _leag;

import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/team_widget/squad.dart';
import 'package:footballscoreapp/src/views/widgets/team_widget/stats.dart';
import 'package:footballscoreapp/src/views/widgets/team_widget/team_matches_tile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TeamDetailPage extends StatefulWidget {
  static const routeName = 'footballscoreapp/teamdetailpage';
  TeamDetailPage({required this.teamDetail, Key? key}) : super(key: key);
  final TeamDetailRouteArgument teamDetail;

  @override
  State<TeamDetailPage> createState() => _TeamDetailPageState();
}

class _TeamDetailPageState extends State<TeamDetailPage> {
  ScrollController _scrollController = ScrollController();

  _leag.League? _league;

  var top = 0.0;
  int _tabLength = 0;
  List<Tab> _tabs = [];

  Future _fetchTeamLeague() async {
    await CountryLeague()
        .getLeagueByTeamId(widget.teamDetail.team.team!.id!)
        .then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _league = value.first;
        });
      }
    });
  }

  @override
  void initState() {
    setState(() {});
    // _getMatchForTheLeague();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.teamDetail.isFromSearch != null) {
        _fetchTeamLeague().whenComplete(() {
          _fetchDataForMatches().whenComplete(() {
            _fetchStandingDataForLeague().whenComplete((() {
              _fetchDataForTeamStat().whenComplete(() {
                _fetchPlayerStatistics().whenComplete(() {
                  _updateCounter();
                });
              });
            }));
          });
        });
      } else {
        _fetchDataForMatches().whenComplete(() {
          _fetchStandingDataForLeague().whenComplete((() {
            _fetchDataForTeamStat().whenComplete(() {
              _fetchPlayerStatistics().whenComplete(() {
                _updateCounter();
              });
            });
          }));
        });
      }
    });

    super.initState();
  }

  bool _renderMatches = false;
  bool _renderStanding = false;
  bool _renderStats = false;
  bool _renderSquad = false;

  List<GameMatch> _gameMatches = [];
  LeagueTable _teamState = LeagueTable();
  List<Widget> _tabBarViewItems = [];
  List<int> _names = [];
  List<PlayerStatistics> _playerStatistics = [];

  Future _fetchPlayerStatistics() async {
    await TeamStatData.getTeamPlayerStatistics(
      widget.teamDetail.isFromSearch == null
          ? widget.teamDetail.league.id!
          : _league!.league!.id!,
      widget.teamDetail.isFromSearch == null
          ? widget.teamDetail.league.season!
          : _league!.seasons!.last.year!,
      widget.teamDetail.team.team!.id!,
    ).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _addTabItem(
            'Squad',
          );
          _playerStatistics = value;
          _renderSquad = true;
        });
      } else {
        setState(() {
          _renderSquad = true;
        });
      }
    }).onError((error, stackTrace) {
      setState(() {
        _renderSquad = true;
      });
    });
  }

  Future _fetchDataForMatches() async {
    await MatchesFuture.getMatchesByLeagueIdTeamId(
      widget.teamDetail.isFromSearch == null
          ? widget.teamDetail.league.id!
          : _league!.league!.id!,
      widget.teamDetail.isFromSearch == null
          ? widget.teamDetail.league.season!
          : _league!.seasons!.last.year!,
      widget.teamDetail.team.team!.id!,
    ).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _addTabItem(
            'Matches',
          );
          _gameMatches = value;
          _renderMatches = true;
        });
      } else {
        setState(() {
          _renderMatches = true;
        });
      }
    }).onError((error, stackTrace) {
      setState(() {
        _renderMatches = true;
      });
    });
  }

  Future _fetchDataForTeamStat() async {
    await TeamStatData.getTeamState(
      widget.teamDetail.isFromSearch == null
          ? widget.teamDetail.league.id!
          : _league!.league!.id!,
      widget.teamDetail.isFromSearch == null
          ? widget.teamDetail.league.season!
          : _league!.seasons!.last.year!,
      widget.teamDetail.team.team!.id!,
    ).then((value) {
      if (value.tableData!.isNotEmpty) {
        setState(() {
          _addTabItem(
            'Stats',
          );
          _teamState = value;
          _renderStats = true;
        });
      } else {
        setState(() {
          _renderStats = true;
        });
      }
    }).onError((error, stackTrace) {
      setState(() {
        _renderStats = true;
      });
    });
  }

  Future _fetchStandingDataForLeague() async {
    await TeamStatData.getStandingInfo(
      widget.teamDetail.isFromSearch == null
          ? widget.teamDetail.league.id!
          : _league!.league!.id!,
      widget.teamDetail.isFromSearch == null
          ? widget.teamDetail.league.season!
          : _league!.seasons!.last.year!,
    ).then((value) {
      if (value.name != null) {
        setState(() {
          _addTabItem(
            'Standing',
          );
          _renderStanding = true;
        });
      } else {
        setState(() {
          _renderStanding = true;
        });
      }
    }).onError((error, stackTrace) {
      setState(() {
        _renderStanding = true;
      });
    });
  }

  Future _updateCounter() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _names = [1, 2, 3];
        _addTabItem(
          '',
        );
      });
    });
  }

  final FavoriteProvider _favoriteProvider = FavoriteProvider();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:Theme.of(context).scaffoldBackgroundColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartTop,
          floatingActionButton: FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 0.0,
            mini: true,
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            child:  Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: false,
                  backgroundColor: Theme.of(context).colorScheme.primary ,
                  actions: [

                     IconButton(
                      onPressed: () async {
                        final _isAdded = await  _favoriteProvider
                              .isTeamFavorite(widget.teamDetail.team.team!.id!);
                       if(_isAdded){
                          await _favoriteProvider
                            .deleteTeam(widget.teamDetail.team.team!.id!);
                        setState(() {});
                        debugPrint('Deleted+++++++++');

                       }else{
                          await _favoriteProvider
                            .insertTeams(widget.teamDetail);
                        setState(() {});
                        debugPrint('Added+++++++++');
                       }
                      },
                      icon: FutureBuilder<bool>(
                          future: _favoriteProvider
                              .isTeamFavorite(widget.teamDetail.team.team!.id!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!) {
                                return const Icon(
                                  Icons.star,
                                  color: kBlueColor,
                                );
                              } else {
                                return  Icon(
                                  Icons.star_border_outlined,
                                  color: Theme.of(context).iconTheme.color,
                                );
                              }
                            } else {
                              return Icon(
                                Icons.star_border_outlined,
                                color: Theme.of(context).iconTheme.color,
                              );
                            }
                          }),
                    )
                    
                  ],

                  expandedHeight: 300,
                  elevation: 0.0,

                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    top = constraints.biggest.height;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 25.0),
                      width: top == 80.0 ? 100 : double.infinity,
                      decoration:  BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (top > 160)
                                        CustomCachedNetworkImage(
                                          url: widget
                                              .teamDetail.team.team!.logo!,
                                          placeholder:
                                              'assets/images/ball_one.png',
                                          width: 30.0,
                                        ),
                                      if (top > 160)
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                      Text(
                                        widget.teamDetail.team.team!.name!,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                      if (top > 160)
                                        Text(
                                          widget.teamDetail.team.team!.country!,
                                          style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  bottom: TabBar(
                    
                    indicatorColor: Colors.blue,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 5.0,
                    isScrollable: true,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    tabs: _tabs,
                  ), //FlexibleSpaceBar
                ),
              ];
            }),
            body: !_renderBody()
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kBlueColor,
                    ),
                  )
                : TabBarView(children: _tabBarViewItems),
          ),
        ),
      ),
    );
  }

  Widget _buildStats() {
    return TeamStats(
      teamStats: _teamState,
    );
  }

  bool _renderBody() {
    if (_renderMatches &&
        _renderStanding &&
        _renderStats &&
        _renderSquad &&
        _names.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildStanding() {
    return ListView(
      children: [
        StandingTable(
          teams: [widget.teamDetail.team.team!.id!],
          gamematch: MatchDetailRouteArgument(
            league: widget.teamDetail.isFromSearch == null
                ? RouteLeagueModel.fromJson(
                    widget.teamDetail.league.toJson(),
                  )
                : RouteLeagueModel(
                    id: _league!.league!.id,
                    country: _league!.country!.name,
                    flag: _league!.country!.flag,
                    logo: _league!.league!.logo,
                    name: _league!.league!.name,
                    round: 'League game',
                    season: _league!.seasons!.last.year),
          ),
        ),
      ],
    );
  }

  ListView _buildMatches() {
    return ListView(
        shrinkWrap: true,
        children: _gameMatches
            .map((gameMatch) => TeamDetailMatchTile(
                date: formatDateBySlash(gameMatch.fixture!.date.toString()),
                child: GestureDetector(
                  onTap: () {
                    pushNewScreenWithRouteSettings(
                      context,
                      screen: MatchDetail(
                        matchDetailRouteArgument: MatchDetailRouteArgument(
                            gameMatch: gameMatch,
                            league: widget.teamDetail.league),
                      ),
                      settings: const RouteSettings(
                        name: MatchDetail.routeName,
                      ),
                    );
                  },
                  child: MatchTeamDetail(
                    gameMatch: gameMatch,
                  ),
                )))
            .toList());
  }

  _addTabItem(String name) {
    if (_tabs.isNotEmpty) {
      Tab _tab = _tabs.first;
      List<Tab> _previousTabs = _tabs.map((e) => e).toList();
      Tab _tab2 = Tab(
        text: name,
      );
      if (name.startsWith('M')) {
        _tabs = _previousTabs.map((e) => e).toList();
        _tabs.insert(0, _tab2);
      } else {
        _tabs = _previousTabs.map((e) => e).toList();
        _tabs.add(_tab2);
      }
      _tabLength = _tabLength + 1;
    } else {
      _tabs = [
        Tab(
          text: name,
        ),
      ];

      _tabLength = _tabLength + 1;
    }

    _tabBarViewItems = _addItems(_tabs);
  }

  Widget _buildTeamSquad() {
    return TeamSquadWidget(
      team: widget.teamDetail.team,
      league: widget.teamDetail.isFromSearch == null
          ? widget.teamDetail.league
          : RouteLeagueModel(
              id: _league!.league!.id,
              country: _league!.country!.name,
              flag: _league!.country!.flag,
              logo: _league!.league!.logo,
              name: _league!.league!.name,
              round: 'League game',
              season: _league!.seasons!.last.year),
    );
  }

  List<Widget> _addItems(List<Tab> tabs) {
    Map<String, Widget> _mapper = {
      'Matches': _buildMatches(),
      'Standing': _buildStanding(),
      'Stats': _buildStats(),
      'Squad': _buildTeamSquad(),
      '': Container()
    };
    List<Widget> _viewItems = [];
    for (int item = 0; item < tabs.length; item++) {
      String _text = tabs[item].text!;
      _viewItems.add(_mapper[_text]!);
    }
    return _viewItems;
  }
}

// widget.teamDetail.isFromSearch == null
//           ? widget.teamDetail.league.id!
//           : _league!.league!.id!,