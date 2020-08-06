import 'package:flutter/material.dart';

import 'screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notelify',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        splashColor: Colors.teal,
        focusColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(title: 'Notelify'),
    );
  }
}
