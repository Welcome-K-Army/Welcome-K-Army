import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'tasks_widget.dart';
import 'package:Army/model/calendar/event_data_source.dart';
import 'package:Army/page/calendar/event_editing_page.dart';
import 'package:Army/page/calendar/school_event_adding_page.dart';
import 'package:Army/provider/event_provider.dart';

class CalendarWidget extends StatelessWidget {
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.month,
    CalendarView.schedule
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    provider.readEvent();
    final events = provider.events;
    return Scaffold(
      appBar: AppBar(title: Text("일정"), actions: <Widget>[
        PopupMenuButton(
            icon: Icon(Icons.add),
            onSelected: (value) {
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventEditingPage()),
                );
              }
              if (value == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SchoolEventAddingPage()),
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
          dataSource: EventDataSource(events),
          initialSelectedDate: DateTime.now(),
          cellBorderColor: Colors.transparent,
          showDatePickerButton: true,
          allowedViews: _allowedViews,
          onLongPress: (details) {
            provider.setDate(details.date);
            showModalBottomSheet(
              context: context,
              builder: (context) => TasksWidget(),
            );
          }),
    );
  }
}
