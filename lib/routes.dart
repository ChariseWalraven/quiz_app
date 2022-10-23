import 'package:quiz_app/quiz/new_quiz_page.dart';
import 'package:quiz_app/topics/new_topic.dart';

import '/about/about.dart';
import '/profile/profile.dart';
import '/login/login.dart';
import '/topics/topics.dart';
import '/home/home.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
  '/new_topic': (context) => const NewTopicScreen(),
  '/new_quiz': (context) => const NewQuizScreen(),
};
