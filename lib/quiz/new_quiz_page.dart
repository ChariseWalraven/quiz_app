import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/helpers/app_constants.dart';
import 'package:quiz_app/helpers/dummy_data.dart';
import 'package:quiz_app/helpers/helper_functions.dart';
import 'package:quiz_app/models/models.dart';
import 'package:quiz_app/quiz/new_question.dart';
import 'package:quiz_app/quiz/new_quiz_state.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/widgets/form_widgets.dart';

class NewQuizScreen extends StatelessWidget {
  NewQuizScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  void handleSubmit(BuildContext context) {
    debugPrint("Submit pressed.");
    if (_formKey.currentState!.validate()) {
      debugPrint("Form valid, need to send data to firebase.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewQuizState(),
      child: Scaffold(
        // TODO: move scaffold or appbar to widgets?
        appBar: AppBar(
          backgroundColor:
              AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
          title: const Text('New Quiz'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => handleSubmit(context),
            )
          ],
        ),
        floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/new_question');
          },
          icon: const Icon(Icons.add, size: 24),
          label: const Text("QUESTION"),
        ),
        body: SafeArea(
          child: NewQuizForm(formKey: _formKey),
        ),
      ),
    );
  }
}

// Handle getting user input and setting state here
class NewQuizForm extends StatelessWidget {
  NewQuizForm({
    super.key,
    required this.formKey,
  });

  final _titleController = TextEditingController();
  final GlobalKey<FormState> formKey;

  void handleEditingComplete(NewQuizState state) {
    debugPrint("setting title: ${_titleController.text}");
    // set title
    state.title = _titleController.text;
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    NewQuizState state = Provider.of<NewQuizState>(context);
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedTextField(
              label: "Title",
              hintText: "Enter quiz title",
              controller: _titleController,
              onEditingComplete: () => handleEditingComplete(state),
            ),
            const Expanded(
              child: Questions(),
            ),
          ],
        ),
      ),
    );
  }
}

class Questions extends StatelessWidget {
  const Questions({super.key});

  @override
  Widget build(BuildContext context) {
    final List questions = Provider.of<NewQuizState>(context).questions;
    // NewQuizState state = Provider.of<NewQuizState>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Questions",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (questions.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("No questions yet..."),
          ),
        if (questions.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: questions.length,
            itemBuilder: _questionBuilder,
          ),
      ],
    );
  }

  Widget _questionBuilder(BuildContext context, int index) {
    Question? question = Provider.of<NewQuizState>(context).questions[index];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(question?.text ?? ""),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: const [
              // IconButton(
              //   onPressed: unimplimentedOnPress,
              //   icon: Icon(Icons.edit),
              // ),
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
