import 'package:flutter/material.dart';

import 'package:Army/model/home/menu.dart';
import 'package:Army/model/home/person.dart';

import 'package:Army/page/calendar/calendar_page.dart';
import 'package:Army/page/home/notice_list_page.dart';

int contentNumber = 0;

final List<Color> eventColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.deepPurple
];

final List<Menu> menuList = [
  new Menu(name: '공지사항', icon: Icon(Icons.star, size: 30), widget: NoticeListPage()),
  new Menu(name: '지도검색', icon: Icon(Icons.location_pin, size: 30), widget: NoticeListPage()),
  new Menu(name: '입시정보', icon: Icon(Icons.search, size: 30), widget: NoticeListPage()),
  new Menu(name: '일정', icon: Icon(Icons.calendar_today, size: 30), widget: CalendarPage()),
  new Menu(name: '입시분석', icon: Icon(Icons.pie_chart, size: 30), widget: NoticeListPage()),
];

final List<String> publicImgList = [
  'assets/images/1.jpg',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
];

final List<Person> personList = [
  new Person(name: '장성호'),
  new Person(name: '나부겸'),
  new Person(name: '신민석'),
  new Person(name: '김민준'),
];
