import 'package:flutter/foundation.dart';
import 'package:quiz_app/helpers/dummy_data.dart';
import 'package:quiz_app/models/models.dart';

class NewQuizState with ChangeNotifier {
  String? _title;
  final List<Question> _questions = [
    Question.fromJson(question1JSON),
    Question.fromJson(question2JSON)
  ];

  String? get title => _title;
  List<Question?> get questions => _questions;

  set title(newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void addQuestion(Question question) {
    _questions.add(question);
  }
}
