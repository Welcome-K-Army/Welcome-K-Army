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
    return Scaffold(
        appBar: AppBar(title: Text("일정"), actions: <Widget>[
          PopupMenuButton(
              icon: Icon(Icons.add),
              onSelected: (route) {
                Navigator.pushNamed(context, route);
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "../page/event_editing_page",
                      child: Text("일정 추가"),
                    ),
                    PopupMenuItem(
                      value: "",
                      child: Text("학교 일정 추가"),
                    )
                  ])
        ]),
        body: SfCalendar(
          view: CalendarView.month,
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          showDatePickerButton: true,
          allowedViews: _allowedViews,
        ));
  }
}
