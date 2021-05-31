import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../page/event_editing_page.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidgetState createState() => new CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  CalendarWidgetState();

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
    return Scaffold(
        appBar: AppBar(
          title: Text('일정'),
          actions: <Widget>[
            PopupMenuButton(
                icon: Icon(Icons.add),
                itemBuilder: (context) {
                  var list = List<PopupMenuEntry<Object>>();
                  list.add(PopupMenuItem(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "일정 추가",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => EventEditingPage()),
                                  ),
                          )
                        ]),
                      ),
                      value: 1));
                  list.add(PopupMenuItem(child: Text("학교 일정 추가"), value: 2));
                  return list;
                }),
          ],
        ),
        body: SfCalendar(
          view: CalendarView.month,
          controller: _calendarController,
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          showDatePickerButton: true,
          allowedViews: _allowedViews,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.red,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventEditingPage()),
          ),
        ));
  }
}
