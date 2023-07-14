import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sih2023/models/quiz_question_model.dart';

class QuizPageController extends GetxController {
  var modulesAndQuestions = [
    [
      QuizQuestion(
          questionText: "What causes floods?",
          questionOptions: [
            "Heavy rainfall",
            "High tides",
            "Earthquakes",
            "Volcanic eruptions"
          ],
          correctOption: "Heavy rainfall",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "Which of the following is a natural disaster associated with floods?",
          questionOptions: ["Tornado", "Drought", "Landslide", "Hurricane"],
          correctOption: "Landslide",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText: "What is flash flooding?",
          questionOptions: [
            "Flooding caused by flash photography",
            "Rapid and localized flooding",
            "Flooding in coastal areas",
            "Flooding during winter season"
          ],
          correctOption: "Rapid and localized flooding",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "Which of the following is a measure to prevent flood damage?",
          questionOptions: [
            "Building dams",
            "Clearing forests",
            "Increasing greenhouse gas emissions",
            "Building in flood-prone areas"
          ],
          correctOption: "Building dams",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText: "What should you do during a flood warning?",
          questionOptions: [
            "Evacuate immediately",
            "Go to the rooftop",
            "Stay near the windows",
            "Ignore the warning"
          ],
          correctOption: "Evacuate immediately",
          pointsPerQuestion: 10),
    ],
    [
      QuizQuestion(
          questionText: "What are the primary causes of urban flooding?",
          questionOptions: [
            "Poor drainage systems",
            "Deforestation",
            "Climate change",
            "All of the above"
          ],
          correctOption: "All of the above",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText: "What is a 100-year flood?",
          questionOptions: [
            "A flood that occurs once every 100 years",
            "A flood that has a 1% chance of occurring in any given year",
            "A flood that lasts for 100 years",
            "A flood that affects 100 square miles"
          ],
          correctOption:
              "A flood that has a 1% chance of occurring in any given year",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "What is the most common natural disaster in the United States?",
          questionOptions: ["Tornadoes", "Earthquakes", "Hurricanes", "Floods"],
          correctOption: "Floods",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "What is the term used to describe the overflow of water onto normally dry land?",
          questionOptions: ["Flooding", "Inundation", "Submersion", "Deluge"],
          correctOption: "Flooding",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "Which of the following is a long-term effect of flooding?",
          questionOptions: [
            "Water contamination",
            "Crop destruction",
            "Infrastructure damage",
            "All of the above"
          ],
          correctOption: "All of the above",
          pointsPerQuestion: 10),
    ],
    [
      QuizQuestion(
          questionText: "What is a floodplain?",
          questionOptions: [
            "A plain covered in water",
            "A flat area adjacent to a river or stream that is susceptible to flooding",
            "A man-made channel for diverting floodwaters",
            "An underground water storage facility"
          ],
          correctOption:
              "A flat area adjacent to a river or stream that is susceptible to flooding",
          pointsPerQuestion: 10),
      QuizQuestion(
        questionText:
            "What is the role of the National Weather Service (NWS) during a flood event?",
        questionOptions: [
          "To issue flood warnings and watches",
          "To conduct search and rescue operations",
          "To provide emergency relief supplies",
          "To assess flood damage after the event"
        ],
        correctOption: "To issue flood warnings and watches",
        pointsPerQuestion: 10,
      ),
      QuizQuestion(
          questionText:
              "What is the difference between a flash flood and a river flood?",
          questionOptions: [
            "Flash floods are faster than river floods",
            "Flash floods occur in urban areas, while river floods occur in rural areas",
            "Flash floods are caused by heavy rainfall, while river floods are caused by overflow of rivers",
            "Flash floods are more dangerous than river floods"
          ],
          correctOption:
              "Flash floods are caused by heavy rainfall, while river floods are caused by overflow of rivers",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "What are some common early warning systems for floods?",
          questionOptions: [
            "Sirens",
            "Emergency broadcasts",
            "Mobile phone alerts",
            "All of the above"
          ],
          correctOption: "All of the above",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "What is the most important step in flood preparedness?",
          questionOptions: [
            "Creating an emergency kit",
            "Developing an evacuation plan",
            "Staying informed about weather conditions",
            "Securing your property"
          ],
          correctOption: "Staying informed about weather conditions",
          pointsPerQuestion: 10),
    ],
    [
      QuizQuestion(
          questionText:
              "What is the term for the sudden, localized flooding that occurs within a few hours of intense rainfall?",
          questionOptions: [
            "Flash flood",
            "Torrential flood",
            "Surge flood",
            "Deluge flood"
          ],
          correctOption: "Flash flood",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "Which type of flood occurs when a river or stream exceeds its normal water level and overflows onto the surrounding land?",
          questionOptions: [
            "Riverine flood",
            "Coastal flood",
            "Urban flood",
            "Pluvial flood"
          ],
          correctOption: "Riverine flood",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText: "What is the primary cause of a storm surge?",
          questionOptions: [
            "Strong winds",
            "Heavy rainfall",
            "Tidal waves",
            "Earthquakes"
          ],
          correctOption: "Strong winds",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "Which of the following is an early warning system used for flood detection and monitoring?",
          questionOptions: ["Radar", "Thermometer", "Barometer", "Seismometer"],
          correctOption: "Radar",
          pointsPerQuestion: 10),
      QuizQuestion(
          questionText:
              "What is the term for the process of gradually raising the level of a river or dam to store water?",
          questionOptions: ["Impoundment", "Diversion", "Spillway", "Levee"],
          correctOption: "Impoundment",
          pointsPerQuestion: 10),
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
