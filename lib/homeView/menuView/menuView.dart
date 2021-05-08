import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class MenuView extends StatefulWidget {
  MenuViewState createState() => new MenuViewState();
}

class MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: ListView.generate(), // ListView.generate
    ); // GridView
  } // Wdiget
} // Class
