import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class CustomDropDownButton extends StatelessWidget {}

class CustomDropDownButtonState extends State<CustomDropDownButton> {
  String dropdownValue;
  List<String> items;
  final TextEditingController _textEditingController = TextEditingController();

  CustomDropDownButtonState({this.dropdownValue, this.items});

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

  String get getDropDownValue => dropdownValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'hint',
          labelText: 'ID',
          prefixIcon: Icon(Icons.perm_identity),
        ),
      ),
    );
  }
}
