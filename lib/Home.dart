import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userDetail.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  MainPage({this.uId, this.email});
  final String uId;
  final String email;
  
  
  Future<Null> handleSignIn(BuildContext context) async {
    final userDetail = Provider.of<UserDetail>(context);
    User firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await FirebaseFirestore.instance.collection('usersDetail').where('uid', isEqualTo: uId).get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Update data to server if new user
        FirebaseFirestore.instance.collection('usersDetail').doc(firebaseUser.uid).set({
          'nickname': userDetail.nickName,
          'email': userDetail.email,
          'gender': userDetail.gender,
          'age':userDetail.age,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        });
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
                Text(userDetail.uId==null?"null":),
                Text(userDetail.nickName==null?"null":),
                Text(userDetail.email==null?"null":),
                Text(userDetail.age.toString()==null?"null":),
                Text(userDetail.gender==null?"null":),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
