import 'dart:ui';
import '../utils/classImageLayer.dart';

void updateLayerPosition(ImageLayer layer, Offset delta) {
  layer.offset += delta;
}