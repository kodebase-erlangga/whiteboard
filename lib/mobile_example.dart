// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:image_painter/image_painter.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MobileExample extends StatefulWidget {
  const MobileExample({super.key});

  @override
  State<MobileExample> createState() => _MobileExampleState();
}

class _MobileExampleState extends State<MobileExample> {
  String? selectedImage;
  final ImagePainterController _controller = ImagePainterController();
  bool _showToolbar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child:
                selectedImage == null ? buildImageSelection() : buildPainter(),
          ),
          Positioned(
            right: 10,
            top: 50,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  child: Icon(
                      _showToolbar ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _showToolbar = !_showToolbar;
                    });
                  },
                ),
                if (_showToolbar) _buildToolbar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageSelection() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildImageCard("assets/images/papanTulis.png"),
          const SizedBox(width: 20),
          buildImageCard("assets/images/blackBoard.jpeg"),
        ],
      ),
    );
  }

  Widget buildImageCard(String imagePath) {
    bool isSelected = selectedImage == imagePath;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = imagePath;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.3 : 0.1),
              blurRadius: isSelected ? 10 : 5,
              spreadRadius: isSelected ? 3 : 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 460,
                height: 460,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                // decoration: BoxDecoration(
                //   // ignore: deprecated_member_use
                //   color: Colors.black.withOpacity(0.6),
                //   borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(12),
                //     bottomRight: Radius.circular(12),
                //   ),
                // ),
                child: Center(
                  child: Text(
                    imagePath.contains("papanTulis")
                        ? "White Board"
                        : "Black Board",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildPainter() {
    return ImagePainter.asset(
      selectedImage!,
      controller: _controller,
      scalable: true,
      textDelegate: TextDelegate(),
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToolbarItem(
                Icons.color_lens,
                "Color",
                null,
                onTap: () async {
                  final color = await showDialog<Color>(
                    context: context,
                    builder: (context) =>
                        ColorPickerDialog(initialColor: _controller.color),
                  );
                  if (color != null) {
                    setState(() {
                      _controller.setColor(color);
                    });
                  }
                },
              ),
              _buildToolbarItem(CupertinoIcons.resize, "Ukuran", null,
                  onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    double selectedWidth = _controller.strokeWidth;
                    return StatefulBuilder(
                      builder: (context, setDialogState) {
                        return AlertDialog(
                          title: Text("Set Stroke Width"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Slider(
                                min: 1.0,
                                max: 40.0,
                                divisions: 39,
                                value: selectedWidth,
                                onChanged: (value) {
                                  setDialogState(() {
                                    selectedWidth = value;
                                  });
                                  setState(() {
                                    _controller.setStrokeWidth(selectedWidth);
                                  });
                                },
                              ),
                              Text(
                                  "Width: ${selectedWidth.toStringAsFixed(1)}"),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }),
              _buildToolbarItem(Icons.brush, "Brush", PaintMode.freeStyle),
              _buildToolbarItem(Icons.line_axis, "Line", PaintMode.line),
              _buildToolbarItem(
                  Icons.line_weight_sharp, "Dash", PaintMode.dashLine),
              _buildToolbarItem(
                  Icons.rectangle_outlined, "Rectangle", PaintMode.rect),
              _buildToolbarItem(
                  Icons.circle_outlined, "Circle", PaintMode.circle),
              _buildToolbarItem(Icons.text_fields, "Text", PaintMode.text),
              _buildToolbarItem(
                  Icons.arrow_back_outlined, "Arrow", PaintMode.arrow),
              // _buildToolbarItem(Icons.undo, "Undo", null,
              //     onTap: _controller.undo),
              // _buildToolbarItem(Icons.delete, "Clear", null, onTap: () {
              //   _showDeleteDialog();
              // }),
              // _buildToolbarItem(Icons.save, "Save", null, onTap: saveImage),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbarItem(IconData icon, String label, PaintMode? mode,
      {VoidCallback? onTap}) {
    bool isSelected = _controller.mode == mode;

    return GestureDetector(
      onTap: () {
        if (mode != null) {
          setState(() {
            _controller.setMode(mode);
          });
        }
        if (onTap != null) onTap();
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected
                  // ignore: deprecated_member_use
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 28,
              color: isSelected ? Colors.blue : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  void saveImage() async {
    final image = await _controller.exportImage();
    final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath = '$directory/sample/$imageName';
    final imgFile = File('$fullPath');
    if (image != null) {
      imgFile.writeAsBytesSync(image);
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

class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;
  const ColorPickerDialog({required this.initialColor, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Pilih Warna"),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: initialColor,
          onColorChanged: (color) => Navigator.of(context).pop(color),
        ),
      ),
    );
  }
}
