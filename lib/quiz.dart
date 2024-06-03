import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  List<String> selectedAnswer = [];
  var activeScreen = "start_screen";

  // kondisi mengunakan initstate (1)
  // Widget? activeScreen;

  // @override
  // void initState() {
  //   activeScreen = StartScreen(startQuiz: switchScreen);
  //   super.initState();
  // }

  void switchScreen() { // function untuk mengubah screen
    setState(() {
      activeScreen = "questions_screen";
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        // selectedAnswer = [];
        activeScreen = "result_screen";
      });
    }
  }

  void restartQuiz() {
    setState(() {
      activeScreen = "questions_screen";
      selectedAnswer = [];
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget screenWidget = StartScreen(startQuiz: switchScreen);

    // kondisi menggunakan if (3)
    if (activeScreen == "questions_screen") {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    }

    if (activeScreen == "result_screen") {
      screenWidget = ResultScreen(
        chosenAnswer: selectedAnswer,
        onRestart: () {
          restartQuiz();
        },
      );
    }

    return MaterialApp(
      title: "Quiz App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF320C88),
                      Color(0xFF5B00A8)
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight
                )
            ),
            child: screenWidget,
            // kondisi menggunakan ternary expression (2)
            // chield: activeScreen == "start-screen"
            //     ? StartScreen(startQuiz: switchScreen) // true
            //     : const QuestionsScreen(), // false

        ),
      ),
    );
  }
}
