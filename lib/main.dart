import "package:flutter/material.dart";

void main() {
  runApp(MyQuizApp());
}

class MyQuizApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyQuizAppState();
  }
}

class MyQuizAppState extends State<MyQuizApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('My Expenses App')),
          body: Text("Hello world")),
    );
  }
}
