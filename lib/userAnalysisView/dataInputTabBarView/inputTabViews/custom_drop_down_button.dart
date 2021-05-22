import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:provider/provider.dart';

import 'input_type_multi_provider.dart';

class CustomDropDownButton extends StatefulWidget {
  final Size size;
  String dropdownValue;
  List<String> items;
  
  CustomDropDownButton({this.size, this.dropdownValue, this.items});

  CustomDropDownButtonState createState() => CustomDropDownButtonState(size: size, dropdownValue: dropdownValue, items: items);
}

class CustomDropDownButtonState extends State<CustomDropDownButton> {
  final Size size;
  String dropdownValue;
  List<String> items;
  final TextEditingController _textEditingController = TextEditingController();

  CustomDropDownButtonState({this.size, this.dropdownValue, this.items});

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
    TypeStatus typeStatus = Provider.of<TypeStatus>(context);
    InstitutionStatus institutionStatus = Provider.of<InstitutionStatus>(context);

    return Container(
      height: size.height,
      width: size.width,
      child: DropdownButton<String>(
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
        switch (dropdownValue) {
          case "사관학교":
            institutionStatus.setStatus(true);
            break;
          case "학군단":
            institutionStatus.setStatus(false);
            break;
          case "부사관":
            institutionStatus.setStatus(false);
            break;
          default:
            break;
        }
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      )
    );
  }
}
