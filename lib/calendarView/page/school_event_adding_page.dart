import 'package:flutter/material.dart';

class SchoolEventAddingPage extends StatefulWidget {
  @override
  _SchoolEventAddingPageState createState() => _SchoolEventAddingPageState();
}

class _SchoolEventAddingPageState extends State<SchoolEventAddingPage> {
  final schoolNameController = TextEditingController();
  final List<String> schoolList = [];

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
      body: ListView(
        padding: EdgeInsets.all(12),
        children: <Widget>[
          buildSearchForm(),
        ],
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
      return ListTile();
    });
  }

  void searchSubmitted(String text) {
    print(text);
    schoolNameController.clear();
  }
}
