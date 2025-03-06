import 'package:flutter/material.dart';
import '../utils/classImageLayer.dart';

Widget buildImageLayer({
  required ImageLayer layer,
  required Function(ImageLayer, Offset) onUpdatePosition,
  required Function(ImageLayer, double) onScale,
  required Function(ImageLayer) onDelete,
  required Function(ImageLayer) onToggleHide,
  required Function(ImageLayer, double) onRotate,
  required Function(ImageLayer, double) onResize,
}) {
  return Positioned(
    left: layer.offset.dx,
    top: layer.offset.dy,
    child: GestureDetector(
      onTap: () {
        onToggleHide(layer);
      },
      onScaleUpdate: (details) {
        onUpdatePosition(layer, details.focalPointDelta);
        onScale(layer, details.scale);
      },
      child: Transform.scale(
        scale: layer.scale,
        child: Transform.rotate(
          angle: layer.rotation,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Image.file(
                layer.image,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (layer.showCheckButton)
                      Tooltip(
                        message: 'Sembunyikan Tombol Hapus',
                        child: IconButton(
                          icon: const Icon(Icons.check),
                          color: Colors.green,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            onToggleHide(layer);
                          },
                        ),
                      ),
                    if (layer.showCheckButton)
                      Tooltip(
                        message: 'Perkecil Gambar',
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          color: Colors.orange,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () => onResize(layer, -0.1),
                        ),
                      ),
                    // Tombol Perbesar
                    if (layer.showCheckButton)
                      Tooltip(
                        message: 'Perbesar Gambar',
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          color: Colors.blue,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () => onResize(layer, 0.1),
                        ),
                      ),
                    if (layer.showRotateButton)
                      Tooltip(
                        message: 'Rotasi Gambar',
                        child: IconButton(
                          icon: const Icon(Icons.rotate_right),
                          color: Colors.blue,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () => onRotate(layer, 90),
                        ),
                      ),
                    if (layer.showDeleteButton)
                      Tooltip(
                        message: 'Hapus',
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          color: Colors.red,
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            onDelete(layer);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}