import 'package:asahotak/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/quiz_state.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizState>();
    final total = quiz.questions.length;
    final benar = quiz.score;
    final salah = total - benar;
    final score100 = (benar / total * 100).round();

    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    // sizing responsif
    final padX = (w * 0.07).clamp(16, 28).toDouble();
    final padY = (h * 0.02).clamp(12, 20).toDouble();
    final gap  = (h * 0.018).clamp(10, 16).toDouble();
    final circle = (w * 0.26).clamp(96, 120).toDouble();
    final cardRadius = 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFF6C9C98),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(padX, padY, padX, padY),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // kartu
                      Container(
                        margin: EdgeInsets.only(top: circle * 0.50),
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                          padX,
                          circle * 0.60,
                          padX,
                          padY * 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(cardRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.12),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('⭐ ', style: TextStyle(fontSize: 18)),
                                Text(
                                  'Kuis selesai !',
                                  style: TextStyle(
                                    fontFamily: 'Baloo2',
                                    fontWeight: FontWeight.w800,
                                    fontSize: (w * 0.06).clamp(18, 22),
                                    color: const Color(0xFF184B48),
                                  ),
                                ),
                                const Text(' ⭐', style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            SizedBox(height: gap * 0.5),

                            Text(
                              'Skor kamu :',
                              style: TextStyle(
                                fontFamily: 'Baloo2',
                                fontWeight: FontWeight.w700,
                                fontSize: (w * 0.04).clamp(13, 16),
                                color: const Color(0xFF56706E),
                              ),
                            ),
                            SizedBox(height: gap * 0.8),

                            //nilai skor, misal 80/100
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '$score100',
                                    style: TextStyle(
                                      fontFamily: 'Baloo2',
                                      fontWeight: FontWeight.w800,
                                      fontSize: (w * 0.12).clamp(36, 42),
                                      color: const Color(0xFF0E6B63),
                                      height: 1.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' / 100',
                                    style: TextStyle(
                                      fontFamily: 'Baloo2',
                                      fontWeight: FontWeight.w600,
                                      fontSize: (w * 0.04).clamp(12, 14),
                                      color: const Color(0xFF8BA8A6),
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: gap),

                            // chip benar & salah
                            Row(
                              children: [
                                Expanded(
                                  child: _StatChip(
                                    title: 'Jawaban benar:',
                                    value: '$benar soal',
                                    bg: const Color(0xFFEAF8F0),
                                    bd: const Color(0xFF36B37E),
                                    txt: const Color(0xFF1B6A67),
                                  ),
                                ),
                                SizedBox(width: gap),
                                Expanded(
                                  child: _StatChip(
                                    title: 'Jawaban salah:',
                                    value: '$salah soal',
                                    bg: const Color(0xFFFFEEEE),
                                    bd: const Color(0xFFE74C3C),
                                    txt: const Color(0xFFB23A2B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // trophy circle
                      Container(
                        height: circle,
                        width: circle,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: circle,
                              width: circle,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              foregroundDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE6F2F1),
                                  width: 3,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF0E6B63),
                                    width: 10,
                                  ),
                                ),
                              ),
                            ),
                            // icon piala
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Image.asset(
                                'assets/images/trophy.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: gap * 1.5),

                  // tombol "Coba lagi"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<QuizState>().resetProgress();
                        context.go(AppRoutes.quiz);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF184B48),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: (h * 0.02).clamp(12, 16)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Coba lagi',
                        style: TextStyle(
                          fontFamily: 'Baloo2',
                          fontWeight: FontWeight.w700,
                          fontSize: (w * 0.045).clamp(14, 18),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: gap * 0.8),

                  // tombol "Kembali ke beranda"
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {
                          context.read<QuizState>().resetProgress();
                          context.go(AppRoutes.home);
                        },
                        style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: (h * 0.02).clamp(12, 16)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Kembali ke beranda',
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
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String title;
  final String value;
  final Color bg, bd, txt;
  const _StatChip({
    required this.title,
    required this.value,
    required this.bg,
    required this.bd,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bd),
        boxShadow: [
          BoxShadow(
            color: bd.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Baloo2',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: txt.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Baloo2',
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: txt,
            ),
          ),
        ],
      ),
    );
  }
}
