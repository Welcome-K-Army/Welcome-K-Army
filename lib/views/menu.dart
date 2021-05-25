import 'package:flutter/material.dart';
import '../settings/profile_menu.dart';
import 'package:flutter/src/widgets/basic.dart';
import '../model/user_data_model.dart';
import '../net/firebase.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/menu';
  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  UserData userData;

  void getUserData() async {
    final user = await userLoad();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        userData.copy(user);
      });
      print(user);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  MenuScreenState();
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
                  labelColor: Color(0xff8c52ff),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Color(0xff8c52ff), width: 4.0),
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

                  Container(),
                  Container(),
                  // Profile_menu(userData: userData),
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
