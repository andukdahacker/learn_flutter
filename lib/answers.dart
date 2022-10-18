import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Answers extends StatelessWidget {
  final List<int> answers;
  final Function pickAnswer;
  const Answers({super.key, required this.answers, required this.pickAnswer});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: [
          ...answers.map(
            (e) {
              return ElevatedButton(
                  onPressed: () => pickAnswer(e), child: Text("$e"));
            },
          )
        ],
      ),
    ));
  }
}
