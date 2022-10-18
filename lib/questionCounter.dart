import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuestionCounter extends StatelessWidget {
  int total;
  int currentIndex;
  QuestionCounter({super.key, required this.total, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$currentIndex/$total"),
    );
  }
}
