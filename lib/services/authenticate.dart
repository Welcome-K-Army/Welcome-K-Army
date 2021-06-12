import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:Army/model/user.dart';
import 'package:Army/constants.dart';
import 'package:Army/model/calendar/event.dart';

class FireStoreUtils {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference storage = FirebaseStorage.instance.ref();

  Future<User> getCurrentUser(String uid) async {
    DocumentSnapshot userDocument = await firestore.collection(USERS).doc(uid).get();
    if (userDocument != null && userDocument.exists) {
      return User.fromJson(userDocument.data());
    } else {
      return null;
    }
  }

  static Future<User> updateCurrentUser(User user) async {
    return await firestore.collection(USERS).doc(user.userID).set(user.toJson()).then((document) {
      return user;
    });
  }

  Future<String> uploadUserImageToFireStorage(File image, String userID) async {
    Reference upload = storage.child("images/$userID.png");
    UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = upload.putData(await image.readAsBytes());
    } else {
      uploadTask = upload.putFile(image);
    }
    var downloadUrl = await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return downloadUrl.toString();
  }

  Future<Event> getUserCalendarEvent(String uid, String eventid) async {
    DocumentSnapshot eventDocument = await firestore.collection(uid).doc("Event" + eventid).get();
    if (eventDocument != null && eventDocument.exists) {
      return Event.fromJson(eventDocument.data());
    } else {
      return null;
    }
  }

  static Future<Event> updateUserCalendarEvent(String uid, String eventid, Event event) async {
    return await firestore.collection(uid).doc("Event" + eventid).set(event.toJson()).then((document) {
      return event;
    });
  }
}
