import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class CustomDropDownButton extends StatefulWidget {
  String dropdownValue;
  List<String> items;
  bool changed;
  CustomDropDownButton({this.dropdownValue, this.items});
  bool get ischanged()=>changed;
  CustomDropDownButtonState createState() => new CustomDropDownButtonState(
    changed:false;
    dropdownValue: dropdownValue,
    items: items
  );
}

class CustomDropDownButtonState extends State<CustomDropDownButton> {
  bool changed;
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

  
  String get getDropDownValue() => dropdownValue;
  
  changed=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DropdownButton<String>(
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
          changed=!changed;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
