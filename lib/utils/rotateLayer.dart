import 'package:whiteboard/utils/classImageLayer.dart';

void rotateLayer(ImageLayer layer, double angle) {
  layer.rotation = (layer.rotation + angle) % (2 * 3.141592653589793);
}
