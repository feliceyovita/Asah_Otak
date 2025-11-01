import 'package:asahotak/config/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/quiz_state.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _c = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final logoRadius = (w * 0.12).clamp(44, 64).toDouble();
    final fieldSpacing = (h * 0.02).clamp(12, 24).toDouble();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF006865),
              Color(0xFF00ACA5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.25, 0.82],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // LOGO
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: logoRadius * 3,
                          height: logoRadius * 3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: fieldSpacing * 1.2),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Masukkan nama anda',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontFamily: 'Baloo2',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: fieldSpacing * 0.8),

                    // TEXTFIELD
                    TextField
                      (
                      controller: _c,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Nama anda...',
                        hintStyle: const TextStyle(fontFamily: 'Baloo2'),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      onChanged: (value) {
                        setState(() => _isButtonEnabled = value.trim().isNotEmpty);
                      },
                      onSubmitted: (_) => _go(),
                    ),

                    SizedBox(height: fieldSpacing * 1.2),

                    // BUTTON – selebar kolom, kuning solid aktif, 70% transparan saat kosong
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isButtonEnabled
                              ? const Color(0xFFFFB214)                   // aktif
                              : const Color(0xFFF8C043).withOpacity(0.7), // “disabled look”
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        // gunakan callback kosong agar warna tidak di-override jadi abu-abu
                        onPressed: _isButtonEnabled ? _go : () {},
                        child: const Text(
                          'Mulai kuis!',
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: fieldSpacing), // dorong sedikit ke bawah
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _go() {
    final name = _c.text.trim();
    if (name.isEmpty) return;
    context.read<QuizState>().setUsername(name);
    context.go(AppRoutes.home);
  }
}