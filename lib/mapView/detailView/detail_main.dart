import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'widget/admission_widget.dart';
import 'widget/competition_chart_widget.dart';
import 'widget/inform_widget.dart';

class DetailView extends StatefulWidget {
  Arguments arguments;
  DetailView({Key key, @required this.arguments}) : super(key: key);

  DetailViewState createState() => DetailViewState();
}

class DetailViewState extends State<DetailView> {
  bool iconDialog = false;

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
      widget.arguments.name,
      widget.arguments.address,
      widget.arguments.number,
      widget.arguments.web_address,
      widget.arguments.image,
      widget.arguments.pdfurl,
    ];
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
                text: 'pdf',
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
            InformWidget(informList),
            AdmissionWidget(informList[5]),
            CompetitionChartWidget(),
            Text('교육과정'),
          ],
        ),
      ),
    ); // Column
  }
}

class Arguments {
  String name;
  String address;
  String number;
  String web_address;
  String image;
  String pdfurl;
  Arguments(this.name, this.address, this.number, this.web_address, this.image,this.pdfurl);
}
