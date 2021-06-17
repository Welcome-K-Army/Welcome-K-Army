import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import 'package:Army/utils.dart';
import 'package:Army/global.dart';

import 'package:Army/model/calendar/event.dart';
import 'package:Army/provider/event_provider.dart';

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
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime fromDate;
  DateTime toDate;
  Color eventColor;
  List<Color> eventColors = [
    Colors.red,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];
  List<bool> eventColorCheckValues = [];

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
      eventColor = eventColors[0];
      for (int i = 0; i < eventColors.length; i++) {
        if (i == 0)
          eventColorCheckValues.add(true);
        else
          eventColorCheckValues.add(false);
      }
    } else {
      final event = widget.event;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      eventColor = event.backgroundColor;
      for (int i = 0; i < eventColors.length; i++) {
        if (eventColor.value == eventColors[i].value)
          eventColorCheckValues.add(true);
        else
          eventColorCheckValues.add(false);
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEditingActions(provider),
      ),
      body: ListView(padding: EdgeInsets.all(12), children: [
        Form(
          key: _formKey,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(provider),
              SizedBox(height: 12),
              buildDateTimePickers(),
              SizedBox(height: 12),
              buildColor(size),
              SizedBox(height: 12),
              buildDescription(provider),
            ],
          ),
        ),
      ]),
    );
  }

  List<Widget> buildEditingActions(EventProvider provider) => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () async {
            saveForm(provider);
          },
          icon: Icon(Icons.done),
          label: Text('SAVE'),
        )
      ];

  Widget buildTitle(EventProvider provider) => TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add Title',
        ),
        onFieldSubmitted: (_) => saveForm(provider),
        validator: (title) => title != null && title.isEmpty ? 'Title cannot be empty' : null,
        controller: titleController,
      );

  Widget buildDateTimePickers() => Column(children: [
        buildFrom(),
        buildTo(),
      ]);

  Widget buildFrom() => buildHeader(
        header: "FROM",
        child: Row(children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
              text: Utils.toDate(fromDate),
              onClicked: () => pickFromDateTime(pickDate: true),
            ),
          ),
          Expanded(
              child: buildDropdownField(
            text: Utils.toTime(fromDate),
            onClicked: () => pickFromDateTime(pickDate: false),
          ))
        ]),
      );

  Widget buildTo() => buildHeader(
        header: "To",
        child: Row(children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
              text: Utils.toDate(toDate),
              onClicked: () => pickToDateTime(pickDate: true),
            ),
          ),
          Expanded(
              child: buildDropdownField(
            text: Utils.toTime(toDate),
            onClicked: () => pickToDateTime(pickDate: false),
          ))
        ]),
      );

  Future pickFromDateTime({bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate = DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() => fromDate = date);
  }

  Future pickToDateTime({bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime> pickDateTime(
    DateTime initialDate, {
    bool pickDate,
    DateTime firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time = Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date = DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Widget buildDropdownField({
    String text,
    VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({
    String header,
    Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: TextStyle(fontWeight: FontWeight.bold)),
          child,
        ],
      );

  Widget buildDescription(EventProvider provider) => buildHeader(
      header: "Description",
      child: TextFormField(
        style: TextStyle(fontSize: 24),
        minLines: 6,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Add Description',
        ),
        onFieldSubmitted: (_) => saveForm(provider),
        controller: descriptionController,
      ));

  Widget buildColor(Size size) => buildHeader(
      header: "Color",
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: eventColors.length,
        itemBuilder: (context, index) {
          return buildColorCircle(index);
        },
      ));

  Widget buildColorCircle(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          eventColor = eventColors[index];
          eventColorCheckValues[index] = true;
          for (int i = 0; i < eventColors.length; i++) {
            if (i == index)
              continue;
            else
              eventColorCheckValues[i] = false;
          }
        });
      },
      child: Container(
        height: 17,
        width: 17,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: eventColors[index],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: eventColorCheckValues[index]
              ? Icon(
                  Icons.check,
                  size: 15,
                  color: Colors.white,
                )
              : Container(),
        ),
      ),
    );
  }

  Future saveForm(EventProvider provider) async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      final event = Event(
        title: titleController.text,
        description: descriptionController.text,
        from: fromDate,
        to: toDate,
        backgroundColor: eventColor,
        isAllDay: false,
      );

      final isEditing = widget.event != null;
      print(isEditing);
      if (isEditing) {
        provider.editEvent(event, widget.event);
      } else {
        provider.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }
}
