import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool iconDialog = false;
  List<String> informList = [
    "서울특별시 노원구 공릉2동 화랑로 574",
    "http://www.kma.ac.kr/",
    "+82221970114"
  ];

  List<String> messageList = [
    "주소 복사",
    "웹사이트 열기",
    "전화 걸기",
    "복사 하기"
  ];

  List<IconData> informIconList = [
    Icons.location_on_outlined,
    Icons.web,
    Icons.phone,
    IconData(63084, fontFamily: 'MaterialIcons'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
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
        body: TabBarView(
          children: [
            buildInform(),
            Text('경쟁률'),
            Text('입시정보'),
            Text('교육과정'),
          ],
        ),
      ),
    ); // Column
  }

  Widget buildInform() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Image.asset("lib/image/1.jpg"),
            Divider(color: Color(0xFFD6D6D6), thickness: 1),
            ListTile(title: Text("육군사관학교"), subtitle: Text("육군, 사관학교")),
            Divider(color: Color(0xFFD6D6D6), thickness: 1),
            Column(
              children: buildInformTile(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildInformTile() {
    return List<Widget>.generate(informIconList.length - 1, (index) {
      return ListTile(
        leading: buildTooltipWithIconButton(messageList[index], informIconList[index], informList[index]),
        title: Text(informList[index]),
        trailing: buildTooltipWithIconButton(messageList[3], informIconList[3], informList[index]),
      );
    });
  }

  Widget buildTooltipWithIconButton(String message, String copyText, IconData iconData) {
    return Tooltip(
        message: message,
        child: IconButton(
          icon: Icon(iconData),
          onPressed: copyToClipboard(copyText),
        ));
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
