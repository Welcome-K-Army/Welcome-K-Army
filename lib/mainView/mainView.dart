import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'bottomBar.dart';
// bottomNavigationBar는 항상 내용 재구성 해야되서 Stateful로 구성
class MainView extends StatefulWidget {
  MainViewState createState() => new MainViewState();
}
// BottomTab으로 구성된 MainView, view 추가시 length 값 변경 및 body의 TabBarView에 생성자 추가할 것
class MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        // 현재 Home, Search, Setting view 3개
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('welcome k-army'),
          ),
          // Home, Search, Setting view 만들고 나면 Text 생성자 대신 view 생성자로 교체
          body: TabBarView(
            children: [
              Text('홈 스크린'),
              Text('검색 스크린'),
              Text('마이 스크린'),
            ],
          ),
          bottomNavigationBar: BottomBar(),
        ));
  }
}