import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget(
      {required this.onSelect, required this.selectedDate, Key? key})
      : super(key: key);
  final Function(DateTime selectedDate) onSelect;
  final DateTime selectedDate;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    _focusedDay = widget.selectedDate;
    _selectedDay = widget.selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50.0,),

      decoration:  BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days:100)),
        lastDay: DateTime.now().add(const Duration(days: 100)),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay; // update `_focusedDay` here as well
          });
          widget.onSelect(selectedDay);
          Navigator.of(context).pop();
        },
        headerStyle:  HeaderStyle(
          leftChevronIcon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyText1!.color,
            size: 15.0,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).textTheme.bodyText1!.color,
            size: 15.0,
          ),
          formatButtonVisible: false,
          formatButtonTextStyle: Theme.of(context).textTheme.bodyText1!,
          titleTextStyle: Theme.of(context).textTheme.bodyText1!,
        ),
        calendarStyle:  CalendarStyle(
          defaultTextStyle: Theme.of(context).textTheme.bodyText1!,
          selectedDecoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );

    // return Container(
    //   height: 430,
    //   padding: const EdgeInsets.only(
    //     top: 30.0,
    //   ),
    //   decoration: const BoxDecoration(
    //     color: kPrimaryColor,
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(20.0),
    //       bottomRight: Radius.circular(20.0),
    //     ),
    //   ),
    //   child: TableCalendar(

    //     firstDay: DateTime.utc(2010, 10, 16),
    //     lastDay: DateTime.utc(2030, 3, 14),

    //     focusedDay: _focusedDay,

    //    selectedDayPredicate: (day){
    //      return isSameDay(_selectedDay, day);
    //    },
    //     onDaySelected: (selectedDay, focusedDay) {
    //       setState(() {
    //         _selectedDay = selectedDay;
    //         _focusedDay = focusedDay;
    //       });
    //       // print(_focusedDay);
    //       widget.onSelect(selectedDay);
    //       Navigator.of(context).pop();

    //     },

    //     headerStyle: const HeaderStyle(
    //       leftChevronIcon: Icon(
    //         Icons.arrow_back_ios,
    //         color: Colors.white,
    //         size: 15.0,
    //       ),
    //       rightChevronIcon: Icon(
    //         Icons.arrow_forward_ios,
    //         color: Colors.white,
    //         size: 15.0,
    //       ),
    //       formatButtonVisible: false,
    //       formatButtonTextStyle: TextStyle(color: Colors.white),
    //       titleTextStyle: TextStyle(color: Colors.white),
    //     ),

    //     calendarStyle: const CalendarStyle(
    //       defaultTextStyle: TextStyle(color: Colors.white),
    //       todayDecoration: BoxDecoration(
    //         color: Colors.blue,
    //         shape: BoxShape.circle,
    //       ),

    //       selectedDecoration: BoxDecoration(
    //         color: Colors.blue,
    //         shape: BoxShape.circle,
    //       ),
    //     ),
    //   ),
    // );
  }
}
