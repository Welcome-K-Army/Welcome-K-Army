import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:provider/provider.dart';

import 'input_type_multi_provider.dart';

class TitleWithTextfield extends StatefulWidget {
  final double width;
  String title;
  String hint;
  List<String> scoreList;
  TitleWithTextfield({this.width, this.title, this.hint, this.scoreList});

  TitleWithTextfieldState createState() => TitleWithTextfieldState(width: width, title: title, hint: hint, scoreList: scoreList);
}

class TitleWithTextfieldState extends State<TitleWithTextfield> {
  final double width;
  String title;
  String hint;
  List<String> scoreList;
  List<TextEditingController> textEditingControllers;

  TitleWithTextfieldState({this.width, this.title, this.hint, this.scoreList});

  @override
  void initState() {
    super.initState;
    textEditingControllers = List<TextEditingController>.generate(scoreList.length, (index) {
      return TextEditingController();
    }).toList();
    for (int index = 0; index < scoreList.length; index++) {
      textEditingControllers[index].addListener(() {
        print(textEditingControllers[index].text);
      });
    }
  }

  void dispose() {
    for (int index = 0; index < scoreList.length; index++) {
      textEditingControllers[index].dispose();
    }
    super.dispose();
  }

  Widget buildCard(List<String> scoreList, String title) {
    return Container(
        height: 65.0 * scoreList.length + 90.0,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(title),
                  ),
                  Column(
                    children: List<Widget>.generate(scoreList.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(7.5),
                          child: TextField(
                            controller: textEditingControllers[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: hint,
                              labelText: scoreList[index],
                            ),
                          ));
                    }).toList(),
                  )
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 50.0 * scoreList.length + 80.0, width: width, child: buildCard(scoreList, title));
  }
}
