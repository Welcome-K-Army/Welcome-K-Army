import 'package:flutter/material.dart';
import 'package:Army/services/authenticate.dart';
import 'package:Army/model/home/notice.dart';
class NoticeProvider extends ChangeNotifier {
  List<Notice> _notices = [];
  
  List<Notice> get notices => _notices;

  void readNotice() async {
    _notices = await FireStoreUtils.getNoticeList();
    notifyListeners();
  }

}