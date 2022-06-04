import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants_api/popular_leagues.dart';
import 'package:footballscoreapp/src/constants/custom_functions.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/models/league.dart' as league;
import 'package:footballscoreapp/src/services/future_service/search_future.dart';
import 'package:footballscoreapp/src/views/widgets/search_widgets/all_search.dart';
import 'package:footballscoreapp/src/views/widgets/search_widgets/leagues_search.dart';
import 'package:footballscoreapp/src/views/widgets/search_widgets/players_search.dart';
import 'package:footballscoreapp/src/views/widgets/search_widgets/teams_search.dart';

class SearchMatchesPage extends StatefulWidget {
  static const routeName = 'footballscoreapp/searchmatchesapp';
  const SearchMatchesPage({Key? key}) : super(key: key);

  @override
  State<SearchMatchesPage> createState() => _SearchMatchesPageState();
}

class _SearchMatchesPageState extends State<SearchMatchesPage>
    with TickerProviderStateMixin {
  final _searchFormKey = GlobalKey<FormState>();
  final _searchTextFieldController = TextEditingController();
  late TabController _tabbarViewController;
  int _searchLeagueId = 39;
  int _currentTabIndex = 0;
  @override
  void initState() {
    _tabbarViewController = TabController(length: 4, vsync: this)..addListener(() { 
      setState(() {
        _currentTabIndex = _tabbarViewController.index;
      });

    });
    super.initState();
  }

  @override
  void dispose() {
    _tabbarViewController.dispose();
    super.dispose();
  }

  List _allSearch = [];
  bool _allSearching = false;
  bool _allSearchingError = false;
  bool _allIsSearched = false;

  List<league.League> _leaguesSearch = [];
  bool _leagueSearching = false;
  bool _leagueError = false;
  bool _leagueIsSearched = false;

  List<TeamModel> _teamsSearch = [];
  bool _teamsSearching = false;
  bool _teamError = false;
  bool _teamIsSearched = false;

  List<PlayerStatistics> _playersSearch = [];
  bool _playerSearching = false;
  bool _playerError = false;
  bool _playerIsSearched = false;

  Future _searchInLeagues(String search) async {
    setState(() {
      _leagueSearching = true;
      _leaguesSearch = [];
      _leagueIsSearched = false;
    });
    await SearchFuture().searchLeagues(search).then((value) {
      setState(() {
        _leaguesSearch = value;
        _leagueSearching = false;
        _leagueIsSearched = true;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _leagueSearching = false;
        _leagueError = true;
        _leagueIsSearched = false;
      });
    });
  }

  Future _searchInTeams(String search) async {
    setState(() {
      _teamsSearching = true;
      _teamsSearch = [];
      _teamIsSearched = false;
    });
    await SearchFuture().searchTeams(search).then((value) {
      setState(() {
        _teamsSearch = value;
        _teamsSearching = false;
        _teamIsSearched = true;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _teamsSearching = false;
        _teamError = true;
        _teamIsSearched = false;
      });
    });
  }

  Future _searchInPlayers(String search, int leagueId) async {
    setState(() {
      _playerSearching = true;
      _playersSearch = [];
      _playerIsSearched = false;
    });
    await SearchFuture().searchPlayers(search, leagueId).then((value) {
      setState(() {
        _playersSearch = value;
        _playerSearching = false;
        _playerIsSearched = true;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _playerSearching = false;
        _playerError = true;
        _playerIsSearched = false;
      });
    });
  }

  Future _searchInAll(String search, int leagueId) async {
    setState(() {
      _allSearching = true;
      _allSearch = [];
      _allIsSearched = false;
    });

    try {
      List<league.League> _leagues = await SearchFuture().searchLeagues(search);
      List<TeamModel> _teams = await SearchFuture().searchTeams(search);
      List<PlayerStatistics> _player =
          await SearchFuture().searchPlayers(search, leagueId);
      setState(() {
        _allSearch.addAll(_leagues);
        _allSearch.addAll(_teams);
        _allSearch.addAll(_player);
        _leaguesSearch = _leagues;
        _teamsSearch = _teams;
        _player = _player;
        _allSearch.shuffle();
        _allSearching = false;
        _allIsSearched = true;
      });
    } catch (e) {
      setState(() {
        _allSearchingError = true;
        _allSearching = false;
        _allIsSearched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 4,
      child: Scaffold(
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          toolbarHeight: _tabbarViewController.index == 0 ||
                  _tabbarViewController.index == 3
              ? 120
              : kToolbarHeight,
          automaticallyImplyLeading: false,
          title: Form(
            key: _searchFormKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) async {
                      if (value.length >= 4) {
                        if (_tabbarViewController.index == 0) {
                          await _searchInAll(value, _searchLeagueId);
                        }
                        if (_tabbarViewController.index == 1) {
                          await _searchInLeagues(value);
                        } else if (_tabbarViewController.index == 2) {
                          await _searchInTeams(value);
                        } else if (_tabbarViewController.index == 3) {
                          await _searchInPlayers(value, _searchLeagueId);
                        }
                      }
                    },
                    controller: _searchTextFieldController,
                    // cursorHeight: 25.0,
                    style: const TextStyle(color: kWhiteColor, fontSize: 16.0),

                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      fillColor: Colors.black.withOpacity(0.3),
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      // contentPadding: const EdgeInsets.all(0.0),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: kBlueColor,
                        width: 3.0,
                      )),
                      suffix: GestureDetector(
                        onTap: (() {
                          _searchTextFieldController.clear();
                        }),
                        child: Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.close,
                            size: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                 
                  if (_tabbarViewController.index == 0 ||
                      _tabbarViewController.index == 3)
                    const SizedBox(
                      height: 5.0,
                    ),
                  if (_tabbarViewController.index == 0 ||
                      _tabbarViewController.index == 3)
                    DropdownButtonFormField<int>(
                        dropdownColor: Theme.of(context).colorScheme.secondary,
                        value: _searchLeagueId,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: Theme.of(context).textTheme.bodyText1!.fontSize! + 2
                    ),
                        decoration: InputDecoration(
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kBlueColor,
                              width: 3.0,
                            ),
                          ),
                          fillColor: Colors.black.withOpacity(0.3),
                          filled: true,
                        ),
                        items: getLeagues(poplarLeagues).map((league) => DropdownMenuItem(
                            child: Text(league.league!.name!),
                            value: league.league!.id!,
                          )).toList()
                         ,
                        onChanged: (value) {
                          setState(() {
                            _searchLeagueId = value!;
                          });

                        })
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: kBlueColor),
                ))
          ],
          bottom: TabBar(

            controller: _tabbarViewController,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 5.0,
            isScrollable: true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: _buildTabs(),
          ),
        ),
        body: TabBarView(
          controller: _tabbarViewController,
          children: _buildTabBarViewChildren(),
        ),
      ),
    );
  }

  List<Widget> _buildTabBarViewChildren() {
    return [
      _allSearching
          ? const Center(
              child: CircularProgressIndicator(
                color: kBlueColor,
              ),
            )
          : _allIsSearched && _allSearch.isEmpty?Center(
                  child: Text(
                    'Search not found!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize! +
                                1),
                  ),
                ):
          AllSearchPage(
              allSearchedData: _allSearch,
            ),
      
      _leagueSearching
          ? const Center(
              child: CircularProgressIndicator(
                color: kBlueColor,
              ),
            )
          :_leagueIsSearched && _leaguesSearch.isEmpty?Center(
                  child: Text(
                    'Search not found!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize! +
                                1),
                  ),
                ): LeaguesSearchPage(
        searchedLeagues: _leaguesSearch,
      ),
       _teamsSearching
          ? const Center(
              child: CircularProgressIndicator(
                color: kBlueColor,
              ),
            )
          :_teamIsSearched && _teamsSearch.isEmpty?Center(
                  child: Text(
                    'Search not found!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize! +
                                1),
                  ),
                ):
          TeamsSearchPage(
        searchedTeams: _teamsSearch,
      ),
      _playerSearching
          ? const Center(
              child: CircularProgressIndicator(
                color: kBlueColor,
              ),
            )
          :_playerIsSearched && _playersSearch.isEmpty?Center(
                  child: Text(
                    'Search not found!',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.bodyText1!.fontSize! +
                                1),
                  ),
                ):
          PlayersSearchPage(
        searchedPlayers: _playersSearch,
      )
    ];
  }

  List<Widget> _buildTabs() {
    return ['All', 'Leagues', 'Teams', 'Players']
        .map((tab) => Tab(
              text: tab,
            ))
        .toList();
  }
}
