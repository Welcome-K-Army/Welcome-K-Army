import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AddUser extends StatelessWidget {
  final String nickName;
  final String email;
  final int age;

  AddUser(this.nickName, this.email, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    Future<void> addUser() async{
      User firebaseUser = await FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result =
            await FirebaseFirestore.instance.collection('usersDetail').where('id', isEqualTo: firebaseUser.uid).get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // Update data to server if new user
          FirebaseFirestore.instance.collection('usersDetail').doc(firebaseUser.uid).set({
            'nickname': firebaseUser.displayName,
            'photoUrl': firebaseUser.photoURL,
            'id': firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'chattingWith': null
          });
        }

    }
  
  }
}
