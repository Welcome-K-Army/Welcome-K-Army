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

  factory Event.fromJson(Map<String, dynamic> parsedJson) {
    return new Event(
      title: parsedJson['title'] ?? '',
      description: parsedJson['description'] ?? '',
      from: parsedJson['from'] ?? '',
      to: parsedJson['to'] ?? '',
      backgroundColor: Color(parsedJson['backgroundColor']) ,
      isAllDay: parsedJson['isAllDay'] ?? false
    ); 
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'description': this.description,
      'from': this.from,
      'to': this.to,
      'backgroundColor': this.backgroundColor,
      'isAllDay': this.isAllDay,
    };
  }
}

class SchoolEvent {
  final String name;
  final List<Event> events;

  const SchoolEvent({
    this.name,
    this.events,
  });
}
