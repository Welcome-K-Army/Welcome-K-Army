import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

import 'provider/event_provider.dart';

import 'widget/calendar_widget.dart';
import 'package:flutter/src/material/app.dart';

class CustomCalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<EventProvider>(
    create: (context) => EventProvider(),
    child: MaterialApp(
      home: CalendarWidget(),
    )
  );
}