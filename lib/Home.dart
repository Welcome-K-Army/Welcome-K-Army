import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MainPage extends StatelessWidget {
  MainPage({this.uid, this.email});
  final String uid;
  final String email;
  
  // Future<void> addUser(String nickName, int age, String gender) async {
  //   User firebaseUser = await FirebaseAuth.instance.currentUser;
  //   if (firebaseUser != null) {
  //     // Check is already sign up
  //     final QuerySnapshot result = await FirebaseFirestore.instance.collection('usersDetail').where('uid', isEqualTo: uid).get();
  //     final List<DocumentSnapshot> documents = result.docs;
  //     if (documents.length == 0) {
  //       // Update data to server if new user
  //       FirebaseFirestore.instance.collection('usersDetail').doc(firebaseUser.uid).set({
  //         'nickname': nickName,
  //         'email': email,
  //         'gender':gender,
  //         'age': age,
  //         'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(uid+" "+email),
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
