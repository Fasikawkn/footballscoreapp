import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/views/widgets/common/expansion_wrapper.dart';
import 'package:footballscoreapp/src/views/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TeamsPage extends StatefulWidget {
  static const routeName = "footballscoreapp/teamspage";
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.search,
            size: 25.0,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text('TEAMS'),
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
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4.0),
            child: ExpansionWrapper(
              isBottomBorderd: false,
              leadingWidget: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.person_add_alt,
                    color: Colors.green,
                  )),
              leadingName: "FAVORITE TEAMS",
              subExpansionItems: [
                SubExpansionTileItem(
                    onPressed: (){
                      pushNewScreenWithRouteSettings(context, screen: const DetailViewPage(tabLength: 3), settings: const RouteSettings(
                        name: DetailViewPage.routeName,
                        arguments: 2
                      ));
                    },
                    icon: Icons.sports_soccer, name: 'Major League Soccer'),
                SubExpansionTileItem(
                   onPressed: (){
                      pushNewScreenWithRouteSettings(context, screen: const DetailViewPage(tabLength: 3), settings: const RouteSettings(
                        name: DetailViewPage.routeName,
                        arguments: 2
                      ));
                    },
                    icon: Icons.sports_soccer, name: 'Major League Soccer'),
                SubExpansionTileItem(
                   onPressed: (){
                     pushNewScreenWithRouteSettings(context, screen: const DetailViewPage(tabLength: 3), settings: const RouteSettings(
                        name: DetailViewPage.routeName,
                        arguments: 2
                      ));
                    },
                    icon: Icons.sports_soccer, name: 'Major League Soccer')
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4.0),
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
              subExpansionItems: [
                SubExpansionTileItem(
                   onPressed: (){
                     pushNewScreenWithRouteSettings(context, screen: const DetailViewPage(tabLength: 3), settings: const RouteSettings(
                        name: DetailViewPage.routeName,
                        arguments: 2
                      ));
                    },
                    icon: Icons.sports_soccer, name: 'Major League Soccer'),
                SubExpansionTileItem(
                   onPressed: (){
                     pushNewScreenWithRouteSettings(context, screen: const DetailViewPage(tabLength: 3), settings: const RouteSettings(
                        name: DetailViewPage.routeName,
                        arguments: 2
                      ));
                    },
                    icon: Icons.sports_soccer, name: 'Major League Soccer'),
                SubExpansionTileItem(
                   onPressed: (){
                     pushNewScreenWithRouteSettings(context, screen: const DetailViewPage(tabLength: 3), settings: const RouteSettings(
                        name: DetailViewPage.routeName,
                        arguments: 2
                      ));
                    },
                    icon: Icons.sports_soccer, name: 'Major League Soccer'),
                SubExpansionTileItem(
                   onPressed: (){
                     pushNewScreenWithRouteSettings(context, screen: const DetailViewPage(tabLength: 3), settings: const RouteSettings(
                        name: DetailViewPage.routeName,
                        arguments: 2
                      ));
                    },
                    icon: Icons.sports_soccer, name: 'Major League Soccer'),
                SubExpansionTileItem(
                   onPressed: (){
                     pushNewScreenWithRouteSettings(context, screen: const DetailViewPage(tabLength: 3), settings: const RouteSettings(
                        name: DetailViewPage.routeName,
                        arguments: 2
                      ));
                    },
                    icon: Icons.sports_soccer, name: 'Major League Soccer'),
                SubExpansionTileItem(
                   onPressed: (){
                     pushNewScreenWithRouteSettings(context, screen: const DetailViewPage(tabLength: 3), settings: const RouteSettings(
                        name: DetailViewPage.routeName,
                        arguments: 2
                      ));
                    },
                    icon: Icons.sports_soccer, name: 'Major League Soccer'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
