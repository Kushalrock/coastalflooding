import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sih2023/models/quiz_question_model.dart';

class QuizPageController extends GetxController {
  var modulesAndQuestions = [
    [
      QuizQuestion(
        questionText: "Aran ki kab fatne wali hai?",
        questionOptions: ["12-07", "13-07", "14-07", "All of the above"],
        correctOption: "All of the above",
        pointsPerQuestion: 10,
      ),
    ],
  ];

  var totalPointsForTheCurrentSession = 0.obs;

  var passingPointsCriteria = 8;

  var completedModules = {}.obs;

  var levelsArray = ["Novice", "Competent", "Experienced", "Master"];

  var currentModule = 0.obs;

  var answeredArray = [].obs;

  var submitted = false.obs;

  var passed = true.obs;

  var totalPointsAttainable = 0.obs;

  var loading = false.obs;

  Future<void> evaluateQuestionnaire() async {
    for (int i = 0; i < modulesAndQuestions[currentModule.value].length; i++) {
      if (modulesAndQuestions[currentModule.value][i].correctOption ==
          answeredArray[i]) {
        totalPointsForTheCurrentSession.value +=
            modulesAndQuestions[currentModule.value][i].pointsPerQuestion;
      }
      totalPointsAttainable.value +=
          modulesAndQuestions[currentModule.value][i].pointsPerQuestion;
    }
    if (totalPointsForTheCurrentSession.value < passingPointsCriteria) {
      passed.value = false;
    } else {
      completedModules.value[currentModule.value.toString()] =
          totalPointsForTheCurrentSession.value;
    }
    submitted.value = true;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({"completed_modules": completedModules.value},
            SetOptions(merge: true));
  }

  getModules() async {
    loading.value = true;
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    if (data.data() != null) {
      completedModules.value = data.data()!["completed_modules"];
    }
    loading.value = false;
  }
}
