import "package:flutter/material.dart";
import 'package:learn_flutter/answers.dart';
import 'package:learn_flutter/question.dart';
import 'package:learn_flutter/questionCounter.dart';
import 'package:learn_flutter/result.dart';

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
  var questions = [
    {
      "question": "1 + 1",
      "answers": [1, 2, 3, 4],
      "correctAnswer": 2
    },
    {
      "question": "2 + 2",
      "answers": [2, 3, 4, 5],
      "correctAnswer": 4
    },
    {
      "question": "3 + 3",
      "answers": [3, 4, 5, 6],
      "correctAnswer": 6
    },
  ];

  int _questionsIndex = 0;
  int yourScore = 0;
  bool endOfQuiz = false;

  void answerQuestion(int pickedAnswer) {
    int currentCorrectAnswer =
        questions[_questionsIndex]["correctAnswer"] as int;
    setState(() {
      if (pickedAnswer == currentCorrectAnswer) {
        yourScore++;
      }
      if (_questionsIndex < questions.length - 1) {
        _questionsIndex++;
      } else {
        endOfQuiz = true;
      }
    });
  }

  void resetQuiz() {
    setState(() {
      _questionsIndex = 0;
      yourScore = 0;
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My Quiz App')),
        body: endOfQuiz
            ? Result(
                totalScore: questions.length,
                yourScore: yourScore,
                resetQuiz: resetQuiz,
              )
            : Column(children: [
                QuestionCounter(
                    total: questions.length, currentIndex: _questionsIndex + 1),
                Question(questions[_questionsIndex]["question"] as String),
                Answers(
                  answers: questions[_questionsIndex]["answers"] as List<int>,
                  pickAnswer: answerQuestion,
                )
              ]),
      ),
    );
  }
}
