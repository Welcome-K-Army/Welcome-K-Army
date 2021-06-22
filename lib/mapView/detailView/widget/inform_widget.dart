import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class InformWidget extends StatefulWidget {
  final List<String> informList;

  InformWidget(this.informList, {Key key}) : super(key: key);

  InformWidgetState createState() => InformWidgetState();
}

// List<String> informList = [
//   current_name,
//   current_address,
//   current_number,
// ];
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
    List<String> informList_ = widget.informList;
    return Container(
      decoration: new BoxDecoration(
        color: Colors.lightGreen[50],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            // displayCircleImage(informList_[4], 125, false),
            Image.asset(informList_[4]),
            Divider(color: Color(0xFFD6D6D6), thickness: 1),
            ListTile(title: Text(informList_[0])),
            Divider(color: Color(0xFFD6D6D6), thickness: 1),
            buildAddressTile(),
            buildUrlTile(),
            buildPhoneNumberTile(),
            page_detail(),
          ],
        ),
      ),
    );
  }

  Widget page_detail() {
    List<String> informList_ = widget.informList;
    return ListTile(
        leading: Tooltip(
            message: "세부계획바로가기",
            child: IconButton(
                icon: Icons.book,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList_[6]));
                })),
        title: Text(informList_[6]),
        trailing: Tooltip(
            message: "복사 하기",
            child: IconButton(
                icon: Icon(
                  Icons.book,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList_[6]));
                })));
  }

  Widget buildAddressTile() {
    List<String> informList_ = widget.informList;
    return ListTile(
        leading: Tooltip(
            message: "주소 복사",
            child: IconButton(
                icon: Icon(informIconList[0]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList_[1]));
                })),
        title: Text(informList_[1]),
        trailing: Tooltip(
            message: "복사 하기",
            child: IconButton(
                icon: Icon(informIconList[3]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList_[1]));
                })));
  }
  // Widget displayCircleImage(String picUrl, double size, hasBorder) =>
  //   CachedNetworkImage(
  //       imageBuilder: (context, imageProvider) =>
  //           _getCircularImageProvider(imageProvider, size, false),
  //       imageUrl: picUrl,
  //       placeholder: (context, url) =>
  //           _getPlaceholderOrErrorImage(size, hasBorder),
  //       errorWidget: (context, url, error) =>
  //           _getPlaceholderOrErrorImage(size, hasBorder));

  Widget buildUrlTile() {
    List<String> informList_ = widget.informList;
    return ListTile(
        leading: Tooltip(
            message: "웹사이트 열기",
            child: IconButton(
                icon: Icon(informIconList[1]),
                onPressed: () {
                  _url_launcher(informList_[3]);
                })),
        title: Text(informList_[3]),
        trailing: Tooltip(
            message: "복사 하기",
            child: IconButton(
                icon: Icon(informIconList[3]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList_[3]));
                })));
  }

  Widget buildPhoneNumberTile() {
    List<String> informList_ = widget.informList;
    return ListTile(
        leading: Tooltip(
            message: "전화 걸기",
            child: IconButton(
                icon: Icon(informIconList[2]),
                onPressed: () {
                  _url_launcher("tel:$informList_[2]");
                })),
        title: Text(informList_[2]),
        trailing: Tooltip(
            message: "복사 하기",
            child: IconButton(
                icon: Icon(informIconList[3]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: informList_[2]));
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
