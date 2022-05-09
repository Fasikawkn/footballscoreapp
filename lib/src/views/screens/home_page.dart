import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/views/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'screens.dart';

class HomePage extends StatefulWidget {
  
  static const routeName = 'footballscoreapp/homepage';
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  int _selectedIndex = 0;

   List<Widget> _buildScreens() {
    return const [
      MatchesPage(),
      LeaguesPage(),
      TeamsPage(),
      MorePage()

      
   
    ];
  }

   List<PersistentBottomNavBarItem> _bottomBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.sports_soccer),
        title: ("Matches"),
        activeColorPrimary: kBlueColor,
        inactiveColorPrimary: kgreyColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.wine_bar),
        title: ("Leagues"),
        activeColorPrimary: kBlueColor,
        inactiveColorPrimary: kgreyColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.group),
        title: ("Teams"),
        activeColorPrimary: kBlueColor,
        inactiveColorPrimary: kgreyColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu),
        title: ("More"),

        activeColorPrimary: kBlueColor,
        inactiveColorPrimary: kgreyColor,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView.custom(
        context,
      controller: _controller,
      screens: _buildScreens(),
      itemCount: 4,
      confineInSafeArea: true,
      backgroundColor: kPrimaryColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      customWidget: CustomBottomBarWidget(
        items: _bottomBarsItems(),
        selectedIndex: _controller.index,
        onItemSelected: (index){
          setState(() {
            _controller.index = index;
            _selectedIndex = index;
          });
        },
        
      )
    );
  }
}