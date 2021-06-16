import 'package:flutter/material.dart';

import 'widget/admission_widget.dart';
import 'widget/competition_chart_widget.dart';
import 'widget/inform_widget.dart';


class DetailView extends StatefulWidget {
    
  final Arguments arguments;


  
  DetailViewState createState() => DetailViewState();
}

class DetailViewState extends State<DetailView> {

  DetailView({@required this.arguments});
  bool iconDialog = false;

  List<String> informList = [
    arguments.name,
    arguments.address,
    arguments.number,
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
            InformWidget(),
            CompetitionChartWidget(),
            CompetitionChartWidget(),
            Text('교육과정'),
          ],
        ),
      ),
    ); // Column
  }
}

class Arguments{
  String name;
  String address;
  String number;
  Arguments(this.name,this.address,this.number);
}