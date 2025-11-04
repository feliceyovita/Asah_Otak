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
  int? _selected;
  bool _submitted = false;
  int? _lastIndex;

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizState>();
    final List<Question> qs = quiz.questions;
    final int idx = quiz.index;
    final Question q = qs[idx];

    // sinkron tiap ganti nomor
    if (_lastIndex != idx) {
      _lastIndex = idx;
      _selected  = quiz.selectedAt(idx);
      _submitted = quiz.submittedAt(idx);
    }

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final bool isCompact = h < 640 || w < 360;

    // ukuran responsif
    final circleSize = isCompact ? 50.0 : (w * 0.16).clamp(52, 64).toDouble();
    final padX       = (w * 0.07).clamp(16, 30).toDouble();
    final padY       = isCompact ? (h * 0.014).clamp(8, 12).toDouble()
        : (h * 0.02).clamp(10, 16).toDouble();
    final cardRadius = 18.0;
    final optionVPad = (h * 0.018).clamp(12, 16).toDouble();
    final optionHPad = (w * 0.04).clamp(14, 18).toDouble();
    final gap        = isCompact ? 8.0 : (h * 0.016).clamp(8, 14).toDouble();

    // jarak khusus kartu
    final topMargin  = circleSize * 0.50;
    final topPad     = circleSize * 0.75;

    final bool canSubmit = _selected != null && !_submitted;
    final String ctaLabel = !_submitted ? 'Kirim jawaban' : 'Selanjutnya';

    final circleOffset = isCompact ? 7.0 : (w * 0.012).clamp(6, 12).toDouble();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padX, vertical: padY),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  if (idx > 0)
                    Positioned(
                      left: 0,
                      top: -8,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                          foregroundColor: const Color(0xFF006865),
                        ),
                        onPressed: () => context.read<QuizState>().prev(),
                        icon: const Icon(Icons.chevron_left, size: 18),
                        label: Text(
                          'Previous',
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            fontWeight: FontWeight.w600,
                            fontSize: (w * 0.035).clamp(12, 14),
                          ),
                        ),
                      ),
                    ),

                  // kartu pertanyaan
                  Container(
                    margin: EdgeInsets.only(top: topMargin),
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                      padX, topPad, padX, isCompact ? padY * 1.6 : padY * 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA7D3C6), // 🎨 kotak pertanyaan jadi mint pastel (#BFF3E4)
                      borderRadius: BorderRadius.circular(cardRadius),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000), // bayangan lembut (opacity 13%)
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(
                      q.text,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: 'Baloo2',
                        fontWeight: FontWeight.w700,
                        fontSize: (w * 0.05).clamp(16, 20),
                        height:2,
                        color: const Color(0xFF222222),
                      ),
                    ),
                  ),

                  // ===== Bulatan nomor (DITURUNKAN) =====
                  Positioned(
                    top: circleOffset,
                    child: Container(
                      height: circleSize,
                      width: circleSize,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [Color(0xFF1B6A67), Color(0xFF1B6A67), Color(0xFFE6F2F1)],
                          stops: [0.75, 0.75, 1.0],
                        ),
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
                  ),
                ],
              ),

              SizedBox(height: isCompact ? gap * 2 : gap * 2.0),

              // OPSI + FEEDBACK (scrollable)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ...List.generate(q.options.length, (i) {
                      final bool isUserPick   = _selected == i;
                      final bool isCorrectOpt = i == q.correctIndex;
                      final bool showFeedback = _submitted;

                      Color bg;
                      if (showFeedback && isCorrectOpt) {
                        bg = const Color(0xFFE7FAEF);
                      } else if (showFeedback && isUserPick && !isCorrectOpt) {
                        bg = const Color(0xFFFFEEEE);
                      } else {
                        bg = Colors.white;
                      }

                      final Border border = (!showFeedback && isUserPick)
                          ? Border.all(color: const Color(0xFF0E6B63), width: 2)
                          : Border.all(color: Colors.black12, width: 1);

                      return Padding(
                        padding: EdgeInsets.only(bottom: gap),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            if (_submitted) return;
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
                                    color: const Color(0xFF36B37E).withValues(alpha: 0.23),
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

                    if (_submitted) ...[
                      SizedBox(height: gap * 0.5),
                      _FeedbackBar(correct: _selected == q.correctIndex, w: w),
                    ],
                    SizedBox(height: gap * 2),
                  ],
                ),
              ),

              // CTA bawah
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: !_submitted
                      ? (canSubmit ? _submitAnswer : null)
                      : _goNext,
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

  void _submitAnswer() {
    if (_selected == null || _submitted) return;
    final quiz = context.read<QuizState>();
    setState(() => _submitted = true);
    quiz.submitCurrent();
  }

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
            color: bd.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        msg,
        textAlign: TextAlign.center,
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