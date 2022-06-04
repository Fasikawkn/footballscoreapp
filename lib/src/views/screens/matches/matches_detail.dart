import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/custom_functions.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/fixture_event.dart';
import 'package:footballscoreapp/src/models/fixture_lineups.dart';
import 'package:footballscoreapp/src/models/fixture_statistics.dart';
import 'package:footballscoreapp/src/models/league.dart';
import 'package:footballscoreapp/src/models/match.dart' as _gameMatch;
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/services/future_service/mathes.dart';
import 'package:footballscoreapp/src/services/future_service/team_stats.dart';
import 'package:footballscoreapp/src/views/screens/matches/components/middle_sliver_appbar.dart';
import 'package:footballscoreapp/src/views/screens/matches/components/top_sliver_app_bar.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:group_button/group_button.dart';

class MatchDetailRouteArgument {
  final _gameMatch.GameMatch? gameMatch;
  final RouteLeagueModel league;
  const MatchDetailRouteArgument({
    this.gameMatch,
    required this.league,
  });
}

class MatchDetail extends StatefulWidget {
  static const routeName = 'footballscoreapp/matchDetail';
  const MatchDetail({required this.matchDetailRouteArgument, Key? key})
      : super(key: key);
  final MatchDetailRouteArgument matchDetailRouteArgument;

  @override
  State<MatchDetail> createState() => _MatchDetailState();
}

class _MatchDetailState extends State<MatchDetail> {
  ScrollController _scrollController = ScrollController();

  var top = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _fetchStandingTable().whenComplete(() {
        _fetchFixtureStats().whenComplete(() {
          _fetchFixtureLineups().whenComplete(() {
            _fetchFixtureEvent();
          });
        });
      });
    });
  }

  bool _formButtonSelected = false;
  final _buttonController = GroupButtonController();

  int _tabLength = 0;
  List<Tab> _tabs = [];

  bool _renderStanding = false;
  bool _renderStats = false;
  bool _renderEvent = false;
  bool _renderLineups = false;
  List<Widget> _tabBarViewItems = [];
  List<int> _names = [];
  List<FixtureStatistics> _fixtureStats = [];
  List<TeamLineupModel> _teamLineUpStats = [];
  List<FixtureEvent> _fixtureEvents = [];

  Future _fetchFixtureEvent() async {
    await MatchesFuture.getFixtureEvents(
            widget.matchDetailRouteArgument.gameMatch!.fixture!.id!)
        .then((value) {
      if (value.isNotEmpty) {
        debugPrint('The evets are $value');
        setState(() {
          _fixtureEvents = value;
          _addTabItem('Events');
          _renderEvent = true;
        });
      } else {
        setState(() {
          _renderEvent = true;
        });
      }
    }).onError((error, stackTrace) {
      debugPrint('The eror $error');
      setState(() {
        _renderEvent = true;
      });
    });
  }

  Future _fetchFixtureLineups() async {
    await MatchesFuture.getTeamLineUps(
            widget.matchDetailRouteArgument.gameMatch!.fixture!.id!)
        .then((value) {
      if (value.isNotEmpty) {
        debugPrint('+++++++++++++++++++ Not Empty');
        setState(() {
          _teamLineUpStats = value;
          _addTabItem('Lineups');
          _renderLineups = true;
        });
      } else {
        debugPrint('+++++++++++++++++++  Empty');

        setState(() {
          _renderLineups = true;
        });
      }
    }).onError((error, stackTrace) {
      debugPrint('+++++++++++++++++++ Errror');
      debugPrint('$error');
      debugPrint(stackTrace.toString());

      setState(() {
        _renderLineups = true;
      });
    });
  }

  Future _fetchStandingTable() async {
    await TeamStatData.getStandingInfo(
      widget.matchDetailRouteArgument.league.id!,
      widget.matchDetailRouteArgument.league.season!,
    ).then((value) {
      if (value.name != null) {
        setState(() {
          _addTabItem(
            'Standing',
          );
          _renderStanding = true;
        });
      } else {
        _renderStanding = true;
      }
    }).onError((error, stackTrace) {
      setState(() {
        _renderStanding = true;
      });
    });
  }

  Future _fetchFixtureStats() async {
    await MatchesFuture.getFixtureStatisticsById(
            widget.matchDetailRouteArgument.gameMatch!.fixture!.id!)
        .then((value) {
      debugPrint('The fixture status $value');
      if (value.isNotEmpty) {
        setState(() {
          _fixtureStats = value;
          _addTabItem('Stats');
          _renderStats = true;
        });
      } else {
        _renderStats = true;
      }
    }).onError((error, stackTrace) {
      debugPrint('Error is $error');
      debugPrint(stackTrace.toString());
      debugPrint(stackTrace.toString());
      setState(() {
        _renderEvent = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    debugPrint('The events are $_fixtureEvents');

    return DefaultTabController(
      length: _tabLength,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return [
                  TopSliverAppBar(
                    leagueModel: widget.matchDetailRouteArgument.league,
                  ),
                  MiddleSliverAppBar(
                    gameMatch: widget.matchDetailRouteArgument.gameMatch!,
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    snap: true,
                    pinned: true,
                    floating: true,
                    expandedHeight: 200,
                    toolbarHeight: 80.0,
                    collapsedHeight: 80,
                    flexibleSpace: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      width: double.infinity,
                      child: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              getDate(DateTime.fromMillisecondsSinceEpoch(widget
                                      .matchDetailRouteArgument
                                      .gameMatch!
                                      .fixture!
                                      .timestamp! *
                                  1000)),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              widget.matchDetailRouteArgument.gameMatch!
                                      .fixture!.venue!.name ??
                                  'N/A',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.0),
                            ),
                            const SizedBox(
                              height: 25.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      indicatorColor: Colors.blue,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 5.0,
                      isScrollable: true,
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      tabs: _tabs,
                    ),
                  )
                ];
              }),
              body: _renderBodywidget()
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: kBlueColor,
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: TabBarView(
                        children: _tabBarViewItems,
                      ),
                    )),
        ),
      ),
    );
  }

  Widget _buildLinesups() => SingleChildScrollView(
        child: TeamLineups(
          teamslineupStats: _teamLineUpStats,
        ),
      );

  Widget _buildStats() => SingleChildScrollView(
        child: TeamsStatistics(
          fixtureStatistcs: _fixtureStats,
        ),
      );

  Widget _buildEvents() => SingleChildScrollView(
        child: TeamEvents(
          events: _fixtureEvents,
          gameMatch: widget.matchDetailRouteArgument.gameMatch!,
        ),
      );

  Widget _buildStanding() {
    return SingleChildScrollView(
      child: StandingTable(
        teams: [
          widget.matchDetailRouteArgument.gameMatch!.teams!.home!.id!,
          widget.matchDetailRouteArgument.gameMatch!.teams!.away!.id!
        ],
        gamematch: widget.matchDetailRouteArgument,
      ),
    );
  }

  bool _renderBodywidget() {
    if (!_renderStanding &&
        !_renderEvent &&
        !_renderLineups &&
        !_renderStats &&
        _names.isEmpty) {
      return true;
    } else {
      return false;
    }
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

  List<Widget> _addItems(List<Tab> tabs) {
    Map<String, Widget> _mapper = {
      'Standing': _buildStanding(),
      'Events': _buildEvents(),
      'Stats': _buildStats(),
      'Lineups': _buildLinesups(),
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
