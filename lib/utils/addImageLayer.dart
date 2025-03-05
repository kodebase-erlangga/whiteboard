import 'dart:io';
import '../utils/classImageLayer.dart';

void addImageLayer(List<ImageLayer> imageLayers, File image) {
  imageLayers.add(ImageLayer(image: image));
}