import 'package:flutter/material.dart';
import 'quiz_app/quiz_question.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});
  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  String cscreen = "start-screen";
  List<String> SelectedAnswer = [];
  void changescreen() {
    setState(() {
      cscreen = "question-screen";
    });
  }

  void ChoosenAnswer(String canswer) {
    SelectedAnswer.add(canswer);
    if (SelectedAnswer.length == questions.length) {
      setState(() {
        cscreen = "result-screen";
      });
    }
  }

  void RestartQuiz() {
    setState(() {
      cscreen = "start-screen";
      SelectedAnswer.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget cwidget = Startscreen(changescreen);
    if (cscreen == "question-screen") {
      cwidget = Questionscreen(
        onSelectAnswer: ChoosenAnswer,
      );
    }
    if (cscreen == "result-screen") {
      cwidget = ResultScreen(
        chanswer: SelectedAnswer,
        restartquiz:
            RestartQuiz, //if i write chanser=[] in place of this the error is gone but the app won't store the the list of selected anser.
      );
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz App ",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.deepPurple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: cwidget,
        ),
      ),
    );
  }
}

class Startscreen extends StatefulWidget {
  final void Function() changescreens;

  const Startscreen(this.changescreens, {super.key});

  @override
  State<Startscreen> createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("assets/f.png"),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Learn Flutter the fun Way",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.start),
            onPressed: widget.changescreens,
            label: const Text("Start Quiz"),
          ),
        ],
      ),
    );
  }
}

class Questionscreen extends StatefulWidget {
  const Questionscreen({required this.onSelectAnswer, super.key});
  final void Function(String ans) onSelectAnswer;

  @override
  State<Questionscreen> createState() => _QuestionscreenState();
}

class _QuestionscreenState extends State<Questionscreen> {
  var questionIndex = 0;
  void answerQuestion(String answers) {
    widget.onSelectAnswer(answers);
    setState(() {
      questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentquestion = questions[questionIndex];
    return Container(
      margin: EdgeInsets.all(40),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentquestion.question,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ...currentquestion.getShuffledAnswer().map((e) {
              return Questionbutton(
                questions: e,
                ontap: () {
                  answerQuestion(e);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}

class Questionbutton extends StatelessWidget {
  const Questionbutton(
      {required this.questions, required this.ontap, super.key});
  final String questions;
  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: ontap,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              questions,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  ResultScreen({required this.chanswer, required this.restartquiz, super.key});
  List<String> chanswer;
  final void Function() restartquiz;
  List<Map<String, Object>> getSummary() {
    List<Map<String, Object>> summary = [];
    for (var i = 0; i < chanswer.length; i++) {
      summary.add(
        {
          "question_index": i,
          "question": questions[i].question,
          "user_answer": chanswer[i],
          "correct_answer": questions[i].answers[0],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummary();
    final numQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((element) {
      return element['user_answer'] == element['correct_answer'];
    }).length;
    return Center(
      child: SizedBox(
        height: 550,
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 10, 20),
                child: Text(
                  "You answered $numCorrectQuestions out of $numQuestions question correctly!",
                  style: TextStyle(
                      color: Colors.blue[1000],
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Expanded(
                child: QuestionSummary(
                  summaryData,
                ),
              ),
              const SizedBox(height: 50,),
              TextButton(
                onPressed: restartquiz,
                child: const Text(
                  "Restart Quiz",
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.qsummary, {super.key});
  final List<Map<String, Object>> qsummary;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: qsummary.map(
          (data) {
            bool isCorrect = data['user_answer'] == data['correct_answer'];
            Color textColor =
                isCorrect ? Colors.greenAccent : Colors.pinkAccent;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: textColor,
                    ),
                    child: Text(
                      ((data['question_index'] as int) + 1).toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 26),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          data['question'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Your Answer: ${data['user_answer']}',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Correct Answer: ${data['correct_answer']}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class quizQuestion {
  quizQuestion(this.question, this.answers);
  final String question;
  final List<String> answers;

  List<String> getShuffledAnswer() {
    final shuffledanswer = List.of(answers);
    shuffledanswer.shuffle();
    return shuffledanswer;
  }
}
