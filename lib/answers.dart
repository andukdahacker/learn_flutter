import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final List<int> answers;
  final void Function(int) pickAnswer;
  const Answers({super.key, required this.answers, required this.pickAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...answers.map(
          (e) {
            return ElevatedButton(
                onPressed: () => pickAnswer(e), child: Text("$e"));
          },
        )
      ],
    );
  }
}
