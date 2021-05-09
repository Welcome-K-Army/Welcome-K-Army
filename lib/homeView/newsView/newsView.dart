import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../title_with_more_bbtn.dart';
import 'slideBanner.dart';

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFEDF0F4),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              TitleWithMoreBtn(title: "News", press: () {}),
              SlideBanner(),
            ])));
  }
}
