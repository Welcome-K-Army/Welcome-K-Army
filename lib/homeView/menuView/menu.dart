import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../../calendarView/calendar.dart';
import '../../userAnalysisView/analysisView/analysisView.dart';
import '../../userAnalysisView/dataInputTabBarView/data_input_tab_bar_view.dart';

final List<Menu> menuList = [
  new Menu(name: '공지사항', icon: Icon(Icons.star, size: 30), widget: DataInputTabBarView()),
  new Menu(name: '지도검색', icon: Icon(Icons.location_pin, size: 30), widget: DataInputTabBarView()),
  new Menu(name: '입시정보', icon: Icon(Icons.search, size: 30), widget: DataInputTabBarView()),
  new Menu(name: '일정', icon: Icon(Icons.calendar_today, size: 30), widget: DataInputTabBarView()),
  new Menu(name: '입시분석', icon: Icon(Icons.pie_chart, size: 30), widget: AnalysisView()),
];

class Menu {
  var name;
  Icon icon;
  Widget widget;

  Menu({this.name, this.icon, this.widget});
}

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({Key key, this.menu}) : super(key: key);

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
