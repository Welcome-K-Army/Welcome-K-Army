import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'menu.dart';

class MenuView extends StatefulWidget {
  MenuViewState createState() => new MenuViewState();
}

class MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: menuList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      )
      itemBuilder: (context, index) {
            return MenuIconButton(menuList[index]);
      },
    ); // GridView
  } // Widget
} // Class
