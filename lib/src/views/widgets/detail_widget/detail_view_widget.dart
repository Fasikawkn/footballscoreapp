import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballscoreapp/src/blocs/blocs.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/services/services.dart';
import 'package:footballscoreapp/src/views/widgets/custom_shimmer/legues_shimmer.dart';
import 'package:footballscoreapp/src/views/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class DetailViewPage extends StatefulWidget {
  static const routeName = 'footballscoreapp/detailviewpage';
  const DetailViewPage({required this.league, Key? key}) : super(key: key);
  final RouteLeagueModel league;

  @override
  State<DetailViewPage> createState() => _DetailViewPageState();
}

class _DetailViewPageState extends State<DetailViewPage> {
  ScrollController _scrollController = ScrollController();
  int _tabLength = 2;
  @override
  void initState() {
    setState(() {
      // _tabLength = ;
    });
    super.initState();
  }

  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    final GameMatchesRepository _gameMatchesRepository = GameMatchesRepository(
        matchesDataProvider: MatchesDataProvider(httpClient: http.Client()));
    return DefaultTabController(
      length: _tabLength,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:Theme.of(context).scaffoldBackgroundColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartTop,
          floatingActionButton: FloatingActionButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: kPrimaryColor2,
            elevation: 0.0,
            mini: true,
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
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

                  expandedHeight: 300,
                  elevation: 0.0,

                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    top = constraints.biggest.height;
                    return Container(
                      margin: EdgeInsets.only(bottom: 25.0),
                      width: top == 80.0 ? 100 : double.infinity,
                      decoration: const BoxDecoration(
                        color: kPrimaryColor2,
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
                                      // if (top > 160)
                                      //   CustomCachedNetworkImage(
                                      //     url: widget.league.league!.logo!,
                                      //     placeholder:
                                      //         'assets/images/ball_one.png',
                                      //     width: 30.0,
                                      //   ),
                                      // if (top > 160)
                                      //   const SizedBox(
                                      //     height: 10.0,
                                      //   ),
                                      // Text(
                                      //   widget.league.league!.name!,
                                      //   style: const TextStyle(
                                      //       color: kWhiteColor,
                                      //       fontWeight: FontWeight.w400,
                                      //       fontSize: 15.0),
                                      // ),
                                      // if (top > 160)
                                      //   Text(
                                      //     widget.league.country!.name!,
                                      //     style: const TextStyle(
                                      //         color: kgreyColor,
                                      //         fontWeight: FontWeight.w400,
                                      //         fontSize: 13.0),
                                      //   ),
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
                    tabs: _buildBottomNavBar(),
                  ), //FlexibleSpaceBar
                ),
              ];
            }),
            body: TabBarView(
              children: [
                BlocProvider(
                  lazy: false,
                  create: ((context) => GamematchBloc(
                            gameMatchesRepository: _gameMatchesRepository,
                          )..add(
                              GetGamematchsByLeagueIdEvent(
                                date: '2022-05-17',
                                season: widget.league.season!,
                                    
                                leagueId: '',
                              ),
                            ) // widget.league.league!.id.toString()));
                      ),
                  child: BlocBuilder<GamematchBloc, GamematchState>(
                    builder: (context, state) {
                      if (state is GamematchLoadingState ||
                          state is GamematchInitialState) {
                        return const LeaguesShimmer();
                      }
                      if (state is GamematchLoadedState) {
                        
                        if(state.gameMathes.isNotEmpty){
                          return  MatchesDetailPageTile(
                          date: formatDateBySlash(state.gameMathes.first.fixture!.date.toString()),
                          children: state.gameMathes.map((match) =>  DetailMatchItems(
                              teamOne: match.teams!.home!.name.toString(),
                              teamTwo: match.teams!.away!.name.toString(),
                            )).toList(),
                        );

                        }else{
                          return const  Text('No matches');
                        }
                        
                      } else {
                        GamematchErrorState _errorState = state as GamematchErrorState;
                        return Container();
                      }
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 4.0),
                  
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBottomNavBar() {
    return const [
      Tab(
        text: 'Matches',
      ),
      Tab(
        text: 'Standing',
      ),
     
    ];
  }
}
