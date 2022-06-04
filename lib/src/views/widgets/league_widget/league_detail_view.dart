import 'package:flutter/material.dart';
import 'package:footballscoreapp/favorite/favorite_provide.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
// import 'package:footballscoreapp/src/models/league.dart' as leagueModel;
import 'package:footballscoreapp/src/models/match.dart' as matches;
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/services/future_service/mathes.dart';
import 'package:footballscoreapp/src/services/future_service/team_stats.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/league_widget/league_matches_tile.dart';
import 'package:footballscoreapp/src/views/widgets/league_widget/topscorrers.dart';

class LeagueDetailView extends StatefulWidget {
  static const routeName = 'footballscoreapp/leaguedetailview';
  const LeagueDetailView({required this.league, Key? key}) : super(key: key);
  // final leagueModel.League league;
  final RouteLeagueModel league;

  @override
  State<LeagueDetailView> createState() => _LeagueDetailViewState();
}

class _LeagueDetailViewState extends State<LeagueDetailView> {
  final ScrollController _scrollController = ScrollController();

  final ScrollController _matchesController = ScrollController();
  int _tabLength = 0;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _fetchDataForMatches().whenComplete(() {
        _fetchStandingDataForLeague().whenComplete(() {
          _fetchTopScorers().whenComplete(() {
            _updateCounter();
          });
        });
      });
    });

    super.initState();
  }

  List<matches.LeagueGameMatch> _gameMatches = [];

  var top = 0.0;

  List<int> _names = [];

  List<PlayerStatistics> _playerStatics = [];
  bool _topScorerRender = false;
  bool _matchesRender = false;
  bool _standingRender = false;
  Future _updateCounter() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _names = [1, 2, 3];
        _addTabItem('');
      });
    });
  }

  Future _fetchTopScorers() async {
    await TeamStatData.getTopScorrers(
      widget.league.id!,
      widget.league.season!,
    ).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _playerStatics = value;
          _topScorerRender = true;
          _addTabItem('Top Scorrers');
        });
      } else {
        setState(() {
          _topScorerRender = true;
        });
      }
    }).onError((error, stackTrace) {
      setState(() {
        _topScorerRender = true;
      });
      debugPrint('Top scorrer is $error');
    });
  }

  List<Tab> _tabs = [];
  List<Widget> _viewItems = [];

  Future _fetchDataForMatches() async {
    await MatchesFuture.getLeagueGamesMatches(
      widget.league.id!,
      widget.league.season!,
    ).then((value) {
      if (value.isNotEmpty) {
        debugPrint('The ++++++++++++++++++++++++++Matches are$value');
        setState(() {
          _addTabItem(
            'Matches',
          );
          _gameMatches = value;
          _matchesRender = true;
        });
      } else {
        setState(() {
          _matchesRender = true;
        });
      }
    }).onError((error, stackTrace) {
      debugPrint('The matches error is $error');
      debugPrint("The matches stack trace is $stackTrace");
      setState(() {
        _matchesRender = true;
      });
    });
  }

  Future _fetchStandingDataForLeague() async {
    await TeamStatData.getStandingInfo(
      widget.league.id!,
      widget.league.season!,
    ).then((value) {
      if (value.name != null) {
        setState(() {
          _addTabItem(
            'Standing',
          );
          _standingRender = true;
        });
      } else {
        setState(() {
          _standingRender = true;
        });
      }
    }).onError((error, stackTrace) {
      setState(() {
        _standingRender = true;
      });
    });
  }

  final FavoriteProvider _favoriteProvider = FavoriteProvider();

  @override
  Widget build(BuildContext context) {
    // _scrollMatchesList();
    return DefaultTabController(
      length: _tabLength,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartTop,
          floatingActionButton: FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor:Theme.of(context).colorScheme.primary,
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
                  actions: [
                    IconButton(
                      onPressed: () async {
                        final _isAdded = await _favoriteProvider
                            .isLeagueFavorite(widget.league.id!);
                        if (_isAdded) {
                          await _favoriteProvider
                              .deleteLeague(widget.league.id!);
                          setState(() {});
                          debugPrint('Deleted+++++++++');
                        } else {
                          await _favoriteProvider.insertLeague(widget.league);
                          setState(() {});
                          debugPrint('Added+++++++++');
                        }
                      },
                      icon: FutureBuilder<bool>(
                          future: _favoriteProvider
                              .isLeagueFavorite(widget.league.id!),
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
                              return  Icon(
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
                                          url: widget.league.logo!,
                                          placeholder:
                                              'assets/images/ball_one.png',
                                          width: 30.0,
                                        ),
                                      if (top > 160)
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                      Text(
                                        widget.league.name!,
                                        style:  Theme.of(context).textTheme.bodyText1,
                                      ),
                                      if (top > 160)
                                        Text(
                                          widget.league.country!,
                                          style:  Theme.of(context).textTheme.bodyText2,
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
            body: _renderBodywidget()
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kBlueColor,
                    ),
                  )
                : TabBarView(
                    children: _viewItems,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopScorrer() {
    return TopScorrers(
      stats: _playerStatics,
    );
  }

  ListView _buildMatches() {
    return ListView(
        shrinkWrap: true,
        children: _gameMatches.isNotEmpty
            ? _gameMatches
                .map((gameMatch) => LeagueMatchesTile(
                      gameMatch: gameMatch,
                      league: gameMatch.games.first.league!,
                    ))
                .toList()
            : []);
  }

  Center _buildStanding() {
    return Center(
      child: ListView(
        controller: _matchesController,
        shrinkWrap: true,
        children: [
          StandingTable(
            teams: const [],
            gamematch: MatchDetailRouteArgument(
              league: widget.league,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _addItems(List<Tab> tabs) {
    Map<String, Widget> _mapper = {
      'Matches': _buildMatches(),
      'Standing': _buildStanding(),
      'Top Scorrers': _buildTopScorrer(),
      '': Container()
    };
    List<Widget> _viewItems = [];
    for (int item = 0; item < tabs.length; item++) {
      String _text = tabs[item].text!;
      _viewItems.add(_mapper[_text]!);
    }
    return _viewItems;
  }

  bool _isTabFound(String tabName) {
    bool _isFound = false;
    for (var element in _tabs) {
      if (element.text == tabName) {
        _isFound = true;
      }
    }

    return _isFound;
  }

  bool _renderBodywidget() {
    if (!_topScorerRender &&
        !_matchesRender &&
        !_standingRender &&
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

    _viewItems = _addItems(_tabs);
  }
}
