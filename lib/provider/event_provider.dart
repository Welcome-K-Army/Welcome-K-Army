import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Army/model/calendar/event.dart';
import 'package:Army/services/authenticate.dart';

class EventProvider extends ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void readEvent() async {
    _events = await FireStoreUtils().getUserCalendarEvent();
    notifyListeners();
  }

  void addEvent(Event event) async {
    _events.add(event);
    await FireStoreUtils.addUserCalendarEvent(event);
    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) async {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;
    await FireStoreUtils.updateUserCalendarEvent(index, newEvent);
    notifyListeners();
  }

  void deleteEvent(Event event) async {
    await FireStoreUtils.deleteUserCalendarEvent(_events.indexOf(event), event);
    _events.remove(event);
    notifyListeners();
  }
}
