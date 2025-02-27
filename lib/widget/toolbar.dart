import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../widget/stroke_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class Toolbar extends StatefulWidget {
  final ImagePainterController controller;

  const Toolbar({super.key, required this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _ToolbarState createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  late TextEditingController _textController;
  bool isZoomActive = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVertical = MediaQuery.of(context).size.width > 600;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: isVertical ? null : MediaQuery.of(context).size.width,
        height: isVertical ? MediaQuery.of(context).size.height * 0.7 : 80,
        child: SingleChildScrollView(
          scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
          child: isVertical
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildToolbarItems(),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildToolbarItems(),
                ),
        ),
      ),
    );
  }

  List<Widget> _buildToolbarItems() {
    return [
      _buildToolbarItem(
        Icons.color_lens,
        "Color",
        null,
        onTap: () async {
          final color = await showDialog<Color>(
            context: context,
            builder: (context) =>
                ColorPickerDialog(initialColor: widget.controller.color),
          );
          if (color != null) {
            widget.controller.setColor(color);
          }
        },
      ),
      _buildToolbarItem(
          isZoomActive ? Icons.zoom_out_map : Icons.zoom_in_map,
          isZoomActive ? "Zoom Out" : "Zoom In",
          PaintMode.none, onTap: () {
        setState(() {
          isZoomActive = !isZoomActive;
        });
      }),
      _buildToolbarItem(
        CupertinoIcons.resize,
        "Ukuran",
        null,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) =>
                StrokeWidthDialog(controller: widget.controller),
          );
        },
      ),
      _buildToolbarItem(Icons.brush, "Brush", PaintMode.freeStyle),
      _buildToolbarItem(Icons.line_axis, "Line", PaintMode.line),
      _buildToolbarItem(Icons.line_weight_sharp, "Dash", PaintMode.dashLine),
      _buildToolbarItem(Icons.rectangle_outlined, "Rectangle", PaintMode.rect),
      _buildToolbarItem(Icons.circle_outlined, "Circle", PaintMode.circle),
      _buildToolbarItem(
        Icons.text_fields,
        "Text",
        PaintMode.text,
        onTap: () => _openTextDialog(),
      ),
      _buildToolbarItem(Icons.arrow_back_outlined, "Arrow", PaintMode.arrow),
    ];
  }

  Widget _buildToolbarItem(IconData icon, String label, PaintMode? mode,
      {VoidCallback? onTap}) {
    bool isSelected = widget.controller.mode == mode;
    final iconSize = MediaQuery.of(context).size.width * 0.06;
    final fontSize = MediaQuery.of(context).size.width * 0.03;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (mode != null) {
            widget.controller.setMode(mode);
          }
        });
        if (onTap != null) onTap();
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.amber.withOpacity(0.3)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: iconSize.clamp(24, 36),
              color: isSelected ? Colors.amber[800] : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: fontSize.clamp(10, 14)),
          ),
        ],
      ),
    );
  }

  void _openTextDialog() {
    widget.controller.setMode(PaintMode.text);
    // final fontSize = 6 * widget.controller.strokeWidth;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Masukkan Teks"),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(hintText: "Masukkan teks di sini"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _addPaintHistory(
                  PaintInfo(
                    mode: PaintMode.text,
                    text: _textController.text,
                    offsets: [],
                    color: widget.controller.color,
                    strokeWidth: widget.controller.scaledStrokeWidth,
                  ),
                );
                _textController.clear();
              }
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _addPaintHistory(PaintInfo info) {
    if (info.mode != PaintMode.none) {
      widget.controller.addPaintInfo(info);
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
