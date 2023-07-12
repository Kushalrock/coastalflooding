class QuizQuestion {
  String questionText;
  List<String> questionOptions;
  int correctOption;
  int pointsPerQuestion;

  QuizQuestion(
      {required this.questionText,
      required this.questionOptions,
      required this.correctOption,
      this.pointsPerQuestion = 10});
}
