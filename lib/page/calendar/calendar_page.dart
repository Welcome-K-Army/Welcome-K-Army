import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/event_provider.dart';

import '../../widget/calendar/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CalendarWidget(),
      );
}
