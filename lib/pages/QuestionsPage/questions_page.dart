import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Theme.dart';
import '../HomePage/controllers/quiz_page_controller.dart';

class QuestionsPage extends StatelessWidget {
  QuestionsPage({super.key});

  final QuizPageController quizPageController = Get.find<QuizPageController>();

  List<Widget> getRadioTileWidgets(int i) {
    List<Widget> widgetsToReturn = [];
    for (var option in quizPageController
        .modulesAndQuestions[quizPageController.currentModule.value][i]
        .questionOptions) {
      widgetsToReturn.add(Obx(
        () => RadioListTile<String>(
          value: option,
          groupValue: quizPageController.answeredArray[i],
          onChanged: (String? newValue) {
            quizPageController.answeredArray[i] = newValue;
          },
          title: Text(option),
        ),
      ));
    }
    return widgetsToReturn;
  }

  getQuestions(context) {
    List<Widget> widgetsToReturn = [];
    for (int i = 0;
        i <
            quizPageController
                .modulesAndQuestions[quizPageController.currentModule.value]
                .length;
        i++) {
      quizPageController.answeredArray.add('Not Answered');
    }
    for (int i = 0;
        i <
            quizPageController
                .modulesAndQuestions[quizPageController.currentModule.value]
                .length;
        i++) {
      widgetsToReturn.add(
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Question ${i + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  quizPageController
                      .modulesAndQuestions[
                          quizPageController.currentModule.value][i]
                      .questionText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  children: getRadioTileWidgets(i),
                ),
              ],
            ),
          ),
        ),
      );
    }
    widgetsToReturn.add(
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Obx(
            () => ElevatedButton(
              onPressed: quizPageController.submitted.value
                  ? null
                  : () => quizPageController.evaluateQuestionnaire(),
              child: Text('Submit'),
            ),
          ),
        ),
      ),
    );

    widgetsToReturn.add(
      Obx(
        () => quizPageController.submitted.value == false
            ? SizedBox()
            : Card(
                margin: EdgeInsets.all(30),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SCORE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          "${quizPageController.totalPointsForTheCurrentSession.value.toString()}/${quizPageController.totalPointsAttainable.value.toString()}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          quizPageController.passed.value ? "Passed" : "Failed",
                          style: TextStyle(
                            color: quizPageController.passed.value
                                ? Colors.green
                                : Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );

    return widgetsToReturn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Center(
          child: Text(
            'Quiz',
            style: TextStyle(
              color: NowUIColors.black,
            ),
          ),
        ),
        backgroundColor: NowUIColors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: getQuestions(context),
        ),
      ),
    );
  }
}
