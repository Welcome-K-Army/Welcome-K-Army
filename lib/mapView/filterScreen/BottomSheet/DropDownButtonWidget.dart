import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FilterData.dart';
import '../School.dart';

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
          style: const TextStyle(color: Colors.black54),
        ),
        value: dropdownValue,
        style: const TextStyle(color: Colors.black87),
        onChanged: (newValue) {
          setState(() {
            dropdownValue = newValue;
          });
          var filterData = Provider.of<FilterData>(context, listen: false);
          switch(widget.hint){
            case("군종"):
              filterData.categories = categoryMap[newValue];
              break;
            case("계급"):
              filterData.classes = classMap[newValue];
              break;
            case("임관유형"):
              filterData.types = typeMap[newValue];
              break;
            case("나이 (만)"):
              filterData.ages = ageMap[newValue];
              break;
          }
          filterData.updateData();
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
