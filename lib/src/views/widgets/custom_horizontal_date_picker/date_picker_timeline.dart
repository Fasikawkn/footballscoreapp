import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'date_widget.dart';
import 'color.dart';
import 'dimen.dart';
import 'tap.dart';
const MAXNUMBEROFDAYS = 200;

class DatePickerTimeline extends StatefulWidget {
  final double dateSize, daySize, monthSize;
  final Color dateColor, monthColor, dayColor;
  DateTime currentDate;
  final DateChangeListener? onDateChange;
  DateTime startDate;

  DatePickerTimeline(
      {Key? key,
      this.dateSize = Dimen.dateTextSize,
      this.daySize = Dimen.dayTextSize,
      this.monthSize = Dimen.monthTextSize,
      this.dateColor = AppColors.defaultDateColor,
      this.monthColor = AppColors.defaultMonthColor,
      this.dayColor = AppColors.defaultDayColor,
      this.onDateChange,
      required this.startDate,
      required this.currentDate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerTimeline> {
  late AutoScrollController _scrollController;

  @override
  void initState() {
    // DateTime _date = DateTime.now();
    // widget.currentDate = DateTime(_date.year, _date.month, _date.day);
    _scrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, MediaQuery.of(context).padding.right, 0),
      axis: Axis.horizontal,
      initialScrollOffset: (widget.currentDate.difference(widget.startDate).inDays +1) * 40.0,
      keepScrollOffset: true

    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DatePickerTimeline) {
    _scrollToIndex(widget.currentDate.difference(widget.startDate).inDays);

    super.didUpdateWidget(DatePickerTimeline);
  }

  Future _scrollToIndex(int index) async {
    await _scrollController.scrollToIndex(widget.currentDate.difference(widget.startDate).inDays,
        duration: const Duration(milliseconds: 1),
        preferPosition: AutoScrollPosition.begin);
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'The Date Difference is ${widget.currentDate.difference(widget.startDate).inDays}',
    );
    debugPrint(
      'The current index is $_currentIndex',
    );

    return Container(
      height: 60,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: MAXNUMBEROFDAYS,
        scrollDirection: Axis.horizontal,

        itemBuilder: (context, index) {
          DateTime _date = widget.startDate.add(Duration(days: index ));
          DateTime date = DateTime(_date.year, _date.month, _date.day);
          bool isSelected = compareDate(date, widget.currentDate);
          // _currentIndex = index;
          // print('The index is ${date.day} month ${date.month} ===> index$index');

          return AutoScrollTag(
            key: ValueKey(index),
            controller: _scrollController,
            index: index,
            child: DateWidget(
                date: date,
                dateColor:isSelected? Colors.white: widget.dateColor,
                dateSize: widget.dateSize,
                dayColor:isSelected? Colors.blue: widget.dayColor,
                daySize: widget.daySize,
                monthColor: widget.monthColor,
                monthSize: widget.monthSize,
               
                selectionColor: 
                isSelected ?
                 Colors.blue :
                 Colors.transparent,
                onDateSelected: (selectedDate) {
                  // A date is selected
                  if (widget.onDateChange != null) {
                    widget.onDateChange!(selectedDate);
                  }
                  setState(() {
                    widget.currentDate = selectedDate;
                    _currentIndex = index;
                  });
                }),
          );
        },
      ),
    );
  }

  bool compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}
