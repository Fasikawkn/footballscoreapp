import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CustomHorizontalDatePicker extends StatefulWidget {
  CustomHorizontalDatePicker(
      {required this.selectedTime,
      required this.selectedMonth,
      required this.currentSelectedIndex,
      Key? key})
      : super(key: key);
  final Function(DateTime dateTime) selectedTime;
  final Function(int month) selectedMonth;
  int currentSelectedIndex;

  @override
  State<CustomHorizontalDatePicker> createState() =>
      _CustomHorizontalDatePickerState();
}

class _CustomHorizontalDatePickerState
    extends State<CustomHorizontalDatePicker> {
  DateTime selectedDate = DateTime.now().subtract(const Duration(days: 20)); // TO tracking date

  late AutoScrollController controller;

  int currentDateSelectedIndex = 0; //For Horizontal Date

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

  List<String> listOfDays = ["M", "T", "W", "T", "F", "S", "S"];

  _calculateIndex(){

  }

  @override
  void initState() {
    currentDateSelectedIndex = widget.currentSelectedIndex;
    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, MediaQuery.of(context).padding.right, 0),
      axis: Axis.horizontal,
      initialScrollOffset: 10,
      keepScrollOffset: true
    );
    super.initState();
  }
  @override
  void didChangeDependencies() {
    currentDateSelectedIndex = widget.currentSelectedIndex;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CustomHorizontalDatePicker oldWidget) {
  
    if (widget.currentSelectedIndex == 0) {
      setState(() {
      currentDateSelectedIndex == widget.currentSelectedIndex;
    });
      
    } else if (widget.currentSelectedIndex == 1 &&
        currentDateSelectedIndex == 0) {
      currentDateSelectedIndex = 1;
    } else {
      currentDateSelectedIndex = widget.currentSelectedIndex + 1;
    }
     
    _scrollToIndex(widget.currentSelectedIndex);
    super.didUpdateWidget(oldWidget);
  }

  Future _scrollToIndex(int index) async {
    await controller.scrollToIndex(index,
        duration: const Duration(milliseconds: 1),
        preferPosition: AutoScrollPosition.begin);
  }

 

  @override
  Widget build(BuildContext context) {
    debugPrint("Widget selected index ${widget.currentSelectedIndex.toString()}");
    debugPrint('Widget selected mont ${widget.selectedMonth.toString()}');
    debugPrint('Selected Date ${selectedDate.toString()}');
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Container(
            color: kPrimaryColor2,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10);
              },
              itemCount:  365 * 2,
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                 DateTime _startDate = DateTime.now().subtract(const Duration(days: 20));
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: controller,
                  index: index,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        currentDateSelectedIndex = index;
                        widget.currentSelectedIndex = index;
                        selectedDate =
                           _startDate.add(Duration(days: index));
                      });

                      widget.selectedTime(selectedDate);
                      widget.selectedMonth(selectedDate.month);
                    },
                    child: Container(
                      height: 80,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            listOfDays[_startDate
                                        .add(Duration(days: index))
                                        .weekday -
                                    1]
                                .toString(),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: currentDateSelectedIndex == index
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                                color: currentDateSelectedIndex == index
                                    ? Colors.blue
                                    : kPrimaryColor2),
                            child: Center(
                              child: Text(
                               _startDate
                                    .add(Duration(days: index))
                                    .day
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: currentDateSelectedIndex == index
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
