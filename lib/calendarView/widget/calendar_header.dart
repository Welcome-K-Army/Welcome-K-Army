import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarHeader extends StatefulWidget {
  CalendarHeaderState createState() => new CalendarHeaderState();
}

class CalendarHeaderState extends State<CalendarHeader> {
  CalendarHeaderState();

  CalendarController _calendarController;

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.month,
    CalendarView.schedule
  ];

  @override
  initState() {
    _calendarController = CalendarController();
    _calendarController.selectedDate = DateTime(2021, 06, 01);
    _calendarController.displayDate = DateTime(2021, 06, 01);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double cellWidth = width / 9;
    return Row(
      childern: <Widget>[
        Container(
          width: cellWidth,
          height: cellWidth,
          color: 
        ),
      ]
    );
  }
}
