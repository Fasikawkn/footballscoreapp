import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/views/views.dart';
import 'package:footballscoreapp/src/views/widgets/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class MatchesPage extends StatefulWidget {
  static const routeName = 'footballscoreapp/matchespage';
  const MatchesPage({Key? key}) : super(key: key);

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            listOfMonths[_selectedDate.month - 1],
          ),
          centerTitle: true,
          leadingWidth: 112,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  size: 30.0,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.star_border,
                  size: 30.0,
                ),
              ),
            ],
          ),
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () async {
                await showTopModalSheet(
                    context: context,
                    child: CalendarWidget(
                      selectedDate: _selectedDate,
                      onSelect: ((selectedDate) {
                        // print("the selected date is");
                        // print(selectedDate);
                        setState(() {
                          _selectedDate = selectedDate;
                        });
                      }),
                    ));
              },
              icon: const Icon(
                Icons.calendar_month_outlined,
                size: 30.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                size: 30.0,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: CustomHorizontalDatePicker(
              currentSelectedIndex:
                  _selectedDate.difference(DateTime.now()).inDays,
              selectedMonth: ((currentMonth) {
                setState(() {});
              }),
              selectedTime: ((dateTime) {
                debugPrint("the selected time is $dateTime");
                setState(() {
                  _selectedDate = dateTime;
                });
              }),
            ),
          ),
        ),
        body: ListView(
          children: [1, 2, 3]
              .map(
                (match) => GestureDetector(
                  onTap: () {
                   pushNewScreenWithRouteSettings(
                     context, screen: 
                     const MatchDetail(), 
                     settings: const RouteSettings(
                       name: MatchDetail.routeName

                       )
                     );
                  },
                  child: const TeamMatch(),
                ),
              )
              .toList(),
        ));
  }
}
