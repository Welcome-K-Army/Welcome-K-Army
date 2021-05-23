import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'custom_drop_down_button.dart';

class InputSchoolGrades extends StatefulWidget {
  InputSchoolGrades();

  InputSchoolGradesState createState() => InputSchoolGradesState();
}

class InputSchoolGradesState extends State<InputSchoolGrades> {
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

  int num = 0;
  List<TextEditingController> textEditingControllers;

  InputSchoolGradesState();

  @override
  void initState() {
    super.initState;
    textEditingControllers = List<TextEditingController>.generate(3, (index) {
      return TextEditingController();
    }).toList();
    for (int index = 0; index < 3; index++) {
      textEditingControllers[index].addListener(() {
        print(textEditingControllers[index].text);
      });
    }
  }

  void dispose() {
    for (int index = 0; index < 3; index++) {
      textEditingControllers[index].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text("교과성적"),
            Row(children: [
              Text("국어"),
              Container(
                width: size.width / 3,
                child: TextField(
                  controller: textEditingControllers[1],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "10",
                    labelText: "이수 과목 개수",
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.arrow_forward_rounded),
                  onPressed: () {
                    setState(() {
                      num = int.parse(textEditingControllers[0].text);
                    });
                  }),
            ]),
            Row(children: [
              CustomDropDownButton(width: size.width / 3 - 10, dropdownValue: languageSubjects[0], items: languageSubjects),
              Container(
                width: size.width / 3 - 10,
                child: TextField(
                  controller: textEditingControllers[1],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "1",
                    labelText: "석차",
                  ),
                ),
              ),
              Container(
                width: size.width / 3 - 10,
                child: TextField(
                  controller: textEditingControllers[2],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "1",
                    labelText: "이수 단위",
                  ),
                ),
              ),
            ]),
          ],
        ));
  }
}
