import 'package:flutter/material.dart';

class SchoolEventAddingPage extends StatefulWidget {
  @override
  _SchoolEventAddingPageState createState() => _SchoolEventAddingPageState();
}

class _SchoolEventAddingPageState extends State<SchoolEventAddingPage> {
  final _formKey = GlobalKey<FormState>();
  final schoolNameController = TextEditingController();

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
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildSearchForm(),
                SizedBox(height: 12),
              ],
            ),
          )),
    );
  }

  Widget buildSearchForm() => TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add School Name',
        ),
        onFieldSubmitted: (_) {},
        validator: (title) => title != null && title.isEmpty ? 'School Name cannot be empty' : null,
        controller: schoolNameController,
      );
}
