import 'package:flutter/material.dart';

import '../utils.dart';

/*
class EventEditingPage extends StatefulWidget {
  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

*/
class EventEditingPage extends StatefulWidget {
  final Event event;

  const EventEditingPage({
    Key key,
    this.event,
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime fromDate;
  DateTime toDate;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildTitle(),
            SizedBox(height: 12),
            buildDateTimePickers(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleForm(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {},
          icon: Icon(Icons.done),
          label: Text('SAVE'),
        )
      ];
         
  Widget buildTitle() => TextFormField(
        style: TextStyle(fontSize: 24),
        duration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add Title',
        ),
        onFieldSubmitted: (_) {},
        controller: titleController,
      );
  
  Widget buildDateTimePickers() => Column(
    children: [
      buildFrom(),
    ]
  );

  Widget buildFrom() => Row(
    children: [
      Expanded(
        child: buildDropdownField(
          text: Utils.toDate(fromDate),
          onClicked: () {},
        ),
      ),
      Expanded(
        child: buildDropdownField(
          text: Utils.toDate(fromDate),
          onClicked: () {},
        )
      )
    ]
  );   

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) => ListTile(
      title: Text(text)
      trailing: Icon(Icons.arrow_drop_down),
      onTap: onClicked,
    );  
}
