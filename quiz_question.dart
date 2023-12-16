class quizQuestion{
  quizQuestion(this.question,this.answers);
  final String question;
  final List<String> answers;

  List<String> getShuffledAnswer(){
    final shuffledanswer= List.of(answers);
    shuffledanswer.shuffle();
    return shuffledanswer;
  }
}


var questions = [
  quizQuestion(
    "What is Flutter primarily used for?",
    [
      'Mobile app development',
      'Game development',
      ' Web development',
      ' Database management'
    ],
  ),
  quizQuestion(
    "Which programming language is Flutter primarily associated with?",
    ['dart', 'java', 'python', 'javascript'],
  ),
  quizQuestion(
    "Which company maintains and develops Flutter?",
    ['google', 'facebook', 'apple', 'microsoft'],
  ),
  quizQuestion(
    "What is Hot Reload in Flutter?",
    [
      'A feature that allows developers to see code changes instantly in the running app',
      'A feature for reheating your lunch',
      'A debugging tool',
      'A method for adding new packages to a Flutter project'
    ],
  ),
  quizQuestion(
    "What is the widget tree in Flutter?",
    [
      'A visual representation of UI elements',
      "A data structure used for networking",
      "A database schema",
      "A form of artificial intelligence"
    ],
  ),
];



// class quizQuestion {
//   quizQuestion(this.question, this.answers);
//
//   final String question;
//   final List<String> answers;
//   List<String> Shuffled_answers(){
//     final shuffledans= List.of(answers);
//     shuffledans.shuffle();
//     return shuffledans;
//   }
// }
//   var questions = [
//     quizQuestion(
//       "What is Flutter primarily used for?",
//       [
//         'Mobile app development',
//         'Game development',
//         ' Web development',
//         ' Database management'
//       ],
//     ),
//     quizQuestion(
//       "Which programming language is Flutter primarily associated with?",
//       ['dart', 'java', 'python', 'javascript'],
//     ),
//     quizQuestion(
//       "Which company maintains and develops Flutter?",
//       ['google', 'facebook', 'apple', 'microsoft'],
//     ),
//     quizQuestion(
//       "What is Hot Reload in Flutter?",
//       [
//         'A feature that allows developers to see code changes instantly in the running app',
//         'A feature for reheating your lunch',
//         'A debugging tool',
//         'A method for adding new packages to a Flutter project'
//       ],
//     ),
//     quizQuestion(
//       "What is the widget tree in Flutter?",
//       [
//         'A visual representation of UI elements',
//         "A data structure used for networking",
//         "A database schema",
//         "A form of artificial intelligence"
//       ],
//     ),
//   ];
//