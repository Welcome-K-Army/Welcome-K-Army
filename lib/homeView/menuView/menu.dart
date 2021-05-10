import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

final List<Menu> menuList = [
  new Menu(name: '공지사항', icon: Icon(Icons.star, size: 30), widget: TableBasicExample()),
  new Menu(name: '지도검색', icon: Icon(Icons.location_pin, size: 30), widget: TableBasicExample()),
  new Menu(name: '입시정보', icon: Icon(Icons.search, size: 30), widget: TableBasicExample()),
  new Menu(name: '일정', icon: Icon(Icons.calendar_today, size: 30), widget: TableBasicExample()),
];

class Menu {
  var name;
  Icon icon;
  Widget widget;

  Menu({required this.name, required this.icon, required this.widget});
}

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({
    Key? key,
    required this.menu
  }) : super(key: key);
  
  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => menu.widget),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        menu.icon,
        Text(menu.name),
      ]), // Column
    ); // ListTile
  }
}
