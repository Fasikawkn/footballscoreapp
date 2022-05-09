import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/views/screens/leagues/components/club_domestic_tiles.dart';
import 'package:footballscoreapp/src/views/screens/leagues/components/items.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/common/expansion_wrapper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({Key? key}) : super(key: key);

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
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
          title: const Text('LEAGUES'),
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
        body: Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: ListView(
            children: [
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
              ClubDomesticTile(
                collapsedBackgroundColor: kPrimaryColor,
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
                subExpansionItems: [
                 Padding(
                   padding: const EdgeInsets.only(
                     left: 40.0,
                   ),
                   child: ClubDomesticTile(
                collapsedBackgroundColor: kPrimaryColor2,
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
                leadingName: "Superliga",
                subExpansionItems: [
                 1,2
                
                ].map((e) =>  SubExpansionItems()).toList()
                   ),
                 ),],
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
            ],
          ),
        ));
  }
}
