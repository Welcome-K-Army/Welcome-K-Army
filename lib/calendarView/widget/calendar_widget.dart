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
              onSelected: (value) {
                if (value == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventEditingPage()),
                  );
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text("일정 추가"),
                    ),
                    PopupMenuItem(
                      value: 2,
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
