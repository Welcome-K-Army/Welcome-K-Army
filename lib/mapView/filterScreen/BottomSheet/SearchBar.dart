import 'dart:async';
import 'package:flutter/material.dart';

class SearhBar extends StatefulWidget {
  @override
  _SearhBarState createState() => _SearhBarState();
}

class _SearhBarState extends State<SearhBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(3),
        child:Padding(
          padding: const EdgeInsets.all(4),
          child: TextField(
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(hintText: 'Search Location', suffixIcon: Icon(Icons.search)),

            // onChanged: (value) => applicationBloc.searchPlaces(value), //값확인하는 클래스 생성
            // onTap: () => applicationBloc.clear_value(),
          ), //TextFiled
        )); //Padding );
  }
}