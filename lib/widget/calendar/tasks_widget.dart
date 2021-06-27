import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:Army/model/calendar/event_data_source.dart';
import 'package:Army/page/calendar/event_viewing_page.dart';
import 'package:Army/provider/event_provider.dart';

class TasksWidget extends StatefulWidget {
  final DateTime clickedDate;
  TasksWidget({this.clickedDate});
  @override
  _TasksWidgetState createState() =>
      _TasksWidgetState(clickedDate: clickedDate);
}

class _TasksWidgetState extends State<TasksWidget> {
  final DateTime clickedDate;
  _TasksWidgetState({this.clickedDate});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return Stack(children: [
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
                DateFormat.d('ko').format(clickedDate).replaceAll("일", "") +
                    "  " +
                    DateFormat.EEEE('ko').format(clickedDate),
                style: TextStyle(fontSize: 15))),
        Container(
            height: 64.0,
            child: Divider(
              color: Colors.black12,
              height: 10,
              thickness: 1,
            )),
        Center(
          child: Text(
            '일정이 없습니다!',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        )
      ]);
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: TextStyle(fontSize: 16, color: Colors.black),
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        appointmentBuilder: appointmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        onTap: (details) {
          if (details.appointments == null) return;
          print(details.appointments);
          final event = details.appointments.first;

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventViewingPage(event: event),
          ));
        },
      ),
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
