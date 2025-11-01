import 'package:flutter/material.dart';

class ConfirmStartDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String? categoryName;

  const ConfirmStartDialog({
    super.key,
    required this.onConfirm,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final pad = (w * 0.06).clamp(16.0, 28.0);
    final radius = (w * 0.06).clamp(18.0, 28.0);
    final titleSize = (w * 0.06).clamp(18.0, 24.0);
    final bodySize = (w * 0.04).clamp(13.0, 16.0);
    final btnVPad = (h * 0.018).clamp(10.0, 14.0);
    final btnHPad = (w * 0.08).clamp(18.0, 28.0);
    final gap = (h * 0.02).clamp(10.0, 16.0);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: (w * 0.08).clamp(16.0, 40.0)),
      backgroundColor: const Color(0xFFCDE1E0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Padding(
        padding: EdgeInsets.all(pad),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Mulai mengerjakan kuis ${categoryName ?? ''}? 😺',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontWeight: FontWeight.w700,
                fontSize: titleSize,
                color: const Color(0xFF3C3C3C),
              ),
            ),

            SizedBox(height: gap), //jarak biar tidak mepet

            Text(
              'Kamu tidak bisa kembali sampai semua pertanyaan selesai. Pastikan kamu siap ya!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: bodySize,
                color: const Color(0xFF4B4B4B),
                height: 1.35,
              ),
            ),

            SizedBox(height: gap * 1.2),

            // tombol 2 kolom
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nanti dulu
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE9EA), // pink lembut
                    foregroundColor: const Color(0xFF8E2B2B),
                    padding: EdgeInsets.symmetric(vertical: btnVPad, horizontal: btnHPad),
                    shape: StadiumBorder(side: BorderSide(color: Colors.black.withOpacity(0.02))),
                  ),
                  child: Text(
                    'Nanti dulu',
                    style: TextStyle(fontFamily: 'Baloo2', fontWeight: FontWeight.w700, fontSize: bodySize),
                  ),
                ),
                SizedBox(width: gap),
                // Ya, mulai
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // tutup dialog dulu
                    onConfirm();            // lalu eksekusi lanjut
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE9FFE9), // hijau lembut
                    foregroundColor: const Color(0xFF167A4A),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: btnVPad, horizontal: btnHPad),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Ya, mulai',
                    style: TextStyle(fontFamily: 'Baloo2', fontWeight: FontWeight.w800, fontSize: bodySize),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
