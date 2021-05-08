import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class DropDownButtonWidget extends StatefulWidget {
  final String hint;
  final List<String> dropDownItems;

  const DropDownButtonWidget({Key key, this.hint, this.dropDownItems}) : super(key: key);

  @override
  _DropDownButtonWidgetState createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
        hint: Text(
          widget.hint,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black87),
        ),
        value: dropdownValue,
        style: const TextStyle(color: Colors.black87),
        onChanged: (newValue) {
          setState(() {
            dropdownValue = newValue;
          });
          
        },
        items: widget.dropDownItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )),
    );
  }
}
