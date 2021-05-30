import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar_controller.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidgetState createState() => new CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  CalendarWidgetState();

  CalenderController _calenderController;

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.month,
    CalendarView.schedule
  ];

  @override
  initState() {
    _calenderController = CalenderController();
    _calenderController.selectDate = DateTime(2021, 06, 01);
    _calenderController.displayDate = DateTime(2021, 06, 01);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      controller: _calenderController,
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      showDatePickerButton: true,
      allowedViews: _allowedViews,
    );
  }
}
