import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'menu.dart';

class MenuView extends StatefulWidget {
  MenuViewState createState() => new MenuViewState();
}

class MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: ListView.builder(
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return MenuIconButton(menuList[index]);
          }), // ListView.builder
    ); // GridView
  } // Widget
} // Class
