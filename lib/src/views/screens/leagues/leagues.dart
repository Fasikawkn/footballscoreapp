import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballscoreapp/favorite/favorite_provide.dart';
import 'package:footballscoreapp/src/blocs/country_bloc/country_bloc.dart';
import 'package:footballscoreapp/src/constants/constants.dart';

import 'package:footballscoreapp/src/models/league.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/services/future_service/country_leagues.dart';

import 'package:footballscoreapp/src/views/screens/leagues/components/club_domestic_tiles.dart';
import 'package:footballscoreapp/src/views/screens/leagues/components/items.dart';
import 'package:footballscoreapp/src/views/screens/leagues/components/search_leagues_page.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/common/custom_svg_network_image.dart';
import 'package:footballscoreapp/src/views/widgets/common/expansion_wrapper.dart';
import 'package:footballscoreapp/src/views/widgets/custom_shimmer/legues_shimmer.dart';
import 'package:footballscoreapp/src/views/widgets/league_widget/league_detail_view.dart';
import 'package:loadmore/loadmore.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({Key? key}) : super(key: key);

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _fetchFavLeagues();
    });
    _countriesController.addListener(pagination);
    super.initState();
  }

  final _countriesController = ScrollController();

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

  final FavoriteProvider _favoriteProvider = FavoriteProvider();

  List<RouteLeagueModel> _favLeagues = [];
  _fetchFavLeagues() async {
    await _favoriteProvider.getAllLeagues().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          _favLeagues = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.search,
            size: 23.0,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            pushNewScreenWithRouteSettings(
              context,
              screen: const SearchLeaguesPage(),
              settings: const RouteSettings(
                name: SearchLeaguesPage.routeName,
                arguments: 2,
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'LEAGUES',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              size: 23.0,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: ListView(
          controller: _countriesController,
          children: [
            if (_favLeagues.isNotEmpty)
              ExpansionWrapper(
                  isBottomBorderd: true,
                  leadingWidget: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.person_add_alt,
                      color: Colors.green,
                    ),
                  ),
                  leadingName: "FAFORITE LEAGUES",
                  children: _favLeagues
                      .map(
                        (league) => GestureDetector(
                          onTap: () {
                            pushNewScreenWithRouteSettings(
                              context,
                              screen: LeagueDetailView(
                                league: league,
                              ),
                              settings: const RouteSettings(
                                name: LeagueDetailView.routeName,
                                arguments: 2,
                              ),
                            );
                          },
                          child: SubExpansionItem(
                            league: League(
                                country: Country(
                                    code: league.country,
                                    flag: league.flag,
                                    name: league.country),
                                league: LeagueClass(
                                  id: league.id,
                                  logo: league.logo,
                                  name: league.name,
                                ),
                                seasons: [Season(year: league.season)]),
                          ),
                        ),
                      )
                      .toList()),
            ExpansionWrapper(
                isBottomBorderd: true,
                leadingWidget: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.red,
                    )),
                leadingName: "POPULAR LEAGUES",
                children: getLeagues(poplarLeagues)
                    .map((league) => GestureDetector(
                        onTap: () {
                          pushNewScreenWithRouteSettings(
                            context,
                            screen: LeagueDetailView(
                              league: RouteLeagueModel(
                                  country: league.country!.name,
                                  flag: league.country!.flag,
                                  id: league.league!.id,
                                  logo: league.league!.logo,
                                  name: league.league!.name,
                                  round: 'League Game',
                                  season: league.seasons!.last.year!),
                            ),
                            settings: const RouteSettings(
                              name: LeagueDetailView.routeName,
                              arguments: 2,
                            ),
                          );
                        },
                        child: SubExpansionItem(league: league)))
                    .toList()),
            ExpansionWrapper(
                isBottomBorderd: true,
                leadingWidget: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.public,
                    color: Colors.blue,
                  ),
                ),
                leadingName: "CLUB - WORLD",
                children: getLeagues(clubWorldLeagues)
                    .map((league) => GestureDetector(
                        onTap: () {
                          pushNewScreenWithRouteSettings(
                            context,
                            screen: LeagueDetailView(
                              league: RouteLeagueModel(
                                country: league.country!.name,
                                flag: league.country!.flag,
                                id: league.league!.id,
                                logo: league.league!.logo,
                                name: league.league!.name,
                                round: "League game",
                                season: league.seasons!.last.year,
                              ),
                            ),
                            settings: const RouteSettings(
                              name: LeagueDetailView.routeName,
                              arguments: 2,
                            ),
                          );
                        },
                        child: SubExpansionItem(league: league)))
                    .toList()),
            ClubDomesticTile(
              collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
              isBottomBorderd: true,
              leadingWidget: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.other_houses_outlined,
                    color: Colors.purple,
                  )),
              leadingName: "CLUB - DOMESTIC",
              subExpansionItems: _displayedCountries
                  .map(
                    (country) => Padding(
                      padding: const EdgeInsets.only(),
                      child: FutureBuilder<List<League>>(
                          future: CountryLeague.getCountryLeague(country.name!),
                          builder: (context, snapshots) {
                            List<League> _leagues = [];
                            List<Widget> _children = [const LeaguesShimmer()];
                            if (snapshots.hasData) {
                              _leagues = snapshots.data!;
                              _children = _leagues
                                  .map(
                                    (league) => Padding(
                                      padding: const EdgeInsets.only(
                                        left: 40.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          pushNewScreenWithRouteSettings(
                                            context,
                                            screen: LeagueDetailView(
                                              league: RouteLeagueModel(
                                                country: league.country!.name,
                                                flag: league.country!.flag,
                                                id: league.league!.id,
                                                logo: league.league!.logo,
                                                name: league.league!.name,
                                                round: "League game",
                                                season:
                                                    league.seasons!.last.year,
                                              ),
                                            ),
                                            settings: const RouteSettings(
                                              name: LeagueDetailView.routeName,
                                              arguments: 2,
                                            ),
                                          );
                                        },
                                        child: SubExpansionItems(
                                          league: league,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList();
                            } else if (snapshots.hasError) {
                              _children = [Container()];
                            }

                            return ClubDomesticTile(
                              leadingWidget: CustomeFlag(
                                imageData:
                                    country.flag ?? 'https://www.svgimg.svg',
                                size: 120.0,
                              ),
                              leadingName: country.name.toString(),
                              subExpansionItems: _children,
                              isBottomBorderd: true,
                              collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
                            );
                          }),
                    ),
                  )
                  .toList(),
            ),
            ExpansionWrapper(
                isBottomBorderd: true,
                leadingWidget: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.flag_outlined,
                      color: Colors.green,
                    )),
                leadingName: "NATIONAL TEAMS",
                children: getLeagues(nationalTeamsLeagues)
                    .map((league) => GestureDetector(
                        onTap: () {
                          pushNewScreenWithRouteSettings(
                            context,
                            screen: LeagueDetailView(
                              league: RouteLeagueModel(
                                country: league.country!.name,
                                flag: league.country!.flag,
                                id: league.league!.id,
                                logo: league.league!.logo,
                                name: league.league!.name,
                                round: "League game",
                                season: league.seasons!.last.year,
                              ),
                            ),
                            settings: const RouteSettings(
                              name: LeagueDetailView.routeName,
                              arguments: 2,
                            ),
                          );
                        },
                        child: SubExpansionItem(league: league)))
                    .toList()),
          ],
        ),
      ),
    );
  }
}
