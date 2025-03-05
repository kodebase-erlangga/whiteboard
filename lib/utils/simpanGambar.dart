import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whiteboard/widget/alertSimpan.dart';

Future<void> simpanGambar(GlobalKey painterKey, BuildContext context) async {
  try {
    final boundary = painterKey.currentContext?.findRenderObject()
        as RenderRepaintBoundary?;
    if (boundary == null) return;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final directory = await getApplicationDocumentsDirectory();
    final sampleDir = Directory('${directory.path}/sample');
    await sampleDir.create(recursive: true);
    final fullPath = '${sampleDir.path}/$imageName';

    final imgFile = File(fullPath);
    await imgFile.writeAsBytes(bytes);

    if (context.mounted) {
      AlertSimpan.show(context, fullPath);
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan: $e')),
      );
    }
  }
}