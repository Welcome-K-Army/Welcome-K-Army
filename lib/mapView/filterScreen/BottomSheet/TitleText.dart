import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String _title;

  TitleText(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.fromLTRB(10,5,10,0),
        child: Text(
          _title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ));
  }
}
