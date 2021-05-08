import 'package:flutter/material.dart';
import 'widgets/BottomSheetWidget.dart';

class FilterSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyFloatingActionButton(),
      body: Center(
        child: Text('HomeView'),
      ),
    );
  }
}


class MyFloatingActionButton extends StatefulWidget {
  @override
  State<MyFloatingActionButton> createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  bool showFab = true;

  @override
  Widget build(BuildContext context) {
    return showFab
        ? FloatingActionButton(
            onPressed: () {
              var bottomSheetController = showBottomSheet(
                  context: context, builder: (context) => BottomSheetWidget());
              showFloatingActionButton(false);
              bottomSheetController.closed.then((value) {
                showFloatingActionButton(true);
              });
            },
          )
        : Container();
  }
  void showFloatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }
}




