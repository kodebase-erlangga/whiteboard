import 'package:flutter/material.dart';
import '../utils/classImageLayer.dart';

Widget buildImageLayer({
  required ImageLayer layer,
  required Function(ImageLayer, Offset) onUpdatePosition,
  required Function(ImageLayer, double) onScale,
}) {
  return Positioned(
    left: layer.offset.dx,
    top: layer.offset.dy,
    child: GestureDetector(
      onScaleUpdate: (details) {
        onUpdatePosition(layer, details.focalPointDelta);
        onScale(layer, details.scale);
      },
      child: Transform.scale(
        scale: layer.scale,
        child: Image.file(
          layer.image,
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}