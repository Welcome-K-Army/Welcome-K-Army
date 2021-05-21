import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'custom_drop_down_button.dart';

class DataInputTabBarView extends StatefulWidget {
  String dropdownValue;
  List<String> item;
  DataInputTabBarViewState createState() => new DataInputTabBarViewState({
        this.dropdownValue,
        this.items
      });
}

class DataInputTabBarViewState extends State<DataInputTabBarView> {
  String dropdownValue;
  List<String> items;
  final TextEditingController _textEditingController = TextEditingController();

  DataInputTabBarViewState({this.dropdownValue, this.items});

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
