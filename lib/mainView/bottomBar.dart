import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
// 잘 몰라서 Stateless로 구성, 필요 시 추후 Stateful로 변경하길 바람
class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Container(
        height: 70,
        padding: EdgeInsets.only(bottom: 10, top: 5),
        child: TabBar(
          // indicator는 현재 선택된 Tab에 대한 정보, 추후 디자인 수정 요마
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
          indicatorWeight: 4,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black38,
          // 글씨체 바꾸고 싶은데 현재 변경이 안 됌
          labelStyle: TextStyle(
            fontSize: 14, /*fontFamilyFallback: fontFamilyName('Rubik')*/
          ),
          // Tab icon 추가시 여기다 추가
          tabs: [
            Tab(
              icon: Icon(
                Icons.home,
                size: 20,
              ),
              text: 'Home',
            ),
            Tab(
              icon: Icon(
                Icons.search,
                size: 20,
              ),
              text: 'Search',
            ),
            Tab(
                icon: Icon(
                  Icons.people,
                  size: 20,
                ),
                text: 'My')
          ],
        ),
      ),
    );
  }
}