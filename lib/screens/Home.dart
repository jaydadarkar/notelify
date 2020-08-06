import 'package:flutter/material.dart';

import '../models/NotesModel.dart';
import './MyAccount.dart';
import './NewNote.dart';
import './EditNote.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<List<Map<String, dynamic>>> _notes = NotesModel.instance.queryAll();

  Future<List<dynamic>> myNotes() {
    setState(() {
      _notes = NotesModel.instance.queryAll();
    });
    return _notes;
  }

  int _id(dynamic post) {
    return post['_id'];
  }

  String _title(dynamic post) {
    return post['title'];
  }

  String _body(dynamic post) {
    return post['body'];
  }

  String _createdAt(dynamic post) {
    return post['created_at'];
  }

  String _updatedAt(dynamic post) {
    return post['updated_at'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add_circle_outline),
            color: Colors.white,
            tooltip: 'New Note',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewNote(),
                  ));
            }),
        IconButton(
            icon: Icon(Icons.account_circle),
            color: Colors.white,
            tooltip: 'My Account',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAccount(),
                  ));
            }),
      ]),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: myNotes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.toString() == '[]') {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'You seem to have saved no notes yet.',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 18, height: 2),
                      ),
                      RaisedButton(
                          color: Colors.teal,
                          child: Text(
                            'Create Your First Note',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewNote(),
                                ));
                          })
                    ],
                  ),
                );
              }
              return ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _title(snapshot.data[index])
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          _body(snapshot.data[index]),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.edit),
                                            color: Colors.teal,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditNote(_id(snapshot
                                                            .data[index])),
                                                  ));
                                            }),
                                        IconButton(
                                            key: Key(_id(snapshot.data[index])
                                                .toString()),
                                            icon: Icon(Icons.delete),
                                            color: Colors.teal,
                                            onPressed: () async {
                                              int i = await NotesModel.instance
                                                  .delete(_id(
                                                      snapshot.data[index]));
                                              myNotes();
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Created At:- ' +
                                            _createdAt(snapshot.data[index])),
                                        Text('Last Updated:- ' +
                                            _updatedAt(snapshot.data[index])),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      shadowColor: Colors.black,
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myNotes();
        },
        tooltip: 'Sync',
        child: Icon(Icons.sync),
      ),
    );
  }
}
