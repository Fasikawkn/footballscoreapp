import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/models/league.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/models/player_statistics.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/views/screens/leagues/components/search_leagues_page.dart';
import 'package:footballscoreapp/src/views/screens/matches/components/search_matchs_page.dart';
import 'package:footballscoreapp/src/views/screens/more/about_app.dart';
import 'package:footballscoreapp/src/views/screens/more/privacy_policy_page.dart';
import 'package:footballscoreapp/src/views/screens/more/theme_settings.dart';
import 'package:footballscoreapp/src/views/screens/teams/components/search_teams.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/league_widget/league_detail_view.dart';
import 'package:footballscoreapp/src/views/widgets/player/player_home.dart';
import 'package:footballscoreapp/src/views/widgets/team_widget/team_detail.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => const HomePage());
    } else if (settings.name == MatchDetail.routeName) {
      final _gameMatch = settings.arguments as MatchDetailRouteArgument;
      return MaterialPageRoute(
          builder: (context) => MatchDetail(
                matchDetailRouteArgument: _gameMatch,
              ));
    } else if (settings.name == DetailViewPage.routeName) {
       RouteLeagueModel _league = settings.arguments as RouteLeagueModel;
      return MaterialPageRoute(
          builder: (context) => DetailViewPage(
                league: _league,
              ));
    } else if (settings.name == LeagueDetailView.routeName) {
      RouteLeagueModel _league = settings.arguments as RouteLeagueModel;
      return MaterialPageRoute(
          builder: (context) => LeagueDetailView(
                league: _league,
              ));
    } else if (settings.name == TeamDetailPage.routeName) {
      TeamDetailRouteArgument _teamModel = settings.arguments as TeamDetailRouteArgument;
      return MaterialPageRoute(
        builder: ((context) =>  TeamDetailPage(
          teamDetail: _teamModel,

          
        )),
      );
    }else if(settings.name == SearchMatchesPage.routeName){
      return MaterialPageRoute(builder: ((context) => const SearchMatchesPage()));
    }
    else if(settings.name == SearchLeaguesPage.routeName){
      return MaterialPageRoute(builder: ((context) => const SearchLeaguesPage()));
    }
    else if(settings.name == SearchTeamsPage.routeName){
      return MaterialPageRoute(builder: ((context) => const SearchTeamsPage()));
    }
    else if(settings.name == ThemeSettings.routeName){
      return MaterialPageRoute(builder: ((context) => const ThemeSettings()));
    }
    else if(settings.name == PlayerHomePage.routeName){
      final _playerStats = settings.arguments as PlayerStatistics;
      return MaterialPageRoute(builder: ((context) =>  PlayerHomePage(
        player: _playerStats,

      )));
    }else if(settings.name == AboutApp.routeName){
      return MaterialPageRoute(builder: ((context) => const AboutApp()));
    }else if(settings.name == PrivacyPolicy.routeName){
      return MaterialPageRoute(builder: ((context) => const PrivacyPolicy()));
    }
    return MaterialPageRoute(builder: (context) => const HomePage());
  }
}
