import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotesForm extends StatefulWidget {
  String title;
  String description;

  NotesForm({this.title, this.description});

  @override
  _NotesFormState createState() => _NotesFormState();
}

class _NotesFormState extends State<NotesForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [titleWidget(), SizedBox(height: 8), descriptionWidget()],
        ),
      ),
    );
  }

  Widget titleWidget() {
    return TextFormField(
      initialValue: widget.title,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
      decoration: InputDecoration(
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      validator: (val) => val.isEmpty && val == null ? 'Enter a title' : null,
      onChanged: (val) => setState(() => widget.title = val),
    );
  }

  Widget descriptionWidget() {
    return TextFormField(
      initialValue: widget.description,
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
          hintText: 'Description',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
      validator: (val) =>
          val.isEmpty && val == null ? 'Enter a description' : null,
      onChanged: (val) => setState(() => widget.description = val),
    );
  }
}
