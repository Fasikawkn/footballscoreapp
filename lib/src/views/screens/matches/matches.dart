import 'package:flutter/material.dart';

import 'package:footballscoreapp/src/constants/custom_functions.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/league.dart' as leag;
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/services/future_service/mathes.dart';
import 'package:footballscoreapp/src/views/screens/matches/components/search_matchs_page.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/custom_horizontal_date_picker/date_picker_timeline.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:top_modal_sheet/top_modal_sheet.dart';

class MatchesPage extends StatefulWidget {
  static const routeName = 'footballscoreapp/matchespage';
  const MatchesPage({Key? key}) : super(key: key);

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final _scrollController = ScrollController();
  int _currentIndex = 0;
  DateTime _selectedDate = DateTime.now();
  List<String> listOfMonths = [
    "JANUARY",
    "FEBRUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGEST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER"
  ];
  @override
  void initState() {
    _fetchLeagues(_selectedDate);
    _scrollController.addListener(pagination);

    super.initState();
  }

  bool _isLoading = false;
  List<GameMatchesHome> _matchLeagues = [];
  List<leag.League> _totalLeagues = [];
  int _pageCounter = 10;

  void pagination() {
    if ((_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent)) {
      debugPrint('Now load more===================+>');
      if (_pageCounter < _totalLeagues.length - 10) {
        setState(() {
          _isLoading = true;

          _pageCounter += 100;
          _isLoading = false;
        });
      }
    }
  }

  bool _isLeagueLoading = true;
  bool _isLeagueError = false;
  bool _isleagueLeaded = false;

  Future _fetchLeagues(DateTime dateTime) async {
    setState(() {
      _isLeagueLoading = true;
      _isLeagueError = false;
    });
    await MatchesFuture.getHomeGameMatches(_selectedDate).then((value) {
      setState(() {
        _matchLeagues = value;
        _isLeagueLoading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _isLeagueError = true;
        _isLeagueLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(_matchLeagues.toString());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          listOfMonths[_selectedDate.month - 1],
          style: Theme.of(context).textTheme.headline1
        ),
        centerTitle: true,
        leadingWidth: 112,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                pushNewScreenWithRouteSettings(
                  context,
                  screen: const SearchMatchesPage(),
                  settings: const RouteSettings(
                    name: SearchMatchesPage.routeName,
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                size: 23.0,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.star_border,
                size: 23.0,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await showTopModalSheet(
                  context: context,
                  child: CalendarWidget(
                    selectedDate: _selectedDate,
                    onSelect: ((selectedDate) {
                      setState(() {
                        _selectedDate = selectedDate;
                        _fetchLeagues(_selectedDate);
                      });
                    }),
                  ));
            },
            icon: Icon(
              Icons.calendar_month_outlined,
              size: 23.0,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              size: 23.0,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DatePickerTimeline(
                    currentDate: _selectedDate,
                    startDate:
                        DateTime.now().subtract(const Duration(days: 100)),
                    onDateChange: (date) {
                      setState(() {
                        _selectedDate = date;
                        _fetchLeagues(_selectedDate);
                      });
                    })
              ],
            ),
          ),
        ),
      ),
      body: _isLeagueError
          ? Center(
              child: Text(
                'Something went Wrong',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            )
          : _isLeagueLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: kBlueColor,
                  ),
                )
              : ListView(
                  controller: _scrollController,
                  children: _matchLeagues
                      .map(
                        (matches) => TeamMatch(
                          date: getDate(_selectedDate),
                          games: matches.gameMatches,
                        ),
                      )
                      .toList(),
                ),
    );
  }
}
