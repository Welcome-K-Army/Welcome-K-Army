import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../../constants.dart';
import 'menu.dart';

import 'title_with_more_bbtn.dart';

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
