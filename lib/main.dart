import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whiteboard/board.dart';

// void main() => runApp(ExampleApp());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImagePainterExample(),
    );
  }
}

class ImagePainterExample extends StatelessWidget {
  const ImagePainterExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Board();
  }
}
