import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:provider/provider.dart';

import 'input_type_multi_provider.dart';

class CustomTextfield extends StatefulWidget {
  final double width;
  String title;
  String hint;
  List<String> scoreList;
  CustomTextfield({this.width, this.title, this.hint, this.scoreList});

  CustomTextfieldState createState() => CustomTextfieldState(width: width, title: title, hint: hint, scoreList: scoreList);
}

class CustomTextfieldState extends State<CustomTextfield> {
  final double width;
  String title;
  String hint;
  List<String> scoreList;
  final TextEditingController _textEditingController = TextEditingController();

  CustomTextfieldState({this.width, this.title, this.hint, this.scoreList});

  @override
  void initState() {
    super.initState;
    _textEditingController.addListener(() {
      print(_textEditingController.text);
    });
  }

  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  
  Widget buildCard(List<String> scoreList, String title) {
      return Container(
          height: 50.0* scoreList.length + 70.0,
          child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Column(
                children: [
                  Text(title),
                  Column(children: 
                List<Widget>.generate(scoreList.length, (index) {
                  return 
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: hint,
                        labelText: scoreList[index],
                      ),
                    );
                }).toList(),
              )
              ])
              ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 50.0 * scoreList.length + 80.0, width: width, child: buildCard(scoreList, title));
  }
}
