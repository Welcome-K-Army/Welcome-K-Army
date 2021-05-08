import 'package:flutter/material.dart';

import 'DecoratedInputField.dart';
import 'BottomSheetButton.dart';
import 'DropDownButtonWidget.dart';

class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
        ],
      ),
      child: Column(children: <Widget>[
        DecoratedInputField(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [DropDownButtonWidget(), DropDownButtonWidget()],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [DropDownButtonWidget(), DropDownButtonWidget()],
        ),
        BottomSheetButton(),
      ]),
    );
  }
}
