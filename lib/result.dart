import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Result extends StatelessWidget {
  final int yourScore;
  final int totalScore;
  final VoidCallback resetQuiz;
  const Result(
      {super.key,
      required this.totalScore,
      required this.yourScore,
      required this.resetQuiz});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: [
          Text("You have completed the quiz!"),
          Text("Your final score: $yourScore/$totalScore"),
          ElevatedButton(onPressed: resetQuiz, child: Text("Retry"))
        ],
      ),
    ));
  }
}
