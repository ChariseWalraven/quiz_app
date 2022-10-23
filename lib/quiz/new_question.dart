import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/helpers/app_constants.dart';
import 'package:quiz_app/helpers/helper_functions.dart';
import 'package:quiz_app/quiz/new_quiz_state.dart';
import 'package:quiz_app/widgets/form_widgets.dart';
import 'package:quiz_app/models/models.dart';

class NewQuestionScreen extends StatelessWidget {
  const NewQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewQuizState(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
          title: const Text('New Quiz'),
          actions: const [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: unimplimentedOnPress,
            )
          ],
        ),
        body: const SafeArea(
          child: NewQuestionSheet(),
        ),
      ),
    );
  }
}

class NewQuestionSheet extends StatefulWidget {
  const NewQuestionSheet({super.key});

  @override
  State<NewQuestionSheet> createState() => _NewQuestionSheetState();
}

class _NewQuestionSheetState extends State<NewQuestionSheet> {
  final List options = [];
  final TextEditingController _newOptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Question question = Question();

  void addOption() {
    debugPrint("Adding option");
    var optionJSON = {
      'value': _newOptionController.text,
    };
    Option option = Option.fromJson(optionJSON);

    setState(() {
      options.add(option);
    });

    _newOptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const OutlinedTextField(
            label: "Question",
            hintText: "Enter question",
          ),
          if (options.isEmpty)
            const Text(
                "Hmm, looks like there are no options for this question yet."),
          if (options.isNotEmpty)
            ListView.builder(
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: _optionsBuilder),
          OutlinedTextField(
            controller: _newOptionController,
            hintText: "Add an option",
            onEditingComplete: addOption,
          ),
        ],
      ),
    );
  }

  Widget _optionsBuilder(context, index) {
    // NewQuizState state = Provider.of(context);
    Option option = options[index];
    return OptionItem(option: option);
  }
}

class OptionItem extends StatelessWidget {
  const OptionItem({
    Key? key,
    required this.option,
  }) : super(key: key);

  final Option option;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(option.value),
        // TODO: get this working...somehow
        Checkbox(
          value: option.correct,
          onChanged: (value) {},
        ),
        const IconButton(
          onPressed: unimplimentedOnPress,
          icon: Icon(
            Icons.remove_circle_outline,
          ),
        )
      ],
    );
  }
}
