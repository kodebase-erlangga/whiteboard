import 'dart:io';
import 'dart:ui';

class ImageLayer {
  final File image;
  Offset offset;
  double scale;
  double rotation;
  bool showDeleteButton;
  bool showCheckButton;
  bool showRotateButton;

  ImageLayer({
    required this.image,
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.showDeleteButton = true,
    this.showCheckButton = true,
    this.showRotateButton = true,
  });
}
