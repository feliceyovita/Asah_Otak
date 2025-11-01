import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String text;
  const QuestionCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: theme.textTheme.titleLarge),
      ),
    );
  }
}
