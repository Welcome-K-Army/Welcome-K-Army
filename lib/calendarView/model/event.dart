import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event({
    this.title,
    this.description,
    this.from,
    this.to,
    this.backgroundColor = Colors.red,
    this.isAllDay = false,
  });
}

class SchoolEvent {
  final String name;
  final List<Event> events;

  SchoolEvent({
    this.name,
    this.events,
  });
}
