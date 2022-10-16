import 'package:flutter/material.dart';

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

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
    required this.onSubmit,
  });

  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSubmit,
      child: const Text("Create"),
    );
  }
}
