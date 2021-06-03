import 'package:flutter/material.dart';

import '../model/event.dart';
import '../provider/event_provider.dart';

class SchoolEventAddingPage extends StatefulWidget {
  @override
  _SchoolEventAddingPageState createState() => _SchoolEventAddingPageState();
}

class _SchoolEventAddingPageState extends State<SchoolEventAddingPage> {
  final schoolNameController = TextEditingController();
  final List<String> schoolList = [
    "육군사관학교",
    "해군사관학교",
    "공군사관학교",
    "간호사관학교"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    schoolNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            //buildSearchForm(),
            buildSchoolList(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchForm() => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: TextFormField(
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Add School Name',
              ),
              onFieldSubmitted: (_) => searchSubmitted(schoolNameController.text),
              validator: (title) => title != null && title.isEmpty ? 'School Name cannot be empty' : null,
              controller: schoolNameController,
            ),
          ),
          Expanded(
              child: IconButton(
            icon: Icon(Icons.search, size: 24),
            onPressed: () => searchSubmitted(schoolNameController.text),
          )),
        ],
      );

  Widget buildSchoolList() => ListView(
        children: buildSchoolListTile(),
      );

  List<Widget> buildSchoolListTile() {
    return List<Widget>.generate(schoolList.length, (index) {
      return ListTile(
        title: Text(schoolList[index]),
        leading: buildListTileIcons(),
      );
    });
  }

  Widget buildListTileIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: IconButton(
          icon: Icon(Icons.add,
              //IconData(57506),
              size: 24),
          onPressed: () {},
        )),
        Expanded(
            child: IconButton(
          icon: Icon(Icons.add,
              //IconData(58445),
              size: 24),
          onPressed: () {},
        )),
      ],
    );
  }

  void searchSubmitted(String text) {
    print(text);
    schoolNameController.clear();
  }
}
