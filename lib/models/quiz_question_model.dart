class QuizQuestion {
  String questionText;
  List<String> questionOptions;
  String correctOption;
  int pointsPerQuestion;

  QuizQuestion(
      {required this.questionText,
      required this.questionOptions,
      required this.correctOption,
      this.pointsPerQuestion = 10});
}
