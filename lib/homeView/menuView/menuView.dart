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
    return Card(
        color: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              MenuTitleWithMoreBtn(title: "Favorite", press: () {}),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
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
