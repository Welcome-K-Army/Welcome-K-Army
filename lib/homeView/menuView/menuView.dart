import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../../constants.dart';
import 'menu.dart';

import '../title_with_more_bbtn.dart';
import 'favorite_menu.dart';

class MenuView extends StatefulWidget {
  MenuViewState createState() => new MenuViewState();
}

class MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEDF0F4),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              TitleWithMoreBtn(title: "Favorite", press: () {}),
              FavoriteMenu(),
            ]))); // GridView
  } // Widget
} // Class
