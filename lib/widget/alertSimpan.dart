import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class AlertSimpan extends StatelessWidget {
  final String filePath; // ✅ Tambahkan filePath sebagai parameter

  const AlertSimpan({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void show(BuildContext context, String filePath) { // ✅ Terima fullPath
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/done.png',
                  width: 100,
                ),
                const SizedBox(height: 24),
                Text(
                  'Mantap! Ayo Langsung Bagikan Dengan Orang Lain!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      letterSpacing: .5,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Gambar Ini Tidak Tersimpan Digaleri',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color(0xffA6A6A6),
                      letterSpacing: .5,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => OpenFile.open(filePath),
                  child:
                      Text("Open", style: TextStyle(color: Colors.blue[200])),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}