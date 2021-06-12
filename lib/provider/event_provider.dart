import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Army/model/calendar/event.dart';
import 'package:Army/services/authenticate.dart';

class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void addEvent(Event event) async {
    _events.add(event);
    await FireStoreUtils.updateUserCalendarEvent(_events.indexOf(event).toString(), event);
    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) async {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;
    await FireStoreUtils.updateUserCalendarEvent(_events.indexOf(newEvent).toString(), newEvent);
    notifyListeners();
  }

  void deleteEvent(Event event) async {
    await FireStoreUtils.deleteUserCalendarEvent(_events.indexOf(event).toString());
    _events.remove(event);
    notifyListeners();
  }
}
