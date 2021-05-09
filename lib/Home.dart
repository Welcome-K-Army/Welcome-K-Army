import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userDetail.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  MainPage({this.uId, this.email});
  final String uId;
  final String email;

  Future<Null> handleSignIn() async {
    Future<void> addUser() async {
      User firebaseUser = await FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result = await FirebaseFirestore.instance.collection('usersDetail').where('uid', isEqualTo: uid).get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // Update data to server if new user
          FirebaseFirestore.instance.collection('usersDetail').doc(firebaseUser.uid).set({
            'nickname': Provider.of(UserDetail)(context).nickName,
            'email': Provider.of(UserDetail)(context).email,
            'gender': Provider.of(UserDetail)(context).gender,
            'age': Provider.of(UserDetail)(context).age,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetail>(
      builder: (context, userDetail, child) => Scaffold(
        appBar: AppBar(
          title: Text(email),
        ),
        body: Container(
          child: Center(
            child: FlatButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Column(children: <Widget>[
                Text("Logout"),
                // Text(userDetail.uId),
                // Text(userDetail.nickName),
                // Text(userDetail.email),
                // Text(userDetail.age.toString()),
                // Text(userDetail.gender),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
