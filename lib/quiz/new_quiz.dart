import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/helpers/app_constants.dart';
import 'package:quiz_app/widgets/form_widgets.dart';

class NewQuizScreen extends StatelessWidget {
  const NewQuizScreen({super.key});

  void handleUserOnPressed(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: move scaffold or appbar to widgets
      appBar: AppBar(
        backgroundColor:
            AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
        title: const Text('New Quiz'),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.circleUser,
              color: AppConstants.hexToColor(AppConstants.appPrimaryColorLight),
            ),
            onPressed: () => handleUserOnPressed(context),
          )
        ],
      ),
      body: SafeArea(
        child: NewQuizForm(),
      ),
    );
  }
}

class NewQuizForm extends StatelessWidget {
  NewQuizForm({super.key});

  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleFormField(controller: _titleController),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.teal)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Questions go here"),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red.shade300)),
                    child: const Text("Options go here"),
                  ),
                ],
              ),
            ),
          ),
          CreateButton(onSubmit: () => debugPrint("whoop!"))
        ],
      ),
    );
  }
}
