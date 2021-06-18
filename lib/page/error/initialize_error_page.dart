import 'package:flutter/material.dart';

class InitializeErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 25,
            ),
            SizedBox(height: 16),
            Text(
              'Failed to initialise firebase!',
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
          ],
        )),
      ),
    ));
  }
}
