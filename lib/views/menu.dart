import 'package:flutter/material.dart';
import '../settings/profile_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/basic.dart';
import '../model/user_data_model.dart';
import 'package:provider/provider.dart';
import '../net/firebase.dart';
class MenuScreen extends StatefulWidget {
  // MenuScreen();
  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  UserData userData;
  // User user;

  // Future<void> getUserData() async {
  //   User userData = await FirebaseAuth.instance.currentUser;
  //   setState(() {
  //     user = userData;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getUserData();
  // }
  
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
                          Text(userData.uid == null ? "null" : userData.uid),
                          Text(userData.nickName == null ? "null" : userData.nickName),
                          Text(userData.email == null ? "null" : userData.email),
                          Text(userData.age == null ? "null" : userData.age.toString()),
                          Text(userData.gender == null ? "null" : userData.gender),
                        ],
                      ),
                    ),
                
                  Container(),
                  Profile_menu(),
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
