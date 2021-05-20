import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import '../analysisView/analysisView.dart';

class DataInputTabBarView extends StatefulWidget {
  DataInputTabBarViewState createState() => new DataInputTabBarViewState();
}

class DataInputTabBarViewState extends State<DataInputTabBarView> with SingleTickerProviderStateMixin {
  final List<Tab> _tabs = <Tab> [
    Tab(text: "전형"),
    Tab(text: "1차 시험"),
    Tab(text: "2차 시험"),
    Tab(text: "내신 및 수능"),    
  ];

  final TabController _tabController;
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
        appBar: AppBar(
          title: Text("UserDataInput"),
          bottom: TabBar(
            controller: _tabController,
            tabs: _tabs
          )
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            TextField( 
              controller: _controller, 
              decoration: InputDecoration( 
                border: OutlineInputBorder(), 
                hintText: 'hint', 
                labelText: 'ID', 
                prefixIcon: Icon(Icons.perm_identity), 
              ), 
            ),
            Text("1차 시험"),
            Text("2차 시험"),
            Text("내신 및 수능"),
          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnalysisView()),
           ); 
          },
          child: const Icon(Icons.navigation),
          backgroundColor: Color(0xFF0C9869),
        )          
    );
  }
}
