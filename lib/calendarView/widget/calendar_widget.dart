import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'tasks_widget.dart';
import '../model/event_data_source.dart';
import '../page/event_editing_page.dart';
import '../provider/event_provider.dart';

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
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
        appBar: AppBar(title: Text("일정"), actions: <Widget>[
          PopupMenuButton(
              icon: Icon(Icons.add),
              onSelected: (value) {
                if (value == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(create: (context) => EventProvider(), child: EventEditingPage()),
                      ));
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
              final provider = Provider.of<EventProvider>(context, listen: false);
              provider.setDate(details.date);
              showModalBottomSheet(
                context: context,
                builder: (context) => TasksWidget(),
              );
            }));
  }
}
