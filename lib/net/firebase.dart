import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String nickName, String email, String gender, int age) async {
  CollectionReference users = FirebaseFirestore.instance.collection('UserDetail');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users
      .doc(uid)
      .set({
        'nickName': nickName,
        'email': email,
        'gender': gender,
        'age': age,
        'uid': uid,
        'createdAt': DateTime.now().toString()
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  return;
}

Future<void> userLoad() async {
  CollectionReference users = FirebaseFirestore.instance.collection('UserDetail');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      print(documentSnapshot.data);
    } else {
      print('no data');
    }
  });
  return;
}

Future<void> userUpdate(String nickName, String email, String gender, int age) async {
  CollectionReference users = FirebaseFirestore.instance.collection('UserDetail');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users
      .doc(uid)
      .update({
        'nickName': nickName,
        'email': email,
        'gender': gender,
        'age': age,
        'uid': uid,
      })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
  return;
}
