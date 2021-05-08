import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'bottomBar.dart';

import '../homeView/homeView.dart';
import '../homeView/slideBanner.dart';

//bottomNavigationBar는 항상 내용 재구성 해야되서 Stateful로 구성
class MainView extends StatefulWidget {
  MainViewState createState() => new MainViewState();
}

class MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            HomeView(),
            Text('검색 스크린'),
            Text('마이 스크린'),
          ],
        ),
        bottomNavigationBar: BottomBar(),
      ),
    ); // Column
  }
}
