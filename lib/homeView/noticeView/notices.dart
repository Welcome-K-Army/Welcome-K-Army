import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class Notice {
  int number;
  int day;
  String day_string;
  String title;
  String context;

  Notice(this.number, this.day, this.title, this.context);
}

class NoticeTile {
  NoticeTile(this._notice);

  final Notice _notice;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Column(
      children: <Widget>[
        Text(_notice.title),
        Text(data.day_string),
      ], // ListTile Column children
    ));
  }
}
