import 'package:asahotak/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/quiz_state.dart';
import '../models/question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int? _selected;          // pilihan lokal untuk nomor aktif
  bool _submitted = false; // sudah submit (tampilkan feedback)
  int? _lastIndex;         // bantu sinkron saat pindah nomor

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizState>();
    final List<Question> qs = quiz.questions;
    final int idx = quiz.index;
    final Question q = qs[idx];

    // Sinkronkan state lokal setiap kali nomor berubah
    if (_lastIndex != idx) {
      _lastIndex = idx;
      _selected  = quiz.selectedAt(idx);
      _submitted = quiz.submittedAt(idx);
    }

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    // Sizing dinamis (anti hard-code)
    final circleSize  = (w * 0.16).clamp(52, 64).toDouble();
    final padX        = (w * 0.06).clamp(16, 24).toDouble();
    final padY        = (h * 0.02).clamp(10, 16).toDouble();
    final cardRadius  = 18.0;
    final optionVPad  = (h * 0.018).clamp(12, 16).toDouble();
    final optionHPad  = (w * 0.04).clamp(14, 18).toDouble();
    final gap         = (h * 0.016).clamp(8, 14).toDouble();

    final bool canSubmit = _selected != null && !_submitted;
    final String ctaLabel = !_submitted ? 'Kirim jawaban' : 'Next';

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padX, vertical: padY),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bar atas: Previous (muncul mulai nomor 2)
              Row(
                children: [
                  if (idx > 0)
                    TextButton.icon(
                      onPressed: () {
                        context.read<QuizState>().prev();
                        // _selected/_submitted akan tersinkron di atas (cek _lastIndex)
                      },
                      icon: const Icon(Icons.chevron_left, size: 18),
                      label: Text(
                        'Previous',
                        style: TextStyle(
                          fontFamily: 'Baloo2',
                          fontWeight: FontWeight.w600,
                          fontSize: (w * 0.035).clamp(12, 14),
                          color: const Color(0xFF006865),
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 20),
                ],
              ),

              SizedBox(height: gap),

              // Kartu pertanyaan + bulatan nomor
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Kartu pertanyaan
                  Container(
                    margin: EdgeInsets.only(top: circleSize * 0.50),
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                      padX, circleSize * 0.8, padX, padY * 2.2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(cardRadius),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x1A000000), // ~opacity 0.10
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Text(
                      q.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Baloo2',
                        fontWeight: FontWeight.w700,
                        fontSize: (w * 0.05).clamp(16, 20),
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ),

                  // Bulatan nomor
                  Container(
                    height: circleSize,
                    width: circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const SweepGradient(
                        colors: [Color(0xFF1B6A67), Color(0xFF1B6A67), Color(0xFFE6F2F1)],
                        stops: [0.75, 0.75, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x1F000000), // ~opacity 0.12
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        height: circleSize * 0.78,
                        width: circleSize * 0.78,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${idx + 1}',
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            fontWeight: FontWeight.w800,
                            fontSize: (w * 0.06).clamp(16, 22),
                            color: const Color(0xFF1B6A67),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: gap * 1.2),

              // Daftar opsi
              ...List.generate(q.options.length, (i) {
                final bool isUserPick   = _selected == i;
                final bool isCorrectOpt = i == q.correctIndex;
                final bool showFeedback = _submitted;

                // Background saat feedback
                Color bg;
                if (showFeedback && isCorrectOpt) {
                  bg = const Color(0xFFE7FAEF); // benar → hijau lembut
                } else if (showFeedback && isUserPick && !isCorrectOpt) {
                  bg = const Color(0xFFFFEEEE); // pilihan user salah → merah lembut
                } else {
                  bg = Colors.white;            // sebelum submit
                }

                // Border (stroke saat memilih sebelum submit)
                final Border border = (!showFeedback && isUserPick)
                    ? Border.all(color: const Color(0xFF0E6B63), width: 2)
                    : Border.all(color: Colors.black12, width: 1);

                return Padding(
                  padding: EdgeInsets.only(bottom: gap),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      if (_submitted) return;      // setelah kirim jawaban, opsi terkunci
                      setState(() => _selected = i);
                      context.read<QuizState>().select(i);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: optionVPad, horizontal: optionHPad,
                      ),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(14),
                        border: border,
                        boxShadow: [
                          if (showFeedback && isCorrectOpt)
                            BoxShadow(
                              color: const Color(0x3A36B37E), // ~opacity 0.23
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              q.options[i],
                              style: TextStyle(
                                fontFamily: 'Baloo2',
                                fontSize: (w * 0.045).clamp(14, 18),
                                fontWeight: showFeedback && isCorrectOpt
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                color: const Color(0xFF222222),
                              ),
                            ),
                          ),
                          if (!showFeedback)
                            _Dot(selected: isUserPick)
                          else if (isCorrectOpt)
                            const Icon(Icons.check_circle, color: Color(0xFF2BB673))
                          else if (isUserPick && !isCorrectOpt)
                              const Icon(Icons.cancel_rounded, color: Color(0xFFE74C3C))
                            else
                              const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              // Feedback bar (muncul setelah submit)
              if (_submitted) ...[
                SizedBox(height: gap * 0.5),
                _FeedbackBar(
                  correct: _selected == q.correctIndex,
                  w: w,
                ),
              ],

              const Spacer(),

              // ===== Tombol bawah (Kirim jawaban / Next) =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: !_submitted
                      ? (canSubmit ? _submitAnswer : null) // kirim jawaban
                      : _goNext,                           // lanjut ke soal berikutnya
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E6B63),
                    disabledBackgroundColor: const Color(0xFF9FB7B5),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: (h * 0.02).clamp(12, 16),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    ctaLabel,
                    style: TextStyle(
                      fontFamily: 'Baloo2',
                      fontWeight: FontWeight.w700,
                      fontSize: (w * 0.045).clamp(14, 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Saat user menekan "Kirim jawaban"
  void _submitAnswer() {
    if (_selected == null || _submitted) return;
    final quiz = context.read<QuizState>();
    setState(() => _submitted = true);
    quiz.submitCurrent(); // nilai & tambah skor jika benar (logika di QuizState)
  }

  // Saat user menekan "Next"
  void _goNext() {
    final quiz = context.read<QuizState>();
    final hasNext = quiz.next();
    if (hasNext) {
      setState(() {
        _selected  = quiz.selectedAt(quiz.index);
        _submitted = quiz.submittedAt(quiz.index);
        _lastIndex = quiz.index;
      });
    } else {
      context.go(AppRoutes.result);
    }
  }
}

// Radio-like sebelum submit
class _Dot extends StatelessWidget {
  final bool selected;
  const _Dot({required this.selected});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final outer = (w * 0.065).clamp(18, 24).toDouble();
    final inner = outer * 0.55;
    return Container(
      height: outer,
      width: outer,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? const Color(0xFF0E6B63) : Colors.black26,
          width: selected ? 2 : 1,
        ),
      ),
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: selected ? inner : 0,
        width: selected ? inner : 0,
        decoration: const BoxDecoration(
          color: Color(0xFF0E6B63),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// Bar feedback hijau/merah
class _FeedbackBar extends StatelessWidget {
  final bool correct;
  final double w;
  const _FeedbackBar({required this.correct, required this.w});

  @override
  Widget build(BuildContext context) {
    final bg = correct ? const Color(0xFFE7FAEF) : const Color(0xFFFFEEEE);
    final bd = correct ? const Color(0xFF36B37E) : const Color(0xFFE74C3C);
    final tx = correct ? const Color(0xFF1B6A67) : const Color(0xFFB23A2B);
    final msg = correct ? 'Benar, kamu hebat! 🎉' : 'Salah, jangan menyerah! 💪🏻';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: (w * 0.035).clamp(10, 14)),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bd),
        boxShadow: [
          BoxShadow(
            color: bd.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        msg,
        style: TextStyle(
          fontFamily: 'Baloo2',
          fontWeight: FontWeight.w700,
          fontSize: (w * 0.045).clamp(14, 18),
          color: tx,
        ),
      ),
    );
  }
}
