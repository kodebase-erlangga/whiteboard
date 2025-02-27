import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import '../widget/image_selection.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  String? selectedImage;
  ImagePainterController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: selectedImage == null
                ? ImageSelection(
                    onImageSelected: (image) {
                      setState(() {
                        selectedImage = image;
                        _controller?.dispose();
                        _controller = ImagePainterController();
                      });
                    },
                  )
                : painter(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            selectedImage = null;
            _controller?.dispose();
            _controller = null;
          });
        },
        label: const Text("Menu Utama"),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget painter() {
    if (selectedImage == null) {
      return const Center(child: Text("Tidak ada gambar yang dipilih"));
    }

    if (selectedImage!.startsWith("assets/")) {
      return ImagePainter.asset(
        selectedImage!,
        controller: _controller!,
        scalable: true,
        textDelegate: TextDelegate(),
      );
    } else {
      final file = File(selectedImage!);
      if (!file.existsSync()) {
        return const Center(child: Text("File gambar tidak ditemukan"));
      }
      return ImagePainter.file(
        file,
        controller: _controller!,
        scalable: true,
        textDelegate: TextDelegate(),
      );
    }
  }
}
