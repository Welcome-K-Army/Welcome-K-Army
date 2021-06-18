import 'package:flutter/material.dart';
import 'dart:async';

class BottomSheetButton extends StatefulWidget {
  _SheetButtonState createState() => _SheetButtonState();
}
class _SheetButtonState extends State<BottomSheetButton> {
  bool checkingFlight = false;
  bool success = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Material(
          color: Colors.white,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              color: Colors.black87,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ));
  }
}
