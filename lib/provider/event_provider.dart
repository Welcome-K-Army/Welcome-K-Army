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
    print("readEvent");
    print(_events.asMap);
    notifyListeners();
  }

  void addEvent(Event event) async {
    _events.add(await FireStoreUtils.addUserCalendarEvent(event));
    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) async {
    final index = _events.indexOf(oldEvent);
    _events[index] = await FireStoreUtils.updateUserCalendarEvent(newEvent, oldEvent);
    notifyListeners();
  }

  void deleteEvent(Event event) async {
    await FireStoreUtils.deleteUserCalendarEvent(event);
    _events.remove(event);
    notifyListeners();
  }
}
