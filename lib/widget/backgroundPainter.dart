// ignore: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';

Widget buildBackgroundPainter({
  required String? selectedImage,
  required ImagePainterController? controller,
  required Future<void> Function() onPickImage,
}) {
  if (selectedImage == null) {
    return const Center(child: Text("Tidak ada gambar yang dipilih"));
  }

  if (selectedImage!.startsWith("assets/")) {
    return ImagePainter.asset(
      selectedImage!,
      controller: controller!,
      scalable: true,
      textDelegate: TextDelegate(),
      onPickImage: onPickImage,
    );
  } else {
    return ImagePainter.file(
      File(selectedImage!),
      controller: controller!,
      scalable: true,
      textDelegate: TextDelegate(),
      onPickImage: onPickImage,
    );
  }
}