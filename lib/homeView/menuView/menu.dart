import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

final List<Menu> menuList = [
  new Menu(name: '공지사항', iconName: 'star'),
  new Menu(name: '지도검색', iconName: 'location_pin'),
  new Menu(name: '입시정보', iconName: 'search'),
  new Menu(name: '일정', iconName: 'calendar_today')
];

class Menu {
  var  name;
  var iconName;

  Menu({this.name, this.iconName});
}

class MenuIconButton extends StatelessWidget {
  MenuIconButton(this._Menu);

  Menu _Menu;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Icon(Icons.{_Menu.iconName}, size: 10),
        Text(_Menu.name)
      ]), // Column
    ); // ListTile
  }
}
