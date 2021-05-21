import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../analysisView/analysisView.dart';

import './inputTabViews/input_exam_type.dart';

class DataInputTabBarView extends StatefulWidget {
  DataInputTabBarViewState createState() => new DataInputTabBarViewState();
}

class DataInputTabBarViewState extends State<DataInputTabBarView> with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab>[
    Tab(text: "전형"),
    Tab(text: "1차 시험"),
    Tab(text: "2차 시험"),
    Tab(text: "내신 및 수능"),
  ];

  String dropdownValue = 'One';
  TabController _tabController;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState;
    _tabController = TabController(
      vsync: this,
      length: 4,
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
    return Scaffold(
        appBar: AppBar(title: Text("UserDataInput"), bottom: TabBar(controller: _tabController, tabs: _tabs)),
        body: TabBarView(controller: _tabController, children: <Widget>[
          InputExamType(),
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'hint',
              labelText: 'ID',
              prefixIcon: Icon(Icons.perm_identity),
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            isExpanded: true,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>[
              'One',
              'Two',
              'Free',
              'Four'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Text("내신 및 수능"),
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
        ));
  }
}
