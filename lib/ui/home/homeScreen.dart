import 'package:Army/mapView/filterScreen/FilterScreen.dart';
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
      floatingActionButton: null,
      // backgroundColor: Colors.black87,
      body: DefaultTabController(
        length: 3,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              bottomNavigationBar: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.search),
                  ),
                  Tab(
                    icon: Icon(Icons.account_circle),
                  ),
                ],
                labelColor: Color(COLOR_PRIMARY),
                indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(color: Color(COLOR_PRIMARY), width: 2.0),
                  insets: EdgeInsets.only(bottom: 44),
                ),
                unselectedLabelColor: Colors.grey,
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  HomePage(),
                  FilterScreen(),
                  SettingScreen(user: user),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
