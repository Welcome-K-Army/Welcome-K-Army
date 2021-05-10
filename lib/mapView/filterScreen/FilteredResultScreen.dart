import 'package:flutter/material.dart';
import 'School.dart';

class FilteredResultScreen extends StatelessWidget {
  final List<School> filteredData;

  FilteredResultScreen(this.filteredData);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: filteredData.map((school) => Text(school.name)).toList(),
    ));
  }
}
