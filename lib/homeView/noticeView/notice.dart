import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class Notice {
  var date = DateTime.now();
  String title;
  String context;

  Notice(this.title, this.context);
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
        Text(_notice.context),
        Text(_notice.date),
      ], // ListTile Column children
    ));
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
                borderRadius: BorderRadius.circula(36.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(color: Color.black12, offset: Offset(3.0, 6.0), blurRadius: 10.0),
                ] // boxShadw
                        ) // BoxDecoration
                    ) // Container
                ) // ClipRRect
            ) // SizedBox
        ); // Return Container
  }
}
