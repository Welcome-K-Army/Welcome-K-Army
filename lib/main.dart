import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
