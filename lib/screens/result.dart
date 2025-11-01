import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/quiz_state.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<QuizState>();
    final total = s.questions.length;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Selamat, ${s.username}!', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Skor kamu: ${s.score} / $total', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () { s.resetAll(); Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false); },
                child: const Text('Main Lagi'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () { s.resetAll(); Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false); },
                child: const Text('Keluar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
