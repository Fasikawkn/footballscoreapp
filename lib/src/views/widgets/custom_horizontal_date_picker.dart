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
  DateTime selectedDate = DateTime.now(); // TO tracking date

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

  @override
  void initState() {
    currentDateSelectedIndex = widget.currentSelectedIndex;
    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, MediaQuery.of(context).padding.right, 0),
      axis: Axis.horizontal,
    );
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    currentDateSelectedIndex = widget.currentSelectedIndex;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CustomHorizontalDatePicker oldWidget) {
    print('current idex ${widget.currentSelectedIndex}');
  
    if (widget.currentSelectedIndex == 0) {
      print('zero');
      setState(() {
      currentDateSelectedIndex == widget.currentSelectedIndex;
      print('the selected >>>>> $currentDateSelectedIndex');
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
        duration: const Duration(milliseconds: 300),
        preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          child: Container(
            color: kPrimaryColor2,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10);
              },
              itemCount: 365,
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
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
                            DateTime.now().add(Duration(days: index));
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
                            listOfDays[DateTime.now()
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
                                DateTime.now()
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
