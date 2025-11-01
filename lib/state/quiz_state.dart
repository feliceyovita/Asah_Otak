import 'package:flutter/material.dart';
import '../models/question.dart';
import '../data/question_data.dart';

class QuizState extends ChangeNotifier {
  String _username = '';
  String? _category;
  int _index = 0;          // 0-based
  int _score = 0;

  // Penyimpanan jawaban & status submit per nomor
  List<int?> _selectedPerQ = <int?>[];
  List<bool>  _submittedPerQ = <bool>[];

  // ===== Getters =====
  String get username => _username;
  String? get category => _category;
  int get index => _index;
  int get score => _score;

  List<Question> get questions =>
      QuestionData.byCategory[_category] ?? const [];

  Question get current => questions[_index];

  bool get isFirst => _index == 0;
  bool get isLast  => questions.isEmpty || _index >= questions.length - 1;

  int?  selectedAt(int i)  => (i >= 0 && i < _selectedPerQ.length) ? _selectedPerQ[i] : null;
  bool  submittedAt(int i) => (i >= 0 && i < _submittedPerQ.length) ? _submittedPerQ[i] : false;

  // ===== Mutations =====
  void setUsername(String name) {
    _username = name.trim();
    notifyListeners();
  }

  /// Set kategori & siapkan wadah progres.
  void setCategory(String c, {bool resetScore = true}) {
    _category = c;
    _index = 0;
    if (resetScore) _score = 0;

    final n = questions.length;
    _selectedPerQ = List<int?>.filled(n, null, growable: false);
    _submittedPerQ = List<bool>.filled(n, false, growable: false);
    notifyListeners();
  }

  /// Simpan pilihan user untuk nomor saat ini.
  void select(int optionIndex) {
    if (questions.isEmpty) return;
    _selectedPerQ[_index] = optionIndex;
    notifyListeners();
  }

  /// Menilai jawaban pada nomor saat ini, beri skor jika benar, dan tandai submitted.
  void submitCurrent() {
    if (questions.isEmpty) return;
    if (_submittedPerQ[_index]) return; // sudah dinilai

    final pick = _selectedPerQ[_index];
    if (pick != null && pick == current.correctIndex) {
      _score++;
    }
    _submittedPerQ[_index] = true;
    notifyListeners();
  }

  /// Maju satu soal. Return true jika masih ada soal berikutnya.
  bool next() {
    if (!isLast) {
      _index++;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Kembali satu soal.
  void prev() {
    if (_index > 0) {
      _index--;
      notifyListeners();
    }
  }

  /// Reset total.
  void resetAll() {
    _username = '';
    _category = null;
    _index = 0;
    _score = 0;
    _selectedPerQ = [];
    _submittedPerQ = [];
    notifyListeners();
  }
}
