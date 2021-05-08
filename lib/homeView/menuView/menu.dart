import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

final List<Menu> menuList = [
  new Menu(name: '공지사항', icon: Icon(Icons.star. size: 10)),
  new Menu(name: '지도검색', icon: Icon(Icons.location_pin. size: 10)),
  new Menu(name: '입시정보', icon: Icon(Icons.search. size: 10)),
  new Menu(name: '일정', icon: Icon(Icons.calendar_today. size: 10)),
];

class Menu {
  var name;
  Icon icon;

  Menu({this.name, this.icon});
}

class MenuIconButton extends StatelessWidget {
  MenuIconButton(this._Menu);

  Menu _Menu;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        _Menu.icon,
        Text(_Menu.name),
      ]), // Column
    ); // ListTile
  }
}
