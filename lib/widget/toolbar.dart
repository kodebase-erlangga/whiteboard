import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Toolbar extends StatefulWidget {
  final ImagePainterController controller;

  const Toolbar({super.key, required this.controller});

  @override
  _ToolbarState createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  @override
  Widget build(BuildContext context) {
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
                context,
                Icons.color_lens,
                "Color",
                null,
                onTap: () async {
                  final color = await showDialog<Color>(
                    context: context,
                    builder: (context) => ColorPickerDialog(
                        initialColor: widget.controller.color),
                  );
                  if (color != null) {
                    widget.controller.setColor(color);
                  }
                },
              ),
              _buildToolbarItem(
                context,
                CupertinoIcons.resize,
                "Ukuran",
                null,
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      double selectedWidth = widget.controller.strokeWidth;
                      return StatefulBuilder(
                        builder: (context, setDialogState) {
                          return AlertDialog(
                            title: Text("Atur ukuran brush dan huruf"),
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
                                    widget.controller
                                        .setStrokeWidth(selectedWidth);
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
                },
              ),
              _buildToolbarItem(
                  context, Icons.brush, "Brush", PaintMode.freeStyle),
              _buildToolbarItem(
                  context, Icons.line_axis, "Line", PaintMode.line),
              _buildToolbarItem(
                  context, Icons.line_weight_sharp, "Dash", PaintMode.dashLine),
              _buildToolbarItem(context, Icons.rectangle_outlined, "Rectangle",
                  PaintMode.rect),
              _buildToolbarItem(
                  context, Icons.circle_outlined, "Circle", PaintMode.circle),
              _buildToolbarItem(
                  context, Icons.text_fields, "Text", PaintMode.text),
              _buildToolbarItem(
                  context, Icons.arrow_back_outlined, "Arrow", PaintMode.arrow),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbarItem(
      BuildContext context, IconData icon, String label, PaintMode? mode,
      {VoidCallback? onTap}) {
    bool isSelected = widget.controller.mode == mode;

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
              size: 28,
              color: isSelected ? Colors.amber[800] : Colors.black87,
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
