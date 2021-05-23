import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'custom_drop_down_button.dart';

class InputSchoolGrades extends StatefulWidget {
  InputSchoolGrades();

  InputSchoolGradesState createState() => InputSchoolGradesState();
}

class InputSchoolGradesState extends State<InputSchoolGrades> {
  final List<String> mainSubjects = [
    "국어",
    "영어",
    "수학",
    "과학탐구",
    "사회탐구"
  ];

  final List<String> languageSubjects = [
    "화법과 작문",
    "독서",
    "언어와 매체",
    "문학"
  ];

  final List<String> englishSubjects = [
    "영어회화",
    "영어 I",
    "영어 II",
    "영어 독해와 작문"
  ];

  final List<String> mathSubjects = [
    "수학 I",
    "수학 II",
    "미적분",
    "확률과 통계"
  ];
  final List<String> socialSubjects = [
    "생활과 윤리",
    "윤리와 사상",
    "한국지리",
    "세계지리",
    "동아시아사",
    "세계사",
    "정치와 법",
    "경제",
    "사회문화"
  ];

  final List<String> scienceSubjects = [
    "물리학 I",
    "화학 I",
    "생명과학 I",
    "지구과학 I"
  ];

  final List<String> rating = [
    "점수"
  ];

  final List<String> subjectTime = [
    "이수단위"
  ];

  List<List> subjectList;

  List<TextEditingController> languageTextEditingControllers;
  List<TextEditingController> englishTextEditingControllers;
  List<TextEditingController> mathTextEditingControllers;
  List<TextEditingController> socialTextEditingControllers;
  List<TextEditingController> scienceTextEditingControllers;
  List<List> controllers;

  InputSchoolGradesState();

  @override
  void initState() {
    super.initState;

    subjectList = [
      this.languageSubjects,
      this.englishSubjects,
      this.mathSubjects,
      this.socialSubjects,
      this.scienceSubjects,
    ];
    controllers = [
      this.languageTextEditingControllers,
      this.englishTextEditingControllers,
      this.mathTextEditingControllers,
      this.socialTextEditingControllers,
      this.scienceTextEditingControllers
    ];

    for (int index = 0; index < controllers.length; index++) {
      controllers[index] = List<TextEditingController>.generate(subjectList[index].length * 2, (index) {
        return TextEditingController();
      }).toList();
    }

    for (int i = 0; i < controllers.length; i++) {
      for (int j = 0; j < controllers[i].length; j++) {
        controllers[i][j].addListener(() {
          print(controllers[i][j].text);
        });
      }
    }
  }

  void dispose() {
    for (int i = 0; i < controllers.length; i++) {
      for (int j = 0; j < controllers[i].length; j++) controllers[i][j].dispose();
    }
    super.dispose();
  }

  Widget buildCard(Size size, String title, List<String> items, List<TextEditingController> controllers) {
    return Container(
        child: Card(
            child: Column(children: [
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(title),
      ),
      Column(
          children: List<Widget>.generate(items.length, (index) {
        return Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(children: [
              CustomDropDownButton(width: size.width / 3 - 15, dropdownValue: items[index], items: items),
              Padding(
                padding: EdgeInsets.all(7.5),
                child: Container(
                  width: size.width / 3 - 15,
                  child: TextField(
                    controller: controllers[index * 2],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "1",
                      labelText: "석차",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7.5),
                child: Container(
                  width: size.width / 3 - 15,
                  child: TextField(
                    controller: controllers[index * 2 + 1],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "1",
                      labelText: "이수 단위",
                    ),
                  ),
                ),
              )
            ]));
      }))
    ])));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: List<Widget>.generate(5, (index) {
          return buildCard(
            size,
            mainSubjects[index],
            subjectList[index],
            controllers[index],
          );
        })));
  }
}
