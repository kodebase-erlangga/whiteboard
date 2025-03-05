import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_painter/image_painter.dart';

class StrokeWidthDialog extends StatefulWidget {
  final ImagePainterController controller;
  const StrokeWidthDialog({required this.controller, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StrokeWidthDialogState createState() => _StrokeWidthDialogState();
}

class _StrokeWidthDialogState extends State<StrokeWidthDialog> {
  late double selectedWidth;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedWidth = widget.controller.strokeWidth;
    _textController.text = selectedWidth.toStringAsFixed(1);
  }

  void _updateStrokeWidth(String value) {
    final double? newValue = double.tryParse(value);
    if (newValue != null && newValue >= 1.0 && newValue <= 40.0) {
      setState(() {
        selectedWidth = newValue;
        widget.controller.setStrokeWidth(selectedWidth);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Atur ukuran brush dan tulisan"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            min: 1.0,
            max: 40.0,
            divisions: 39,
            value: selectedWidth,
            onChanged: (value) {
              setState(() {
                selectedWidth = value;
                _textController.text = selectedWidth.toStringAsFixed(1);
                widget.controller.setStrokeWidth(selectedWidth);
              });
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Ukuran:"),
              const SizedBox(width: 8),
              SizedBox(
                width: 60,
                child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}$')),
                  ],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: _updateStrokeWidth,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _updateStrokeWidth(value);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Tutup"),
        ),
      ],
    );
  }
}
