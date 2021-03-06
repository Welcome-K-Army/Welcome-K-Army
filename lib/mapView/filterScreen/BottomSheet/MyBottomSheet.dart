import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BottomSheetButton.dart';
import 'DropDownButtonList.dart';
import 'MapController.dart';
import 'TitleText.dart';
import 'SearchBar.dart';

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // final size=MediaQuery.of(context).size;
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.grey[500], spreadRadius: 3)
        ],
      ),
      child: Column(children: <Widget>[
        TitleText("μμΈκ²μ"),
        Consumer<MapController>(builder: (context, controller, child) {
          return SearhBar(controller.controller);
        }),
        DropDownButtonList(),
        BottomSheetButton(),
      ]),
    );
  }
}
