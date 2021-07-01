
import 'package:Army/constants.dart';
import 'package:Army/page/calendar/school_event_list_page.dart';
import 'package:Army/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Army/model/calendar/event.dart';
import 'package:Army/provider/event_provider.dart';
import 'package:Army/storage/storage.dart';

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
    "국군간호사관학교",
    "육군학군사관(ROTC)",
    "해군학군사관(ROTC)",
    "공군학군사관(ROTC)"
  ];

  final List<Color> eventColors = [
    Color(0xFFB81D1D),
    Color(0xFF7FD969),
    Color(0xFF51A3A7),
    Color(0xFF7E5DAD),
    Color(0xFF556AA8),
    Color(0xFFC1674E),
    Color(0xFFC2A40C)
    // Colors.pink,
    // Colors.orange,
    // Colors.yellow,
    // Colors.green,
    // Colors.blue,
    // Colors.purple,
  ];

  List<String> themes = [];
  List<List<bool>> checkThemes = [];
  List<Event> events = [];
  List<SchoolEvent> schoolEvents = [];
  List<List<dynamic>> data = [];
  List<dynamic> dataList = [];

  loadAsset(String school) async {
    final myData =
        await StorageUtils().loadCsv("curriculums/" + school + " 일정.csv");
    data = myData;
    dataList.add(data);
    setState(() {});
    return data;
  }

  filter_event(int index) {
    List<List<dynamic>> data = dataList[index];
    int count = 0;
    if (data.length == 0) return null;

    for (int i = 1; i < data.length; i++) {
      if (themes.isEmpty) {
        themes.add(data[i][0]);
      }
      if (themes.last != data[i][0]) {
        final schoolEvent = SchoolEvent(name: data[i - 1][0], events: events);
        schoolEvents.add(schoolEvent);
        count = count + 1;
        themes.add(data[i][0]);
        events = [];
      }
      final event = Event(
        title: data[i][1],
        from: DateTime.parse(data[i][2]),
        to: DateTime.parse(data[i][3]),
        description: data[i][4],
        backgroundColor: eventColors[i % eventColors.length],
        isAllDay: false,
      );
      events.add(event);
    }
    if (schoolEvents.isEmpty) {
      final schoolEvent = SchoolEvent(name: data[1][0], events: events);
      schoolEvents.add(schoolEvent);
    } else {
      final schoolEvent = SchoolEvent(name: data.last[0], events: events);
      schoolEvents.add(schoolEvent);
    }
  }

  dispose_event() {
    themes = [];
    events = [];
    schoolEvents = [];
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < schoolList.length; i++) {
      loadAsset(schoolList[i]);
      checkThemes.add([false, false, false, false, false]);
    }
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              )),
          backgroundColor: Color(COLOR_PRIMARY),
          title: Center(child: Text("학교 일정 추가")),
          leading: Container(),
          leadingWidth: 0),
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

  Widget buildSearchForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: '검색',
                ),
                onFieldSubmitted: (_) =>
                    searchSubmitted(schoolNameController.text),
                validator: (title) => title != null && title.isEmpty
                    ? 'School Name cannot be empty'
                    : null,
                controller: schoolNameController,
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, size: 24),
              onPressed: () => searchSubmitted(schoolNameController.text),
            )
          ],
        ),
      );

  Widget buildSchoolListView(EventProvider provider) => Column(
        children: buildSchoolListTile(searchResult, provider),
      );

  List<Widget> buildSchoolListTile(String text, EventProvider provider) {
    final List<Widget> schoolTiles =
        List<Widget>.generate(schoolList.length, (index) {
      if (schoolList[index].contains(text)) {
        return ListTile(
          title: Text(schoolList[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.event_available_rounded),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SchoolEventListPage(schoolName: schoolList[index])),
                  );
                },
              ),
              IconButton(
                  icon: Icon(Icons.add
                      // IconData(58445),
                      ),
                  onPressed: () {
                    filter_event(index);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text(schoolList[index]),
                          content: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return SingleChildScrollView(
                                child: Column(
                                    children: List<Widget>.generate(
                                        themes.length, (j) {
                              return Row(children: [
                                Checkbox(
                                    value: checkThemes[index][j],
                                    onChanged: (value) {
                                      setState(() {
                                        checkThemes[index][j] = value;
                                      });
                                    }),
                                Text(themes[j]),
                              ]);
                            })));
                          }),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("확인"),
                              onPressed: () {
                                for (int i = 0;
                                    i < checkThemes[index].length;
                                    i++) {
                                  if (checkThemes[index][i]) {
                                    for (int j = 0;
                                        j < schoolEvents[i].events.length;
                                        j++) {
                                      provider
                                          .addEvent(schoolEvents[i].events[j]);
                                    }
                                  }
                                }
                                dispose_event();
                                Navigator.pop(context);
                              },
                            ),
                            new FlatButton(
                              child: new Text("닫기"),
                              onPressed: () {
                                dispose_event();
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  }),
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
