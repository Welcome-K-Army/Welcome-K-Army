import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String nickName,String email /*,int age, String gender*/) async {
  CollectionReference users = FirebaseFirestore.instance.collection('UserDetail');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users.add({'nickName': nickName,'email':email, 'uid': uid});
  return;
}
