import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:provider/provider.dart';

import '../analysisView/analysisView.dart';

import './inputTabViews/input_type.dart';
import './inputTabViews/input_first_exam.dart';
import './inputTabViews/input_second_exam.dart';
import './inputTabViews/input_school_grades.dart';
import './inputTabViews/input_k_sat.dart';
import './inputTabViews/input_type_multi_provider.dart';

class DataInputTabBarView extends StatefulWidget {
  DataInputTabBarViewState createState() => new DataInputTabBarViewState();
}

class DataInputTabBarViewState extends State<DataInputTabBarView> with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab>[
    Tab(text: "전형"),
    Tab(text: "1차 시험"),
    Tab(text: "2차 시험"),
    Tab(text: "내신"),
    Tab(text: "수능")
  ];

  String dropdownValue = 'One';
  TabController _tabController;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState;
    _tabController = TabController(
      vsync: this,
      length: 5,
    );
    _textEditingController.addListener(() {
      print(_textEditingController.text);
    });
  }

  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TypeStatus>(create: (context) => TypeStatus()),
          ChangeNotifierProvider<InstitutionStatus>(create: (context) => InstitutionStatus()),
          ChangeNotifierProvider<ReadInputData>(create: (context) => ReadInputData()),
        ],
        child: Scaffold(
            appBar: AppBar(title: Text("UserDataInput"), bottom: TabBar(isScrollable: true, controller: _tabController, tabs: _tabs)),
            body: TabBarView(controller: _tabController, children: <Widget>[
              InputType(
                /*
                readDatas: List<ReadInputData>.generate(3, (index) {
                return ReadInputData(Provider.of<ReadInputData>(context));
              })
              */
              ),
              InputFirstExam(),
              InputSecondExam(),
              InputSchoolGrades(),
              InputKSAT(),
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnalysisView()),
                );
              },
              child: const Icon(Icons.navigation),
              backgroundColor: Color(0xFF0C9869),
            )));
  }
}
