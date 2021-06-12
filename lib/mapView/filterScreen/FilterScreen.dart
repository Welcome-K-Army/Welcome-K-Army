import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BottomSheet/FilterData.dart';
import 'MyFloatingButton.dart';
import 'FilteredResultScreen.dart';
import '../mapScreen/FilteredMap.dart';
import 'School.dart';
import 'data.dart';

class FilterScreen extends StatelessWidget {
  final List<School> schoolList = fillData();
  FilterData _filterData;

  bool _filter(School data){
    if(_filterData.categories != null && _filterData.categories != data.catagory)
      return false;
    if(_filterData.classes != null && _filterData.classes != data.classes)
      return false;
    if(_filterData.types != null && _filterData.types != data.type)
      return false;
    if(_filterData.ages != null && _filterData.ages != data.age)
      return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => FilterData())],
      child: Scaffold(
        floatingActionButton: MyFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Center(
          child: Consumer<FilterData>(
            builder: (context, filterData, child) {
              this._filterData = filterData;
              // return FilteredResultScreen(schoolList.where((school) => _filter(school)).toList());
              return FilteredMap(schoolList.where((school) => _filter(school)).toList());
            },
          ),
        ),
      ),
    );
  }
}
