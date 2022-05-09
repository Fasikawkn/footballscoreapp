import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/views/screens/matches/components/middle_sliver_appbar.dart';
import 'package:footballscoreapp/src/views/screens/matches/components/top_sliver_app_bar.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:group_button/group_button.dart';

class MatchDetail extends StatefulWidget {
  static const routeName = 'footballscoreapp/matchDetail';
  const MatchDetail({Key? key}) : super(key: key);

  @override
  State<MatchDetail> createState() => _MatchDetailState();
}

class _MatchDetailState extends State<MatchDetail> {
  ScrollController _scrollController = ScrollController();

  var top = 0.0;

  @override
  void initState() {
    super.initState();
  }

  bool _formButtonSelected = false;
  final _buttonController = GroupButtonController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
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
                  TopSliverAppBar(),
                  MiddleSliverAppBar(),
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
                            const Text(
                              'Apr 26',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.0),
                            ),
                            const Text(
                              'Etihad Stadium(Manchester)',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.0),
                            ),
                            const Text(
                              'WHO WILL WIN?',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                  height: 2.0),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(
                                    child: OddButton(
                                        color: Colors.blue, text: '1')),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                    child: OddButton(
                                  text: 'x',
                                  color: Color.fromARGB(255, 33, 37, 169),
                                )),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                    child: OddButton(
                                  color: Colors.blue,
                                  text: '2',
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    bottom: const TabBar(
                        indicatorColor: Colors.blue,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 5.0,
                        isScrollable: true,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                         
                          Tab(
                            text: 'Table',
                          ),
                          Tab(
                            text: 'Events',
                          ),
                          Tab(
                            text: 'Stats',
                          ),
                          Tab(
                            text: 'Linesups',
                          ),

                        ]),
                  )
                ];
              }),
              body: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: const TabBarView(
                  children:  [
                   
                     SingleChildScrollView(child: StandingTable()),
                     SingleChildScrollView(
                      child: TeamEvents(),
                    ),
                     SingleChildScrollView(
                      child: TeamsStatistics(),
                    ),
                     SingleChildScrollView(
                      child: TeamLineups(),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
