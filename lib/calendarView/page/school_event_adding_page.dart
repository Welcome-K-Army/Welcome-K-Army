import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/event.dart';
import '../provider/event_provider.dart';

class SchoolEventAddingPage extends StatefulWidget {
  @override
  _SchoolEventAddingPageState createState() => _SchoolEventAddingPageState();
}

class _SchoolEventAddingPageState extends State<SchoolEventAddingPage> {
  final schoolNameController = TextEditingController();
  String searchResult = "";
  final List<String> schoolList = [
    "육군사관학교",
    "해군사관학교",
    "공군사관학교",
    "간호사관학교"
  ];

  List<SchoolEvent> schoolEvents;

  @override
  void initState() {
    super.initState();
    schoolEvents = List.generate(schoolList.length, (index) {
      return SchoolEvent(name: schoolList[index], events: [
        new Event(title: "1차시험", description: "국어, 영어, 수학", from: DateTime.now(), to: DateTime.now().add(Duration(hours: 2)), backgroundColor: Colors.red, isAllDay: false),
        new Event(title: "2차시험", description: "면접, 신체검사, 체력측정", from: DateTime(2021, 7, 4), to: DateTime(2021, 7, 4).add(Duration(hours: 2)), backgroundColor: Colors.blue, isAllDay: false),
        new Event(title: "결과발표", description: "결과발표", from: DateTime(2021, 8, 4), to: DateTime(2021, 8, 4).add(Duration(hours: 2)), backgroundColor: Colors.green, isAllDay: false),
      ]);
    });
  }

  @override
  void dispose() {
    schoolNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            buildSearchForm(),
            buildSchoolListView(provider),
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

  Widget buildSchoolListView(EventProvider provider) => Column(
        children: buildSchoolListTile(searchResult, provider),
      );

  List<Widget> buildSchoolListTile(String text, EventProvider provider) {
    final List<Widget> schoolTiles = List<Widget>.generate(schoolList.length, (index) {
      if (schoolList[index].contains(text)) {
        return ListTile(
          title: Text(schoolList[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  //Icons.add
                  IconData(57506),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  //Icons.add
                  IconData(58445),
                ),
                onPressed: () {
                  for (int i = 0; i < schoolEvents[index].events.length; i++) {
                    print(i);
                    print(schoolEvents[index].events[i]);
                    provider.addEvent(schoolEvents[index].events[i]);
                    print(provider.events[i]);
                  }
                },
              ),
            ],
          ),
        );
      } else
        return Container();
    });
    return schoolTiles;
  }

  Widget buildListTileIcons(EventProvider provider) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            //Icons.add
            IconData(57506),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            //Icons.add
            IconData(58445),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  void searchSubmitted(String text) {
    setState(() {
      searchResult = text;
    });
    schoolNameController.clear();
  }
}
