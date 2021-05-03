import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mainpage extends StatelessWidget {
  Mainpage({this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      appBar: AppBar(
        title: Text(email),
      ),
      body: Container(
        child: Center(
          child: FlatButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("Logout")),
        ),
      ),
    );
  }
}
