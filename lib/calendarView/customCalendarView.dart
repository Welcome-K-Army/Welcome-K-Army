import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

import 'provider/event_provider.dart';

import 'widget/calendar_widget.dart';

class CustomCalendarView extends StatelessWidget {
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.schedule
  ];

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<EventProvider>(
    create: (context) => EventProvider(),
    child: Scaffold(
      body: CalendarWidget(),
    )
  );
}

/*
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
  Widget build(BuildContext context) => ChangeNotifierProvider<EventProvider>(
    create: (context) => EventProvider(),
    child: Scaffold(
      body: CalendarWidget(),
    )
  );
}
*/