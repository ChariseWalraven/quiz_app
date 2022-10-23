import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/helpers/app_constants.dart';
import 'package:quiz_app/models/models.dart';
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
      body: const SafeArea(
        child: NewQuizForm(),
      ),
    );
  }
}

class NewQuizForm extends StatefulWidget {
  const NewQuizForm({super.key});

  @override
  State<NewQuizForm> createState() => _NewQuizFormState();
}

class _NewQuizFormState extends State<NewQuizForm> {
  final _titleController = TextEditingController();
  final List _questions = [Question.fromJson(_questionJSON)];

  void _unimplimentedOnPress() {
    throw UnimplementedError("OnPress Unimplimented!");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextInput(
            label: "Quiz Title",
            controller: _titleController,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.teal),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _questions.length,
                    itemBuilder: _questionBuilder,
                  ),
                  ElevatedButton(
                    onPressed: _unimplimentedOnPress,
                    child: const Text("Add question"),
                  ),
                ],
              ),
            ),
          ),
          CreateButton(onSubmit: _unimplimentedOnPress)
        ],
      ),
    );
  }

  Widget _questionBuilder(BuildContext context, int index) {
    Question question = _questions[index];

    debugPrint(_questions[index].text);

    Widget optionBuilder(context, index) {
      Option option = question.options[index];
      return TextInput();
    }

    return Column(
      children: [
        Text(question.text),
        ListView.builder(
          shrinkWrap: true,
          itemCount: question.options.length,
          itemBuilder: optionBuilder,
        ),
        ElevatedButton(
          onPressed: _unimplimentedOnPress,
          child: const Text("Add option"),
        ),
      ],
    );
  }
}

class TextInput extends StatelessWidget {
  TextInput({
    super.key,
    this.controller,
    this.label,
  });

  final TextEditingController _defaultController = TextEditingController();
  final TextEditingController? controller;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label ?? "",
      ),
      controller: controller ?? _defaultController,
      validator: _unimplimentedValidator,
    );
  }
}

String? _unimplimentedValidator(String? inputValue) {
  debugPrint("User entered: $inputValue");
  return "this validator has not been implemented";
}

// JSON dummy data
const _questionJSON = {
  'text': 'Question 1',
  'options': [
    {'value': 'Option 1', 'correct': true, 'details': 'Some details'},
    {'value': 'Option 2', 'correct': false, 'details': 'Some other details'},
    {'value': 'Option 3'},
  ],
};
