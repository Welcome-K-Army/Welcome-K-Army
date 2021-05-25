import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_data_model.dart';

Future<void> userSetup(String nickName, String email, String gender, int age, String imageURL) async {
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
        'createdAt': DateTime.now().toString(),
        // 'imageURL':imageURL,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  return;
}

Future<UserData> userLoad() async {
  CollectionReference users = FirebaseFirestore.instance.collection('UserDetail');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  Map<String, dynamic> data;
  users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      data = documentSnapshot.data();
    }
  }).catchError((error) =>print(error));
  return UserData.fromJson(data);
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
        // 'imageURL':imageURL,
      })
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
  return;
}
