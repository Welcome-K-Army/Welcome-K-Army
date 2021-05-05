import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'package:intl/intl.dart';

class Notice {
  var date = DateFormat.yMd().format(new DateTime.now());
  String title;
  String context;

  Notice({this.title, this.context});
}

class NoticeTile {
  NoticeTile(this._notice);

  final Notice _notice;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: _notice.title,
        subtitle: _notice.date, 
    ); // ListTile
  }
}

class HeaderTile {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
            width: 36.0,
            height: 25.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(36.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0),
                ] // boxShadw
                        ) // BoxDecoration
                    ) // Container
                ) // ClipRRect
            ) // SizedBox
        ); // Return Container
  }
}
