import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Army/constants.dart';
import 'package:Army/model/user.dart';
import 'package:Army/ui/setting/settingScreen.dart';

import 'package:Army/page/home/home_page.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  State createState() {
    return _HomeState(user);
  }
}

class _HomeState extends State<HomeScreen> {
  final User user;

  _HomeState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      floatingActionButton: null,
      body: DefaultTabController(
        length: 3,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.video_library),
                    ),
                    Tab(
                      icon: Icon(Icons.insert_drive_file),
                    ),
                    Tab(
                      icon: Icon(Icons.account_circle),
                    ),
                  ],
                  labelColor: Color(COLOR_PRIMARY),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Color(COLOR_PRIMARY), width: 4.0),
                    insets: EdgeInsets.only(bottom: 44),
                  ),
                  unselectedLabelColor: Colors.grey,
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        // Text(userData.uid),
                        // Text(userData.nickName),
                        // Text(userData.email),
                        // Text(userData.age.toString()),
                        // Text(userData.gender),
                      ],
                    ),
                  ),
                  HomePage(),
                  Container(),
                  // Container(),
                  SettingScreen(user: user),
                  //VideoScreen(),
                  //AricleScreen(),
                  //ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
