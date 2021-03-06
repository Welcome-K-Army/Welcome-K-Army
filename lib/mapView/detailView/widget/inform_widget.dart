import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class InformWidget extends StatefulWidget {
  final List<String> informList;

  InformWidget(this.informList, {Key key}) : super(key: key);

  InformWidgetState createState() => InformWidgetState();
}

class InformWidgetState extends State<InformWidget> {
  List<String> messageList = ["주소 복사", "웹사이트 열기", "전화 걸기", "복사 하기"];

  List<IconData> informIconList = [
    Icons.location_on_outlined,
    Icons.web,
    Icons.phone,
    Icons.copy
  ];

  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void showCopyToast() {
    fToast.showToast(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Text(
            "복사되었습니다.",
            style: TextStyle(color: Colors.white),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> informList_ = widget.informList;
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            // displayCircleImage(informList_[4], 125, false),
            Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(padding:EdgeInsets.all(20), child:Image.asset(informList_[4])),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(informList_[0],style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Divider(color: Colors.black38, indent: 10, endIndent: 10, thickness: 1),
            buildAddressTile(),
            buildUrlTile(),
            buildPhoneNumberTile(),
            // page_detail(),
          ],
        ),
      ),
    );
  }

  // Widget page_detail() {
  //   List<String> informList_ = widget.informList;
  //   return ListTile(
  //       leading: Tooltip(
  //           message: "세부계획바로가기",
  //           child: IconButton(
  //               icon: Icons.book,
  //               onPressed: () {
  //                 Clipboard.setData(ClipboardData(text: informList_[6]));
  //               })),
  //       title: Text(informList_[6]),
  //       trailing: Tooltip(
  //           message: "복사 하기",
  //           child: IconButton(
  //               icon: Icon(
  //                 Icons.book,
  //               ),
  //               onPressed: () {
  //                 Clipboard.setData(ClipboardData(text: informList_[6]));
  //               })));
  // }

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
                  showCopyToast();
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
                  showCopyToast();
                  Clipboard.setData(ClipboardData(text: informList_[3]));
                })));
  }

  Widget buildPhoneNumberTile() {
    List<String> informList = widget.informList;
    return ListTile(
        leading: IconButton(
            icon: Icon(informIconList[2]),
            onPressed: () {
              _url_launcher("tel:" + informList[2]);
            }),
        title: Text(informList[2]),
        trailing: Tooltip(
            message: "복사 하기",
            child: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {
                  showCopyToast();
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
