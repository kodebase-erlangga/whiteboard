import '../utils/classImageLayer.dart';

void scaleLayer(ImageLayer layer, double scale) {
  layer.scale = scale.clamp(0.5, 5.0);
}