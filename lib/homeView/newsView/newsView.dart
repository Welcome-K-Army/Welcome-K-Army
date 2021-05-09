import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../title_with_more_bbtn.dart';
import 'slideBanner.dart'

class NewsView extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget> [
            TitleWithMoreBtn(title: "News"),
            SlideBanner(),
          ]
        )
      )
    );
  }
}

