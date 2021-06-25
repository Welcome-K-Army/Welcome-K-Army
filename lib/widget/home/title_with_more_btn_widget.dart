import 'package:flutter/material.dart';

import 'package:Army/constants.dart';

class TitleWithCustomUnderLine extends StatelessWidget {
  const TitleWithCustomUnderLine({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ), // Text
          ), // Padding
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,

              decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.2),borderRadius: BorderRadius.circular(10))

            ), // Container
          ), // Positioned
        ], // <Widget> []
      ), // Stack
    ); // Container
  }
}

class TitleWithMoreBtnWidget extends StatelessWidget {
  const TitleWithMoreBtnWidget({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);

  final String title;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: TitleWithCustomUnderLine(text: title),),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextButton(
            onPressed: press,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:Color(COLOR_PRIMARY),
              ),
              child:Text(
                "더보기",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ), // FlatButton
        ),
      ], // <Widget>[]
    ); // Row
  }
}
