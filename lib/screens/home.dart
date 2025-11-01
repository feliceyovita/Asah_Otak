import 'package:asahotak/widgets/confirm_start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/quiz_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<QuizState>();
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final cardHeight = (h * 0.22).clamp(140.0, 220.0);

    // Daftar kategori beserta path gambarnya
    final categories = [
      {'title': 'Matematika', 'image': 'assets/images/math.png'},
      {'title': 'IPA', 'image': 'assets/images/science.png'},
      {'title': 'Bahasa Inggris', 'image': 'assets/images/english.png'},
      {'title': 'Geografi', 'image': 'assets/images/geography.png'},
      {'title': 'Sejarah', 'image': 'assets/images/history.png'},
      {'title': 'Budaya & Seni', 'image': 'assets/images/art.png'},
      {'title': 'Kuliner Dunia', 'image': 'assets/images/food.png'},
      {'title': 'Olahraga', 'image': 'assets/images/sport.png'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              height: h * 0.19, // responsif
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ===== Konten (di depan header) =====
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.07, vertical: h * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.01),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: h * 0.02),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Selamat Datang, ${state.username}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            fontSize: w * 0.06,
                            color: Colors.white,          // <-- putih agar kontras di header hijau
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.01),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Pilih kategori kuis Anda:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            fontSize: w * 0.048,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // jarak transisi dari area hijau ke grid putih
                  SizedBox(height: h * 0.06),

                  // GRID KATEGORI
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(bottom: h * 0.04),
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: w > 700 ? 3 : 2,
                        mainAxisSpacing: h * 0.03,
                        crossAxisSpacing: w * 0.06,
                        childAspectRatio: 0.80,
                      ),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return _CategoryCard(
                          title: cat['title']!,
                          imagePath: cat['image']!,
                          height: cardHeight, // pastikan cardHeight didefinisikan di atas
                          onTap: () {
                            final catTitle = cat['title']!;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => ConfirmStartDialog(
                                categoryName: catTitle,
                                onConfirm: () {
                                  context.read<QuizState>().setCategory(catTitle);
                                  Navigator.pushNamed(context, '/quiz');
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double height;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.imagePath,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Material(
      color: const Color(0xFFCDE1E0),
      borderRadius: BorderRadius.circular(20),
      elevation: 3,                             // bayangan ringan
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: EdgeInsets.all(w * 0.045),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported, size: 56, color: Colors.grey),
                ),
              ),
              SizedBox(height: height * 0.05),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: w * 0.045,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Text(
                '5 pertanyaan',
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: w * 0.035,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Mulai →',
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontSize: w * 0.04,
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