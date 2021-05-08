import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../constants.dart';
import 'menu.dart';

class MenuView extends StatefulWidget {
  MenuViewState createState() => new MenuViewState();
}

class MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              MenuTitleWithMoreBtn(title: "자주찾는메뉴", press: () {}),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return MenuIconButton(menuList[index]);
                },
              )
            ]))); // GridView
  } // Widget
} // Class

class MenuTitleWithCustomUnderLine extends StatelessWidget {
  const MenuTitleWithCustomUnderLine({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
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
              color: kPrimaryColor.withOpacity(0.2),
            ), // Container
          ), // Positioned
        ], // <Widget> []
      ), // Stack
    ); // Container
  }
}

class MenuTitleWithMoreBtn extends StatelessWidget {
  const MenuTitleWithMoreBtn({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);

  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        MenuTitleWithCustomUnderLine(text: title),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ), // RoundedRectangleBorder
            color: kPrimaryColor,
            onPressed: press,
            child: Text(
              "더보기",
              style: TextStyle(color: Colors.white),
            ), // Text
          ), // FlatButton
        ),
      ], // <Widget>[]
    ); // Row
  }
}
