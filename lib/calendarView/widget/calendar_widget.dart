import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidgetState createState() => new CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  CalendarWidgetState();

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.month,
    CalendarView.schedule
  ];

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      showDatePickerButton: true,
      allowedViews: _allowedViews,
      scheduleViewMonthHeaderBuilder: (BuildContext buildContext, ScheduleViewMonthHeaderBuilder details) {
        return Container(
          color: Colors.red,
          child: Text("hello"),
        );
      }
    );
  }
}
