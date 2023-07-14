import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih2023/pages/AlertsPage/alerts_page.dart';
import 'package:sih2023/pages/HeatMap/heat_map_page.dart';
import 'package:sih2023/pages/HomePage/home_page.dart';
import 'package:sih2023/pages/HomePage/subpages/QuizPage/quiz_page.dart';
import 'package:sih2023/pages/PostPage/post_page.dart';
import 'package:sih2023/pages/QuestionsPage/questions_page.dart';
import 'package:sih2023/pages/RegistrationPage/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaSol',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) =>
            FirebaseAuth.instance.currentUser != null ? HomePage() : Register(),
        '/home': (context) => const HomePage(),
        '/quiz': (context) => QuestionsPage(),
        '/post': (context) => PostPage(),
        '/heatmap': (context) => HeatMapPage(),
        '/alert': (context) => AlertsPage(),
      },
    );
  }
}
