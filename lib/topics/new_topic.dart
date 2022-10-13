import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../helpers/app_constants.dart';
import '../services/firestore.dart';
import '../models/models.dart' as models;

class NewTopicScreen extends StatelessWidget {
  const NewTopicScreen({super.key});

  void handleUserOnPressed(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            AppConstants.hexToColor(AppConstants.appPrimaryColorGreen),
        title: const Text('New Topic'),
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: NewTopicForm(),
        ),
      ),
    );
  }
}

class NewTopicForm extends StatelessWidget {
  NewTopicForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _firestoreService = FirestoreService();

  void handleSubmit(BuildContext context) {
    // TODO: send data to firebase after validation
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Processing data..."),
        ),
      );

      String id =
          _titleController.text.trim().replaceAll(" ", "-").toLowerCase();

      String imageUrl =
          "http://yesofcorsa.com/wp-content/uploads/2015/10/2000_bunny.jpg";

      models.Topic topic =
          models.Topic(title: _titleController.text, id: id, img: imageUrl);
      _firestoreService.createTopic(topic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TitleFormField(controller: _titleController),
          ElevatedButton(
            onPressed: () => handleSubmit(context),
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}

class TitleFormField extends StatelessWidget {
  const TitleFormField({super.key, required this.controller});

  final TextEditingController controller;
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a title";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: const InputDecoration(
        labelText: "Title",
        border: OutlineInputBorder(),
      ),
    );
  }
}
