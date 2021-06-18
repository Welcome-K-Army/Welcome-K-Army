import 'package:flutter/material.dart';
import 'BottomSheet/MyBottomSheet.dart';
import 'dart:async';

class MyFloatingActionButton extends StatefulWidget {
  @override
  State<MyFloatingActionButton> createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  bool showFab = true;

  void showFloatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showFab
        ? FloatingActionButton(
            onPressed: () {
              var bottomSheetController = showBottomSheet(
                  context: context, builder: (context) => MyBottomSheet()
              );
              showFloatingActionButton(false);
              bottomSheetController.closed.then((value) async {
                await Future.delayed(Duration(milliseconds: 200));
                showFloatingActionButton(true);
              });
            },
            // backgroundColor: Color(0x00000000),
            backgroundColor: Colors.white,
            child: Center(
              child: Icon(
                Icons.keyboard_arrow_up_outlined,
                color: Colors.black87,
                size: 30,
              ),
            ),
          )
        : Container();
  }
}
