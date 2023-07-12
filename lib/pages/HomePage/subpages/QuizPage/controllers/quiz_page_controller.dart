import 'package:get/get.dart';
import 'package:sih2023/models/quiz_question_model.dart';

class QuizPageController extends GetxController {
  var modulesAndQuestions = [
    [
      QuizQuestion(
        questionText: "Aran ki kab fatne wali hai?",
        questionOptions: ["12-07", "13-07", "14-07", "All of the above"],
        correctOption: 3,
        pointsPerQuestion: 10,
      ),
    ],
  ];

  var totalPointsForTheCurrentSession = 0;

  var passingPointsCriteria = 80;

  var completedModules = [0];
}
