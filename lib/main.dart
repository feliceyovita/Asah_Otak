import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'config/router.dart';
import 'state/quiz_state.dart';

void main() {
  final GoRouter router = createRouter();
  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          fontFamily: 'Baloo2',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E6B63)),
          useMaterial3: true,
        ),
      ),
    );
  }
}