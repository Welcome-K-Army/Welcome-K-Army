import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Army/widget/calendar/calendar_widget.dart';
import 'package:Army/provider/event_provider.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    provider.readEvent();
    return Scaffold(
      body: CalendarWidget(),
    );
  }
}
