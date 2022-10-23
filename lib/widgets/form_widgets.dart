import 'package:flutter/material.dart';
import 'package:quiz_app/helpers/helper_functions.dart';

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

class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField({
    super.key,
    this.onEditingComplete,
    this.controller,
    this.label,
    this.hintText,
    this.trailingIcon,
  });

  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final String? label;
  final String? hintText;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            hintText: hintText,
            suffixIcon: trailingIcon),
        controller: controller ?? TextEditingController(),
        onEditingComplete: onEditingComplete,
        validator: unimplimentedValidator,
      ),
    );
  }
}
