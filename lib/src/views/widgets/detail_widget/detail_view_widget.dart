import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/views/widgets/widgets.dart';

class DetailViewPage extends StatefulWidget {
  static const routeName = 'footballscoreapp/detailviewpage';
  const DetailViewPage({required this.tabLength, Key? key}) : super(key: key);
  final int tabLength;

  @override
  State<DetailViewPage> createState() => _DetailViewPageState();
}

class _DetailViewPageState extends State<DetailViewPage> {
  ScrollController _scrollController = ScrollController();
  int _tabLength = 1;
  @override
  void initState() {
    setState(() {
      _tabLength = widget.tabLength;
    });
    super.initState();
  }

  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLength,
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
                SliverAppBar(
                  automaticallyImplyLeading: false,

                  pinned: true,
                  floating: false,

                  expandedHeight: 300,
                  elevation: 0.0,

                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    top = constraints.biggest.height;
                    print('THe height is $top');
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
                                      if (top > 160)
                                        Image.asset(
                                          'assets/images/ball_one.png',
                                          width: 30.0,
                                        ),
                                      if (top > 160)
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                      const Text(
                                        'Major League Soccer',
                                        style: TextStyle(
                                            color: kWhiteColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.0),
                                      ),
                                      if (top > 160)
                                        const Text(
                                          'United States',
                                          style: TextStyle(
                                              color: kgreyColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.0),
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
                    tabs: _buildBottomNavBar(),
                  ), //FlexibleSpaceBar
                ),
              ];
            }),
            body: Container(
              
              child: TabBarView(
                children:  [
                 const MatchesDetailPageTile(
                    date: '2/16/2022',
                    children: [
                      DetailMatchItems(
                        teamOne: 'Wolfs burg',
                        teamTwo: 'Mainz 05',
                      ),
                      DetailMatchItems(
                        teamOne: 'Wolfs burg',
                        teamTwo: 'Mainz 05',
                      )
                    ],
                  ),
                 SingleChildScrollView(child: Container(
                   margin: const EdgeInsets.only(top: 4.0),
                   child: const StandingTable())),
                  Container(
                    
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBottomNavBar() {
    return const[
      Tab(
        text: 'Matches',
        
      ),
       Tab(
        text: 'Standing',
        
      ),
       Tab(
        text: 'Top Scorers',
        
      ),

    ];
  }
}
