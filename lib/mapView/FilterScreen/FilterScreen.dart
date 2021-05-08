import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BottomSheet/FilterData.dart';
import 'MyFloatingButton.dart';
import 'FilteredResultScreen.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => FilterData())],
      child: Scaffold(
        floatingActionButton: MyFloatingActionButton(),
        body: Center(
          child: Consumer<FilterData>(
            builder: (context, filteredData, child) {
              return FilteredResultScreen(filteredData);
            },
          ),
        ),
      ),
    );
  }
}
