import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  bool checkBoxValue = false;
  String actionText = "Default";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome K-Army",
      theme: ThemeData(primaryColor: Colors.blue),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('welcome k-army'),
            ),
            body: TabBarView(
              children: [
                Text('홈 스크린'),
                Text('검색 스크린'),
                Text('마이 스크린'),
              ],
            ),
            bottomNavigationBar: BottomBar(),
            /*
            TabBar(tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.search),
                text: 'Search',
              ),
              Tab(icon: Icon(Icons.people), text: 'My')
            ]),
            */
          )),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child: Container(
            height: 70,
            padding: EdgeInsets.only(bottom: 10, top: 5),
            child: TabBar(indicatorSize: TabBarIndicatorSize.label, indicatorColor: Colors.red, indicatorWeight: 4, labelColor: Colors.white, unselectedLabelColor: Colors.black38, labelStyle: TextStyle(fontSize: 17, fontFamilyFallback: fontFamilyName(GoogleFonts.Rubik()), tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  size: 20,
                ),
                text: 'Home',
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                  size: 20,
                ),
                text: 'Search',
              ),
              Tab(
                  icon: Icon(
                    Icons.people,
                    size: 20,
                  ),
                  text: 'My'
              ),
            ])));
  }
}
