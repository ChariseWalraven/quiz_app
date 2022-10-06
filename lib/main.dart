import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/services/firestore.dart';
import 'package:quiz_app/theme.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'models/models.dart';
import 'shared/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      Provider<AuthService>(create: (_) => AuthService()),
      Provider<Report>(create: (context) => Report()),
    ],
    child: const QuizApp(),
  ));
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize firebase:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // TODO: Error screen
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider(
            create: (_) => FirestoreService().streamReport(),
            catchError: (_, err) => Report(),
            initialData: Report(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: appRoutes,
              theme: appTheme,
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(home: LoadingScreen());
      },
    );
  }
}
