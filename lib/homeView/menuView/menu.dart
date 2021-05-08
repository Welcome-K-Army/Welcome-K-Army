import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

final List<Menu> menuList = [

];

class Menu {
  String name;
  String iconName;

  Menu({this.name, this.iconName});
}

class MenuIconButton extends StatelessWidget {
  MenuIconButton(this._Menu);

  final Menu _Menu;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Icon(Icons.{_Menu.iconName}, size: 10),
          Text(_Menu.name)
        ]
      )
    ); // ListTile
  }
}