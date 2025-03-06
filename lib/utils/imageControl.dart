import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:whiteboard/utils/listColor.dart';
import 'package:whiteboard/widget/alertHapus.dart';
import 'package:whiteboard/utils/simpanGambar.dart';
import 'package:whiteboard/utils/listColor.dart';

Widget buildImageControls({
  required ImagePainterController? controller,
  required BuildContext context,
  required Function() onUndo,
  required Function() onDeleteAll,
  required Function() onSave,
  required bool isToolbarVisible,
  required bool showImageControls,
  required Function(bool, bool) onToggleVisibility,z
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (controller != null)
          AnimatedBuilder(
            animation: controller,
            builder: (_, __) {
              return PopupMenuButton(
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tooltip: 'Pilih Warna',
                icon: Container(
                  padding: const EdgeInsets.all(2.0),
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade500),
                    color: controller.color,
                  ),
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    enabled: false,
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: editorColorsList.map((color) {
                          return GestureDetector(
                            onTap: () {
                              controller.setColor(color);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(color: color),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: onUndo,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.black),
              ),
              icon: const Icon(Icons.undo),
              label: const Text(
                "Undo",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton.icon(
              onPressed: onDeleteAll,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.black),
              ),
              icon: const Icon(Icons.delete),
              label: const Text(
                "Hapus Semua",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 10),
            OutlinedButton.icon(
              onPressed: onSave,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.black),
              ),
              icon: const Icon(Icons.save),
              label: const Text(
                "Simpan",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}