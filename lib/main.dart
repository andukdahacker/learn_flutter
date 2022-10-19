import "package:flutter/material.dart";
import "package:intl/intl.dart";
import 'package:learn_flutter/widgets/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,

        // errorColor: Colors.red,
      ),
      home: const Home(),
    );
  }
}
