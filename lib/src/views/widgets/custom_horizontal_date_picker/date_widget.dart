import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'tap.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;
  final double dateSize, daySize, monthSize;
  final Color dateColor, monthColor, dayColor;
  final Color selectionColor;
  final DateSelectionCallback? onDateSelected;
 
  const DateWidget(
      {Key? key,
      required this.date,
      required this.dateSize,
      required this.daySize,
      required this.monthSize,
      required this.dateColor,
      required this.monthColor,
      required this.dayColor,
      required this.selectionColor,
     
      this.onDateSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          width: 40,
          margin: const EdgeInsets.all(3.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat("E").format(date).toUpperCase()[0], // WeekDay
                style: TextStyle(
                  color: dayColor,
                  fontSize: daySize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: selectionColor,
                  shape: BoxShape.circle
                  
                ),
                child: Text(
                  date.day.toString(), // Date
                  style:Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: dateColor
                  )
                  //  TextStyle(
                  //   color: dateColor,
                  //   fontSize: dateSize,
                  //   fontFamily: 'Roboto',
                  //   fontWeight: FontWeight.w700,
                  // ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // Check if onDateSelected is not null
          if (onDateSelected != null) {
            // Call the onDateSelected Function
            onDateSelected!(date);
          }
        });
  }
}
