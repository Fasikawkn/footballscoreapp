import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/views/widgets/player/player_profile.dart';
import 'package:footballscoreapp/src/views/widgets/player/player_stats.dart';
import 'package:footballscoreapp/src/views/widgets/widgets.dart';


class PlayerHomePage extends StatefulWidget {
  static const routeName = 'footballscroreapp/playerhomepage';
  const PlayerHomePage({
    required this.player,
     Key? key }) : super(key: key);
  final PlayerStatistics player;

  @override
  State<PlayerHomePage> createState() => _PlayerHomePageState();
}

class _PlayerHomePageState extends State<PlayerHomePage> {
  final ScrollController _scrollController = ScrollController();

  final ScrollController _matchesController = ScrollController();
  var top = 0.0;
 final  List<Widget> _tabs = [const Tab(text: 'Profile', ),const Tab(text: 'Stats',)];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                                          url: widget.player.player!.photo.toString(),
                                          placeholder:
                                              'assets/images/ball_one.png',
                                          width: 30.0,
                                        ),
                                      if (top > 160)
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                      Text(
                                        widget.player.player!.name.toString(),
                                        style:  Theme.of(context).textTheme.bodyText1,
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
            body: TabBarView(
              children: [
                PlayerProfile(player: widget.player),
                PlayerStats(
                  player: widget.player,
                )
              ],
            ),
        ),
        
        
      ),
    );
  }
   
}