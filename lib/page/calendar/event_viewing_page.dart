import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_editing_page.dart';
import '../../utils.dart';
import '../../model/calendar/event.dart';
import '../../provider/event_provider.dart';
import '../../widget/calendar/calendar_widget.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({
    Key key,
    this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildViewingActions(context, event, provider),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
            buildDateTime(event),
            SizedBox(height: 32),
            Text(
              event.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              event.description,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
  }

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', event.from),
        if (!event.isAllDay) buildDate('To', event.to),
      ],
    );
  }

  Widget buildDate(String title, DateTime date) {
    return Row(children: [
      Expanded(
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          Utils.toDate(date),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }

  List<Widget> buildViewingActions(BuildContext context, Event event, EventProvider provider) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => EventEditingPage(event: event),
          ),
        ),
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          provider.deleteEvent(event);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => CalendarWidget()
            )
          );
        },
      ),
    ];
  }
}
