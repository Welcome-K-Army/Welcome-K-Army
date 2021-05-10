import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userDetail.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  MainPage({this.uId, this.email});
  final String uId;
  final String email;

  @override
  Widget build(BuildContext context) {
    Future<void> handleSignIn(BuildContext context) async {
      final userDetail = Provider.of<UserDetail>(context);
      User firebaseUser = await FirebaseAuth.instance.currentUser;
      //if (firebaseUser != null) {
      // Check is already sign up
      final CollectionReference users = FirebaseFirestore.instance.collection('UserDetail');
      final QuerySnapshot result = await users.where('uId', isEqualTo: uId).get();
      final List<DocumentSnapshot> documents = result.docs;
      print(documents.length);
      if (documents.length == 0) {
        // Update data to server if new user
        return users
            .doc(uId)
            .set({
              'nickname': userDetail.nickName,
              'email': userDetail.email,
              'gender': userDetail.gender,
              'age': userDetail.age,
              'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        ;
      }
      //}
    }

    return Consumer<UserDetail>(
      builder: (context, userDetail, child) => Scaffold(
        appBar: AppBar(
          title: Text(email),
        ),
        body: Container(
          child: Center(
            child: FlatButton(
              onPressed: () {
                handleSignIn(context);
                FirebaseAuth.instance.signOut();
              },
              child: Column(children: <Widget>[
                Text("Logout"),
                Text(userDetail.uId == null ? "null" : userDetail.uId),
                Text(userDetail.nickName == null ? "null" : userDetail.nickName),
                Text(userDetail.email == null ? "null" : userDetail.email),
                Text(userDetail.age == null ? "null" : userDetail.age.toString()),
                Text(userDetail.gender == null ? "null" : userDetail.gender),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
