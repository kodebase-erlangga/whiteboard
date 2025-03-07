import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:whiteboard/utils/listColor.dart';

Widget buildImageControls(
    {required ImagePainterController? controller,
    required BuildContext context,
    required Function() onUndo,
    required Function() onDeleteAll,
    required Function() onSave,
    required bool isToolbarVisible,
    required bool showImageControls,
    required Function(bool, bool) onToggleVisibility,
    z}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
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
              return controller.canFill()
                  ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                      onPressed: () {
                        controller.update(fill: !controller.shouldFill);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            controller.shouldFill
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.shouldFill ? "Filled" : "Fill",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox();
            },
          ),
        SizedBox(width: 10),
        if (controller != null)
          AnimatedBuilder(
            animation: controller,
            builder: (_, __) {
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onPressed: () {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 100, 100),
                    items: [
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade500),
                        color: controller.color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Warna Aktif',
                        style: TextStyle(color: controller.color)),
                  ],
                ),
              );
            },
          ),
        SizedBox(width: 10),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: onUndo,
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
