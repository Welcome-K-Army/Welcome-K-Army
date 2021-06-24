import 'package:flutter/material.dart';
import 'BottomSheetButton.dart';
import 'DropDownButtonList.dart';
import 'TitleText.dart';
import 'searchButton.dart';
import 'SearchBar.dart';

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.grey[500], spreadRadius: 3)
        ],
      ),
      child: Column(children: <Widget>[
        TitleText("상세검색"),
        SearchBar(),
        DropDownButtonList(),
        BottomSheetButton(),
      ]),
    );
  }
}
