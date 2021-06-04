import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

import './page/home/home_page.dart';
import './provider/event_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'welcome k army',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ), // ThemeData
        home: MainPage(),
      ),
    ); // MaterialApp
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            HomePage(),
            Text('검색 스크린'),
            Text('마이 스크린'),
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    ); // Column
  }

  Widget buildBottomNavigationBar() {
    return Container(
      color: Colors.yellow,
      child: Container(
        height: 70,
        padding: EdgeInsets.only(bottom: 10, top: 5),
        child: TabBar(
          //indicator는 현재 선택된 Tab에 대한 정보, 추후 디자인 수정 요망
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
          indicatorWeight: 4,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black38,
          labelStyle: TextStyle(
            fontSize: 14,
          ),
          tabs: [
            Tab(
              icon: Icon(Icons.home, size: 20),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.search, size: 20),
              text: 'Search',
            ),
            Tab(
              icon: Icon(Icons.people, size: 20),
              text: 'My',
            ),
          ],
        ),
      ),
    );
  }
}
