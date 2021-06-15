import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

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

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    } else {
      final event = widget.event;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      eventColor = eventColors[0];
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
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEditingActions(provider),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(provider),
                SizedBox(height: 12),
                buildDateTimePickers(),
                buildDescription(provider),
              ],
            ),
          )),
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
      final time = Duration(hours: initialDate.hour, minutes: initialDate.minute);

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
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add Description',
        ),
        onFieldSubmitted: (_) => saveForm(provider),
        controller: descriptionController,
      ));

  Widget buildColor(EventProvider provider) => buildHeader(
      header: "Color",
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: buildColorCircles(),
        ),
      ));

  List<Widget> buildColorCircles() {
    return List<Widget>.generate(eventColors.length, (index) {
      return RoundCheckBox(
        onTap: (selected) {
          setState(() {
            eventColor = eventColors[index];
          });
        },
        checkedWidget: Icon(Icons.check, color: Colors.white),
        checkedColor: eventColors[index],
        uncheckedColor: eventColors[index],
        animationDuration: Duration(
          seconds: 1,
        ),
      );
    });
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

      if (isEditing) {
        provider.editEvent(event, widget.event);
      } else {
        provider.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }
}
