import 'package:Army/constants.dart';
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
    final events = provider.events;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0),)),
          backgroundColor: Colors.white,
          title: Padding(padding:const EdgeInsets.only(left: 5) ,child:Text("일정", style:TextStyle(color:Colors.black87, fontWeight: FontWeight.bold)),) , actions: <Widget>[
        PopupMenuButton(
            icon: Icon(Icons.add, color:Colors.black87),
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
                  MaterialPageRoute(
                      builder: (context) => SchoolEventAddingPage()),
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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child:  SfCalendar(
            view: CalendarView.month,
            dataSource: EventDataSource(events),
            initialSelectedDate: DateTime.now(),
            cellBorderColor: Colors.transparent,
            showDatePickerButton: true,
            allowedViews: _allowedViews,
            onLongPress: (details) {
              provider.setDate(details.date);
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                builder: (context) => TasksWidget(clickedDate: details.date),
              );
            }),
      )
    );
  }
}
