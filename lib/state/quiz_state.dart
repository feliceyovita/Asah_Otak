import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/question_data.dart';

class QuizState extends ChangeNotifier {
  String _username = '';
  String? _category;
  int _index = 0;
  int _score = 0;

  String get username => _username;
  String? get category => _category;
  int get index => _index;
  int get score => _score;

  // list soal utk kategori aktif
  List<Question> get questions =>
      _category == null ? [] : (QuestionData.byCategory[_category] ?? []);

  // soal saat ini
  Question get current => questions[_index];

  void setUsername(String name) {
    _username = name.trim();
    notifyListeners();
  }

  void setCategory(String cat) {
    _category = cat;
    _index = 0;
    _score = 0;
    notifyListeners();
  }

  void addScore() {
    _score++;
    notifyListeners();
  }

  void nextQuestion() {
    if (_index < questions.length - 1) {
      _index++;
      notifyListeners();
    }
  }

  /// Dipanggil dari quiz.dart:
  /// Menilai jawaban; jika benar tambah skor.
  /// Lalu maju ke soal berikutnya.
  /// Return: `true` masih ada soal berikut, `false` berarti habis.
  bool answer(int selectedIndex) {
    if (selectedIndex == current.correctIndex) {
      _score++;
    }
    return next();
  }

  /// Maju 1 soal. Return `true` jika masih ada soal berikut.
  bool next() {
    final hasNext = _index < questions.length - 1;
    if (hasNext) {
      _index++;
      notifyListeners();
    }
    return hasNext;
  }

  void resetAll() {
    _username = '';
    _category = null;
    _index = 0;
    _score = 0;
    notifyListeners();
  }
}
