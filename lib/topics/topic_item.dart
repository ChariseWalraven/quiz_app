import 'package:flutter/material.dart';

import '../helpers/app_constants.dart';
import '../models/models.dart';
import '../services/firestore.dart';
import '../shared/progress_bar.dart';
import 'drawer.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      'assets/covers/${topic.img}',
      width: MediaQuery.of(context).size.width,
    );
    if (topic.img.startsWith("http")) {
      image = Image.network(
        topic.img,
        width: MediaQuery.of(context).size.width,
      );
    }
    return Hero(
      tag: topic.img,
      child: Card(
        color: AppConstants.hexToColor(AppConstants.appPrimaryColorGreenLight),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => TopicScreen(topic: topic),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: image,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              Flexible(child: TopicProgress(topic: topic)),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatefulWidget {
  final Topic topic;

  const TopicScreen({super.key, required this.topic});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
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

  void handleCreateQuiz(BuildContext context) {
    debugPrint("create quiz presed");
    if (isAdmin) {
      Navigator.pushNamed(context, "/new_quiz");
    } else {
      debugPrint(
          "Whoops. not an admin. Somehow the user can see and press the add quiz button");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget heroChild = Image.asset(
      'assets/covers/${widget.topic.img}',
      width: MediaQuery.of(context).size.width,
    );
    if (widget.topic.img.startsWith("http")) {
      heroChild = Image.network(
        widget.topic.img,
        width: MediaQuery.of(context).size.width,
      );
    }
    return Scaffold(
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () => handleCreateQuiz(context),
              child: const Icon(Icons.add))
          : Container(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: widget.topic.img,
          child: heroChild,
        ),
        Text(
          widget.topic.title,
          style: const TextStyle(
              height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        QuizList(topic: widget.topic)
      ]),
    );
  }
}
