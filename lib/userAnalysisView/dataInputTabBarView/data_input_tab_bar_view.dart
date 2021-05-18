import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class DataInputTabBarView extends StatefulWidget {
  DataInputTabBarViewState createState() => new DataInputTabBarViewState();
}

class DataInputTabBarViewState extends State<DataInputTabBarView> {
  final List<Tab> _tabs = <Tab> [
    Tab(text: "1차 시험"),
    Tab(text: "2차 시험"),
    Tab(text: "내신 및 수능"),    
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState;
    _tabController = TabController(
      vsync: this,
      length: 3,
    )
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
        body: Container(),           
    );
  }
}
