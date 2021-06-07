import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Army/provider/event_provider.dart';

import 'package:Army/widget/calendar/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CalendarWidget(),
      );
}
