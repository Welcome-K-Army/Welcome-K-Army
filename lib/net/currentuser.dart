import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth auth=FirebaseAuth.instance;

void inputData() {
  final User user = auth.currentUser;
  final uid = user.uid;
}