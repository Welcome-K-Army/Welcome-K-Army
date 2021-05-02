import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.amber,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.black,
                    ),
                  ],
                ), ////<Widget>[], Stack
                Text("Don't Have an Account?"),
                Container(
                  height: 12,
                )
              ], //<Widget>[]
            ), //Column
          ], //<Widget>[]
        ), //Stack
      ); //Scaffold

  }
}
