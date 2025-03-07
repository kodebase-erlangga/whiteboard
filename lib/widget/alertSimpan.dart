import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';

class AlertSimpan extends StatelessWidget {
  final String filePath;

  const AlertSimpan({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void show(BuildContext context, String filePath) {
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
                  'Peringatan : Gambar Ini Tidak Tersimpan Digaleri',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 0, 0),
                      letterSpacing: .5,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => OpenFile.open(filePath),
                  child: Text(
                    "Open",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 43, 0, 255),
                        letterSpacing: .5,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
