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
      shrinkWrap: true,
      physics: ClampingScrollPhysics(), 
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: menuList.length,
      itemBuilder: (context, index) {
        return MenuIconButton(menuList[index]);
      },
    ); // GridView
  } // Widget
} // Class
