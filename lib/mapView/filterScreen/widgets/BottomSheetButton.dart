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
    return !checkingFlight
        ? MaterialButton(
            color: Colors.grey[800],
            onPressed: () async {
              setState(() {
                checkingFlight = true;
              });
              await Future.delayed(Duration(seconds: 1));
              setState(() {
                success = true;
              });
              await Future.delayed(Duration(milliseconds: 500));
              Navigator.pop(context);
            },
            child: Text(
              '검색',
              style: TextStyle(color: Colors.white, fontSize:14),
            ),
          )
        : !success
            ? CircularProgressIndicator()
            : Icon(
                Icons.check,
                color: Colors.green,
              );
  }
}
