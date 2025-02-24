// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:image_painter/image_painter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../widget/toolbar.dart';
import '../widget/image_selection.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  String? selectedImage;
  final ImagePainterController _controller = ImagePainterController();
  bool _showToolbar = true;

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
                      });
                    },
                  )
                : painter(),
          ),
          Positioned(
            right: 10,
            top: 50,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  child: Icon(
                    _showToolbar ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _showToolbar = !_showToolbar;
                    });
                  },
                ),
                if (_showToolbar) Toolbar(controller: _controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget painter() {
    return ImagePainter.asset(
      selectedImage!,
      controller: _controller,
      scalable: true,
      textDelegate: TextDelegate(),
    );
  }

  void simpanGambar() async {
    final image = await _controller.exportImage();
    final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath = '$directory/sample/$imageName';
    final imgFile = File('$fullPath');
    if (image != null) {
      imgFile.writeAsBytesSync(image);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[700],
          padding: const EdgeInsets.only(left: 10),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Image Exported successfully.",
                  style: TextStyle(color: Colors.white)),
              TextButton(
                onPressed: () => OpenFile.open(fullPath),
                child: Text("Open", style: TextStyle(color: Colors.blue[200])),
              )
            ],
          ),
        ),
      );
    }
  }
}
