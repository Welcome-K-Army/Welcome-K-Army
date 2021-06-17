import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class InformWidget extends StatefulWidget {
  final String name;
  final String address; 
  final String number;  // receives the value

  InformWidget({ Key key, this.name,this.address,this.number }): super(key: key);
  InformWidgetState createState() => InformWidgetState();
}

class InformWidgetState extends State<InformWidget> {

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
      List<String> informList = [
        widget.name,
        widget.address,
        widget.number,
      ];
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Image.asset("lib/image/1.jpg"),
            Divider(color: Color(0xFFD6D6D6), thickness: 1),
            ListTile(title: Text("육군사관학교"), subtitle: Text("육군, 사관학교")),
            Divider(color: Color(0xFFD6D6D6), thickness: 1),
            buildAddressTile(),
            buildUrlTile(),
            buildPhoneNumberTile(),
          ],
        ),
      ),
    );
  }

  Widget buildAddressTile() {
    return ListTile(
        leading: Tooltip(
            message: "주소 복사",
            child: IconButton(
                icon: Icon(informIconList[0]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList[0]));
                })),
        title: Text(informList[0]),
        trailing: Tooltip(
            message: "복사 하기",
            child: IconButton(
                icon: Icon(informIconList[3]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList[0]));
                })));
  }

  Widget buildUrlTile() {
    return ListTile(
        leading: Tooltip(
            message: "웹사이트 열기",
            child: IconButton(
                icon: Icon(informIconList[1]),
                onPressed: () {
                  _url_launcher(informList[1]);
                })),
        title: Text(informList[1]),
        trailing: Tooltip(
            message: "복사 하기",
            child: IconButton(
                icon: Icon(informIconList[3]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList[1]));
                })));
  }

  Widget buildPhoneNumberTile() {
    return ListTile(
        leading: Tooltip(
            message: "전화 걸기",
            child: IconButton(
                icon: Icon(informIconList[2]),
                onPressed: () {
                  _url_launcher("tel:$informList[2]");
                })),
        title: Text(informList[2]),
        trailing: Tooltip(
            message: "복사 하기",
            child: IconButton(
                icon: Icon(informIconList[3]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList[2]));
                })));
  }

  Future<void> _url_launcher(String url) async {
    if (await canLaunch(url)) {
      print("launch");
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
