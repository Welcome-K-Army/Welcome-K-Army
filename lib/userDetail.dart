import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddUser extends StatelessWidget {
  final String uid;
  final String nickName;
  final String email;
  final int age;

  AddUser(this.uid,this.nickName, this.email, this.age);
  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return FirebaseFirestore.instance.collection('usersDetail').doc(uid).set({
            'uid':uid,
            'nickName': nickName, // John Doe
            'email': email, // login@naver.com
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

  }
}