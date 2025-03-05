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
//   List<ImageLayer> imageLayers = [];
//   ImageLayer? selectedLayer;

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   void _addImageLayer(File image) {
//     setState(() {
//       imageLayers.add(ImageLayer(image: image));
//     });
//   }

//   void _updateLayerPosition(ImageLayer layer, Offset delta) {
//     setState(() {
//       layer.offset += delta;
//     });
//   }

//   void _scaleLayer(ImageLayer layer, double scale) {
//     setState(() {
//       layer.scale = scale.clamp(0.5, 5.0);
//     });
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       _addImageLayer(File(pickedFile.path));
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
//                 : Stack(
//                   children: [
//                     painter(),
                    
//                   ],
//                 ),
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
//                   imageLayers.clear();
//                 });
//               },
//               label: const Text("Menu Utama"),
//               icon: const Icon(Icons.arrow_back),
//             )
//           : null,
//     );
//   }

//   Widget painter() {
//     return Stack(
//       children: [
//         _buildBackgroundPainter(),

//         ...imageLayers.map((layer) => _buildImageLayer(layer)),
//       ],
//     );
//   }

//   Widget _buildBackgroundPainter() {
//     if (selectedImage == null) {
//       return const Center(child: Text("Tidak ada gambar yang dipilih"));
//     }

//     if (_backgroundImageFile != null) {
//       return ImagePainter.file(
//         _backgroundImageFile!,
//         controller: _controller!,
//         scalable: true,
//         textDelegate: TextDelegate(),
//         onPickImage: _pickImage,
//       );
//     }

//     if (selectedImage!.startsWith("assets/")) {
//       return ImagePainter.asset(
//         selectedImage!,
//         controller: _controller!,
//         scalable: true,
//         textDelegate: TextDelegate(),
//         onPickImage: _pickImage,
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
//         onPickImage: _pickImage,
//       );
//     }
//   }

//   Widget _buildImageLayer(ImageLayer layer) {
//     return Positioned(
//       left: layer.offset.dx,
//       top: layer.offset.dy,
//       child: GestureDetector(
//         onScaleUpdate: (details) {
//           _updateLayerPosition(layer, details.focalPointDelta);
//           _scaleLayer(layer, details.scale);
//         },
//         child: Transform.scale(
//           scale: layer.scale,
//           child: Image.file(
//             layer.image,
//             width: 200,
//             height: 200,
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ImageLayer {
//   final File image;
//   Offset offset;
//   double scale;
//   double rotation;

//   ImageLayer({
//     required this.image,
//     this.offset = Offset.zero,
//     this.scale = 1.0,
//     this.rotation = 0.0,
//   });
// }
