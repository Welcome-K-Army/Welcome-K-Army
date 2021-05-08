import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'menu.dart';

class MenuView extends StatefulWidget {
  MenuViewState createState() => new MenuViewState();
}

class MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget> [
                Icon(Icons.star, size: 5),
                Text('자주 찾는 메뉴'),
                Icon(Icons.add, size: 5),
              ]
            ),
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
          ]
      )
    ); // GridView
  } // Widget
} // Class
