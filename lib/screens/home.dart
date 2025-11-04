import 'package:asahotak/config/app_routes.dart';
import 'package:asahotak/widgets/confirm_start.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/quiz_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuizState>();

    final size        = MediaQuery.of(context).size;
    final w           = size.width;
    final h           = size.height;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // spacing responsif
    final padX   = (w * 0.07).clamp(12, 28).toDouble();
    final padY   = (h * 0.01).clamp(8,  20).toDouble();
    final headerH = (isLandscape ? 0.16 : 0.20) * h; // header lebih tipis saat landscape

    final categories = [
      {'title': 'Matematika',      'image': 'assets/images/math.png'},
      {'title': 'IPA',             'image': 'assets/images/science.png'},
      {'title': 'Bahasa Inggris',  'image': 'assets/images/english.png'},
      {'title': 'Geografi',        'image': 'assets/images/geography.png'},
      {'title': 'Sejarah',         'image': 'assets/images/history.png'},
      {'title': 'Budaya & Seni',   'image': 'assets/images/art.png'},
      {'title': 'Kuliner Dunia',   'image': 'assets/images/food.png'},
      {'title': 'Olahraga',        'image': 'assets/images/sport.png'},
    ];

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size        = MediaQuery.of(context).size;
            final w           = size.width;
            final h           = size.height;
            final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

            final padX    = (w * 0.07).clamp(12, 28).toDouble();
            final padY    = (h * 0.02).clamp(5,  20).toDouble();
            final headerH = (isLandscape ? 0.20 : 0.14) * h;  // tinggi header
            final spacer  = (isLandscape ? 0.05 : 0.03) * h;  // jarak kecil antara header & grid

            return Stack(
              children: [
                // Layer-1: background header
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: headerH,
                    child: Image.asset('assets/images/header.png', fit: BoxFit.cover),
                  ),
                ),

                Positioned.fill(
                  top: padY,
                  child: IgnorePointer(
                    ignoring: true,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: padX),
                      child: Column(
                        children: [
                          SizedBox(height: (h * 0.01)),
                          Text(
                            'Selamat Datang, ${context.watch<QuizState>().username}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Baloo2',
                              fontSize: (w * (isLandscape ? 0.05 : 0.06)).clamp(16, 24),
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: (h * 0.008)),
                          Text(
                            'Pilih kategori kuis Anda:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Baloo2',
                              fontSize: (w * (isLandscape ? 0.04 : 0.048)).clamp(14, 20),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  top: headerH + spacer,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(padX, 0, padX, padY),
                    child: GridView.builder(
                      padding: EdgeInsets.only(bottom: padY * 2),
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isLandscape ? 3 : 2,
                        mainAxisSpacing: h * 0.03,
                        crossAxisSpacing: w * 0.05,
                        childAspectRatio: isLandscape ? 1.15 : 0.85,
                      ),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return _CategoryCard(
                          title: cat['title']!,
                          imagePath: cat['image']!,
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => ConfirmStartDialog(
                                categoryName: cat['title']!,
                                onConfirm: () {
                                  context.read<QuizState>().setCategory(cat['title']!);
                                  context.push(AppRoutes.quiz);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Material(
      color: const Color(0xFFCDE1E0),
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: EdgeInsets.all((w * 0.045).clamp(12, 20)),
          child: Column(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(
                    imagePath,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported, size: 56, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: (w * 0.045).clamp(13, 18),
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '5 pertanyaan',
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: (w * 0.035).clamp(11, 14),
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Mulai →',
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: (w * 0.04).clamp(12, 16),
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
