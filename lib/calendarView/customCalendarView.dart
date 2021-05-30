import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomCalendarView extends StatefulWidget{
  CustomCalendarViewState createState() => new CustomCalendarViewState();
}

class CustomCalendarViewState extends State<CustomCalendarView> {
  CustomCalendarViewState();
  
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.schedule
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
      ),
    );
  }
}