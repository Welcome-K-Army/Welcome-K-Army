import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'notice.dart';

class NoticeContextView extends StatefulWidget {
  NoticeContextViewState createState() => new NoticeContextViewState();
}

class NoticeContextViewState extends State<NoticeContextView> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('선택 완료'),
    ); // Container
  }
}
