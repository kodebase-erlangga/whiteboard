// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_painter/image_painter.dart';
// import 'package:image_picker/image_picker.dart';
// import '../widget/image_selection.dart';

// class Board extends StatefulWidget {
//   const Board({super.key});

//   @override
//   State<Board> createState() => _BoardState();
// }

// class _BoardState extends State<Board> {
//   String? selectedImage;
//   ImagePainterController? _controller;
//   File? _backgroundImageFile;

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _backgroundImageFile = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: selectedImage == null
//                 ? ImageSelection(
//                     onImageSelected: (image) {
//                       setState(() {
//                         selectedImage = image;
//                         _controller?.dispose();
//                         _controller = ImagePainterController();
//                       });
//                     },
//                   )
//                 : painter(),
//           ),
//         ],
//       ),
//       floatingActionButton: selectedImage != null
//           ? FloatingActionButton.extended(
//               onPressed: () {
//                 setState(() {
//                   selectedImage = null;
//                   _controller?.dispose();
//                   _controller = null;
//                 });
//               },
//               label: const Text("Menu Utama"),
//               icon: const Icon(Icons.arrow_back),
//             )
//           : null,
//     );
//   }

//   Widget painter() {
//     if (selectedImage == null) {
//       return const Center(child: Text("Tidak ada gambar yang dipilih"));
//     }

//     if (_backgroundImageFile != null) {
//       return ImagePainter.file(
//         _backgroundImageFile!,
//         controller: _controller!,
//         scalable: true,
//         textDelegate: TextDelegate(),
//       );
//     }

//     if (selectedImage!.startsWith("assets/")) {
//       return ImagePainter.asset(
//         selectedImage!,
//         controller: _controller!,
//         scalable: true,
//         textDelegate: TextDelegate(),
//       );
//     } else {
//       final file = File(selectedImage!);
//       if (!file.existsSync()) {
//         return const Center(child: Text("File gambar tidak ditemukan"));
//       }
//       return ImagePainter.file(
//         file,
//         controller: _controller!,
//         scalable: true,
//         textDelegate: TextDelegate(),
//       );
//     }
//   }
// }
