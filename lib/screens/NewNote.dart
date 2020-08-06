import 'package:flutter/material.dart';

import '../models/NotesModel.dart';

class NewNote extends StatelessWidget {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add A Note',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              color: Colors.white,
              tooltip: 'Save',
              onPressed: () async {
                var date = DateTime.now();
                int i = await NotesModel.instance.insert({
                  NotesModel.title: _titleController.text,
                  NotesModel.body: _bodyController.text,
                  NotesModel.createdAt: date.day.toString() +
                      '/' +
                      date.month.toString() +
                      '/' +
                      date.year.toString() +
                      ' ' +
                      date.hour.toString() +
                      ':' +
                      date.minute.toString(),
                  NotesModel.updatedAt: date.day.toString() +
                      '/' +
                      date.month.toString() +
                      '/' +
                      date.year.toString() +
                      ' ' +
                      date.hour.toString() +
                      ':' +
                      date.minute.toString(),
                });
                _titleController.text = '';
                _bodyController.text = '';
                Navigator.pop(context);
              }),
          IconButton(
              icon: Icon(Icons.clear),
              color: Colors.white,
              tooltip: 'Clear',
              onPressed: () {
                _bodyController.text = '';
              }),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.white,
            tooltip: 'Discard',
            onPressed: () {
              _titleController.text = '';
              _bodyController.text = '';
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Form(
              child: Column(
                children: <Widget>[
                  TextField(
                    key: Key('title'),
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      contentPadding: EdgeInsets.all(2),
                      hintStyle: TextStyle(color: Colors.black54),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    style: TextStyle(fontSize: 18),
                  ),
                  TextField(
                    key: Key('body'),
                    controller: _bodyController,
                    minLines: 10,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Add Your Notes',
                      contentPadding: EdgeInsets.all(2),
                      hintStyle: TextStyle(color: Colors.black54),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
