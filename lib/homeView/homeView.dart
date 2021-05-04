import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'slideBanner.dart';
import 'notice.dart';

//bottomNavigationBar는 항상 내용 재구성 해야되서 Stateful로 구성
class HomeView extends StatefulWidget {
  HomeViewState createState() => new HomeViewState();
}

//Bottom Tab으로 구성된 HomeView, View 추가시 length 값 변경 및 body의 TabBarView에 생성자 추가할 것
class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return <Widget>(Scaffold(
            body: Column(children: [
      SlideBanner(),
      Notice(),
    ] // Column children
                ) // Column
            ) // Scaffold
        ); // Return Widget
  } // Wdiget
} // Class
