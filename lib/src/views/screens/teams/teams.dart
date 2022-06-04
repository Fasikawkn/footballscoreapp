import 'package:flutter/material.dart';
import 'package:footballscoreapp/favorite/favorite_provide.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/services/future_service/country_leagues.dart';
import 'package:footballscoreapp/src/services/future_service/team_for_countreies_leagues.dart';
import 'package:footballscoreapp/src/views/screens/teams/components/search_teams.dart';
import 'package:footballscoreapp/src/views/screens/teams/components/team_sub_item.dart';
import 'package:footballscoreapp/src/views/screens/teams/components/teams_expansion.dart';
import 'package:footballscoreapp/src/views/widgets/common/custom_svg_network_image.dart';
import 'package:footballscoreapp/src/views/widgets/common/expansion_wrapper.dart';
import 'package:footballscoreapp/src/views/widgets/team_widget/team_detail.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TeamsPage extends StatefulWidget {
  static const routeName = "footballscoreapp/teamspage";
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final _countriesController = ScrollController();
  final FavoriteProvider _favoriteProvider = FavoriteProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _fetchFavoriteTeams();
    });
    _countriesController.addListener(pagination);
  }

  int _pageCounter = 10;
  List<Country> _allCountries = getCountries(countries);
  List<Country> _displayedCountries = getCountriesInitial(countries);

  void pagination() {
    if ((_countriesController.position.pixels ==
        _countriesController.position.maxScrollExtent)) {
      debugPrint('Now load more===================+>');
      if (_pageCounter < countries.length - 10) {
        setState(() {
          // _isLoading = true;
          _displayedCountries
              .addAll(_allCountries.sublist(_pageCounter, _pageCounter + 10));
          _pageCounter += 10;
          // _isLoading = false;
        });
      }
    }
  }

  List<TeamDetailRouteArgument> _favTeams = [];

  _fetchFavoriteTeams() async {
    final _response = await _favoriteProvider.getAllTeams().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _favTeams = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('displayed Countries $_displayedCountries');
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon:  Icon(
            Icons.search,
            size: 25.0,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            pushNewScreenWithRouteSettings(
              context,
              screen: const SearchTeamsPage(),
              settings: const RouteSettings(
                name: SearchTeamsPage.routeName,
                arguments: 2,
              ),
            );
          },
        ),
        centerTitle: true,
        title:  Text('TEAMS', style: Theme.of(context).textTheme.headline1,),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              size: 25.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        controller: _countriesController,
        shrinkWrap: true,
        children: [
          if (_favTeams.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: ExpansionWrapper(
                isBottomBorderd: false,
                leadingWidget: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.person_add_alt,
                      color: Colors.green,
                    )),
                leadingName: "FAVORITE TEAMS",
                children: _favTeams
                    .map((_favTeams) => GestureDetector(
                        onTap: () {
                          pushNewScreenWithRouteSettings(
                            context,
                            screen: TeamDetailPage(
                              teamDetail: _favTeams,
                            ),
                            settings: RouteSettings(
                              name: TeamDetailPage.routeName,
                              arguments: _favTeams.team,
                            ),
                          );
                        },
                        child: TeamSubItems(_favTeams.team)))
                    .toList(),
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 1.0),
            child: ExpansionWrapper(
                isBottomBorderd: false,
                leadingWidget: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.red,
                    )),
                leadingName: "POPULAR TEAMS",
                children: getPopularTeams()
                    .map((teamLeague) => Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: GestureDetector(
                            onTap: () {
                              pushNewScreenWithRouteSettings(
                                context,
                                screen: TeamDetailPage(
                                  teamDetail: TeamDetailRouteArgument(
                                    league: RouteLeagueModel(
                                      country: teamLeague.league!.country!.name,
                                      flag: teamLeague.league!.country!.flag,
                                      id: teamLeague.league!.league!.id,
                                      logo: teamLeague.league!.league!.logo,
                                      name: teamLeague.league!.league!.name,
                                      round: "League game",
                                      season:
                                          teamLeague.league!.seasons!.last.year,
                                    ),
                                    team: teamLeague.teamModel!,
                                  ),
                                ),
                                settings: RouteSettings(
                                  name: TeamDetailPage.routeName,
                                  arguments: teamLeague.teamModel,
                                ),
                              );
                            },
                            child: TeamSubItems(teamLeague.teamModel!),
                          ),
                        ))
                    .toList()),
          ),
          Column(
            children: _displayedCountries
                .map((country) => FutureBuilder<List<League>>(
                    future: CountryLeague.getCountryLeague(country.name!),
                    builder: (context, snapshots) {
                      List<League> _leagues = [];
                      List<Widget> _children = [Container()];
                      if (snapshots.hasData) {
                        _children = snapshots.data!
                            .map(
                              (league) => FutureBuilder<List<TeamModel>>(
                                  future: TeamForCountryLeagus()
                                      .getTeamsByLeagueId(league.league!.id!,
                                          league.seasons!.last.year!),
                                  builder: (context, snapshotTeam) {
                                    List<Widget> _childrenTeam = [Container()];
                                    if (snapshotTeam.hasData) {
                                      _childrenTeam = snapshotTeam.data!
                                          .map((team) => Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    pushNewScreenWithRouteSettings(
                                                      context,
                                                      screen: TeamDetailPage(
                                                        teamDetail:
                                                            TeamDetailRouteArgument(
                                                          league:
                                                              RouteLeagueModel(
                                                            country: league
                                                                .country!.name,
                                                            flag: league
                                                                .country!.flag,
                                                            id: league
                                                                .league!.id,
                                                            logo: league
                                                                .league!.logo,
                                                            name: league
                                                                .league!.name,
                                                            round:
                                                                "League game",
                                                            season: league
                                                                .seasons!
                                                                .last
                                                                .year,
                                                          ),
                                                          team: team,
                                                        ),
                                                      ),
                                                      settings: RouteSettings(
                                                        name: TeamDetailPage
                                                            .routeName,
                                                        arguments: team,
                                                      ),
                                                    );
                                                  },
                                                  child: TeamSubItems(team),
                                                ),
                                              ))
                                          .toList();
                                    } else {
                                      _childrenTeam = [Container()];
                                    }
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(left: 40.0),
                                      child: TeamsExpansionWraper(
                                        isBottomBorderd: false,
                                        leadingWidget: const Icon(
                                          Icons.wine_bar,
                                          color: kgreyColor,
                                        ),
                                        leadingName:
                                            league.league!.name.toString(),
                                        children: _childrenTeam,
                                      ),
                                    );
                                  }),
                            )
                            .toList();
                      } else if (snapshots.hasError) {
                        _children = [Container()];
                        debugPrint('The team league ${snapshots.error}');
                      }
                      return Container(
                          margin: const EdgeInsets.only(top: 1.0),
                          child: TeamsExpansionWraper(
                            isBottomBorderd: false,
                            leadingWidget: CustomeFlag(
                              imageData: country.flag,
                              size: 120.0,
                            ),
                            leadingName: country.name.toString(),
                            children: _children,
                          ));
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}

class TeamDetailRouteArgument {
  final TeamModel team;
  final RouteLeagueModel league;
  bool? isFromSearch;
  TeamDetailRouteArgument(
      {required this.league, required this.team, this.isFromSearch});
}
