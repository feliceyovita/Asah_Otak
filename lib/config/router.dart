import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/welcome.dart';
import '../screens/home.dart';
import '../screens/quiz.dart';
import '../screens/result.dart';
import 'app_routes.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppRoutes.welcome, // halaman pertama
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.quiz,
        builder: (context, state) => const QuizPage(),
      ),
      GoRoute(
        path: AppRoutes.result,
        builder: (context, state) => const ResultPage(),
      ),
    ],

    // kalau rute nggak ditemukan
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text(
          '404 - Halaman tidak ditemukan',
          style: TextStyle(fontSize: 18),
        ),
      ),
    ),
  );
}
