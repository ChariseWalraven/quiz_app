import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../helpers/app_constants.dart';
import '../services/firestore.dart';
import '../models/models.dart';
import '../shared/shared.dart';
import 'drawer.dart';
import 'topic_item.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    checkUserRoles();
  }

  void checkUserRoles() async {
    var userRoles = await FirestoreService().getUserRoles();
    setState(() {
      isAdmin = userRoles.isAdmin;
    });
  }

  void handleCreateTopic(BuildContext context) {
    debugPrint("create topic presed");
    if (isAdmin) {
      Navigator.pushNamed(context, "/new_topic");
    } else {
      debugPrint(
          "Whoops. not an admin. Somehow the user can see and press the add topics button");
    }
  }

  void handleUserOnPressed(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return Scaffold(
            floatingActionButton: isAdmin
                // ignore: dead_code
                ? FloatingActionButton(
                    onPressed: () => handleCreateTopic(context),
                    child: const Icon(Icons.add))
                : Container(),
            appBar: AppBar(
              backgroundColor:
                  AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
              title: const Text('Topics'),
              actions: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.circleUser,
                    color: AppConstants.hexToColor(
                        AppConstants.appPrimaryColorLight),
                  ),
                  onPressed: () => handleUserOnPressed(context),
                )
              ],
            ),
            drawer: TopicDrawer(topics: topics),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}
