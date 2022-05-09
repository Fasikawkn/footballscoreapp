

import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/views/views.dart';

class AppRoute{
  static Route generateRoute(RouteSettings settings) {
    if(settings.name == '/'){
      return MaterialPageRoute(builder: (context) => const HomePage());
    }
    else if(settings.name == MatchDetail.routeName){
      return MaterialPageRoute(
        builder: (context) => const MatchDetail()
        );
    }
    else if(settings.name == DetailViewPage.routeName){
      int _tabLength = settings.arguments as int;
       return MaterialPageRoute(
        builder: (context) =>  DetailViewPage(
          tabLength: _tabLength,
        )
        );
    }
    return MaterialPageRoute(builder: (context) => const HomePage());
  }
  
}