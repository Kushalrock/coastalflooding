import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_banners/super_banners.dart';
import '../../controllers/quiz_page_controller.dart';

class QuizPage extends StatefulWidget {
  QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizPageController quizPageController = Get.put(QuizPageController());

  getChildrenWidgets(context) {
    List<Widget> widgetsToReturn = [];
    for (int i = 0; i < quizPageController.modulesAndQuestions.length; i++) {
      widgetsToReturn.add(
        Stack(
          children: [
            Card(
              // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              // Set the clip behavior of the card
              clipBehavior: Clip.antiAliasWithSaveLayer,
              // Define the child widgets of the card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                  Container(
                    color: Colors.blueGrey,
                    height: 160,
                  ),

                  // Add a container with padding that contains the card's title, text, and buttons
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Display the card's title using a font size of 24 and a dark grey color
                        Text(
                          "Module ${i + 1}",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          "Aqua ${quizPageController.levelsArray[i]}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        // Add a space between the title and the text
                        Container(height: 10),
                        // Display the card's text using a font size of 15 and a light grey color
                        Row(
                          children: <Widget>[
                            // Add a spacer to push the buttons to the right side of the card
                            const Spacer(),
                            // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text

                            // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                            Obx(
                              () => TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.transparent,
                                ),
                                child: const Text(
                                  "EXPLORE",
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                                onPressed: quizPageController.loading.value
                                    ? null
                                    : quizPageController.completedModules
                                            .containsKey(i.toString())
                                        ? null
                                        : () {
                                            quizPageController
                                                .currentModule.value = i;
                                            quizPageController.answeredArray
                                                .clear();
                                            quizPageController
                                                .totalPointsForTheCurrentSession
                                                .value = 0;
                                            quizPageController.submitted.value =
                                                false;
                                            quizPageController
                                                .totalPointsAttainable
                                                .value = 0;
                                            quizPageController.passed.value =
                                                true;
                                            Navigator.of(context)
                                                .pushNamed('/quiz');
                                          },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Add a small space between the card and the next widget
                ],
              ),
            ),
            if (quizPageController.completedModules.containsKey(i.toString()))
              CornerBanner(
                bannerColor: Colors.lightBlue,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "PASSED",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        ),
      );
    }
    return widgetsToReturn;
  }

  @override
  void initState() {
    quizPageController.getModules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: getChildrenWidgets(context),
      childAspectRatio: 0.57,
      padding: EdgeInsets.all(10.0),
    );
  }
}
