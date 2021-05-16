import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseService{
  
  final CollectionReference UserDetail = Firestore.instance.collection('UserDetail');
  
}