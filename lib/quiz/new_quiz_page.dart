import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_app/helpers/app_constants.dart';
import 'package:quiz_app/helpers/dummy_data.dart';
import 'package:quiz_app/helpers/helper_functions.dart';
import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/widgets/form_widgets.dart';

class NewQuizScreen extends StatelessWidget {
  const NewQuizScreen({super.key});

  void handleUserOnPressed(BuildContext context) {
    debugPrint("Create");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: move scaffold or appbar to widgets?
      appBar: AppBar(
        backgroundColor:
            AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
        title: const Text('New Quiz'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => handleUserOnPressed(context),
          )
        ],
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: unimplimentedOnPress,
        icon: const Icon(Icons.add, size: 24),
        label: const Text("QUESTION"),
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
  final List _questions = [Question.fromJson(questionJSON)];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuizTitle(titleController: _titleController),
            Expanded(
              child: Questions(
                questions: _questions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Questions extends StatelessWidget {
  const Questions({
    super.key,
    required this.questions,
  });

  final List questions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Questions",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: questions.length,
          itemBuilder: _questionBuilder,
        ),
      ],
    );
  }

  Widget _questionBuilder(BuildContext context, int index) {
    Question question = questions[index];

    debugPrint(questions[index].text);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(question.text),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: const [
              IconButton(
                onPressed: unimplimentedOnPress,
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: unimplimentedOnPress,
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuizTitle extends StatelessWidget {
  const QuizTitle({
    Key? key,
    required TextEditingController titleController,
  })  : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: "Title",
          border: OutlineInputBorder(),
        ),
        controller: _titleController,
        validator: unimplimentedValidator,
      ),
    );
  }
}
