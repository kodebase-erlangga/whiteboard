import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertHapus extends StatelessWidget {
  const AlertHapus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static void show(BuildContext context, VoidCallback onDelete) {
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
                  'assets/images/alertHapus.png',
                  width: 100,
                ),
                const SizedBox(height: 24),
                Text(
                  'Apakah kamu yakin akan menghapus catatan kamu?',
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
                  'Aksi ini tidak dapat dipulihkan!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montaga(
                    textStyle: const TextStyle(
                      color: Color(0xffA6A6A6),
                      letterSpacing: .5,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 22,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Batal"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 22,
                        ),
                      ),
                      onPressed: () {
                        onDelete();
                        Navigator.pop(context);
                      },
                      child: const Text('Hapus'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
