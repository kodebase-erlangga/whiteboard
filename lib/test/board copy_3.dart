// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:image_painter/image_painter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:whiteboard/widget/alertHapus.dart';
// import 'package:whiteboard/widget/alertSimpan.dart';
// import 'package:whiteboard/widget/toolbar.dart';
// import '../widget/image_selection.dart';

// class Board extends StatefulWidget {
//   const Board({super.key});

//   @override
//   State<Board> createState() => _BoardState();
// }

// class _BoardState extends State<Board> {
//   bool _showImageControls = true;
//   bool _isToolbarVisible = true;
//   final GlobalKey _painterKey = GlobalKey();
//   String? selectedImage;
//   ImagePainterController? _controller;
//   File? _backgroundImageFile;
//   List<ImageLayer> imageLayers = [];
//   ImageLayer? selectedLayer;

//   final List<Color> editorColors = [
//     Colors.black,
//     Colors.red,
//     Colors.green,
//     Colors.blue,
//     Colors.yellow,
//     Colors.orange,
//     Colors.purple,
//     Colors.pink,
//     Colors.brown,
//     Colors.grey,
//   ];

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   Widget _buildImageControls() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           if (_controller != null)
//             AnimatedBuilder(
//               animation: _controller!,
//               builder: (_, __) {
//                 return PopupMenuButton(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   tooltip: 'Pilih Warna',
//                   icon: Container(
//                     padding: const EdgeInsets.all(2.0),
//                     height: 32,
//                     width: 32,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.grey.shade500),
//                       color: _controller!.color,
//                     ),
//                   ),
//                   itemBuilder: (_) => [
//                     PopupMenuItem(
//                       enabled: false,
//                       child: Center(
//                         child: Wrap(
//                           alignment: WrapAlignment.center,
//                           spacing: 12,
//                           runSpacing: 12,
//                           children: editorColors.map((color) {
//                             return GestureDetector(
//                               onTap: () {
//                                 _controller!.setColor(color);
//                                 Navigator.pop(context);
//                               },
//                               child: Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   color: color,
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                     color: color,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           Row(
//             children: [
//               OutlinedButton.icon(
//                 onPressed: _controller?.undo,
//                 style: OutlinedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   foregroundColor: Colors.black,
//                   side: BorderSide(color: Colors.black),
//                 ),
//                 icon: const Icon(Icons.undo),
//                 label: const Text(
//                   "Undo",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               OutlinedButton.icon(
//                 onPressed: () {
//                   AlertHapus.show(context, () {
//                     if (_controller != null) {
//                       _controller!.clear();
//                     }
//                   });
//                 },
//                 style: OutlinedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   foregroundColor: Colors.black,
//                   side: BorderSide(color: Colors.black),
//                 ),
//                 icon: const Icon(Icons.delete),
//                 label: const Text(
//                   "Hapus Semua",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               OutlinedButton.icon(
//                 onPressed: () async {
//                   setState(() {
//                     _isToolbarVisible = false;
//                     _showImageControls = false;
//                   });
//                   await _simpanGambar();
//                 },
//                 style: OutlinedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   foregroundColor: Colors.black,
//                   side: BorderSide(color: Colors.black),
//                 ),
//                 icon: const Icon(Icons.save),
//                 label: const Text(
//                   "Simpan",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
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

//   Future<void> _simpanGambar() async {
//     try {
//       final boundary = _painterKey.currentContext?.findRenderObject()
//           as RenderRepaintBoundary?;
//       if (boundary == null) return;
//       final image = await boundary.toImage(pixelRatio: 3.0);
//       final byteData = await image.toByteData(format: ImageByteFormat.png);
//       final bytes = byteData!.buffer.asUint8List();

//       final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
//       final directory = await getApplicationDocumentsDirectory();
//       final sampleDir = Directory('${directory.path}/sample');
//       await sampleDir.create(recursive: true);
//       final fullPath = '${sampleDir.path}/$imageName';

//       final imgFile = File(fullPath);
//       await imgFile.writeAsBytes(bytes);

//       if (mounted) {
//         AlertSimpan.show(context, fullPath);
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Gagal menyimpan: $e')),
//         );
//       }
//     }
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
//       appBar: selectedImage != null && _isToolbarVisible
//           ? AppBar(
//               actions: [
//                 if (_showImageControls) _buildImageControls(),
//               ],
//             )
//           : null,
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
//                     children: [
//                       painter(),
//                     ],
//                   ),
//           ),
//           if (selectedImage != null)
//             Positioned(
//               top: 20,
//               left: 20,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       _isToolbarVisible && _showImageControls
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                       color: Colors.black,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _isToolbarVisible = !_isToolbarVisible;
//                         _showImageControls = !_showImageControls;
//                       });
//                     },
//                   ),
//                   if (_isToolbarVisible)
//                     Toolbar(
//                       controller: _controller!,
//                       onPickImage: _pickImage,
//                     ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           if (selectedImage != null)
//             FloatingActionButton.extended(
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
//             ),
//         ],
//       ),
//     );
//   }

//   Widget painter() {
//     return RepaintBoundary(
//       key: _painterKey,
//       child: Stack(
//         children: [
//           _buildBackgroundPainter(),
//           ...imageLayers.map((layer) => _buildImageLayer(layer)),
//         ],
//       ),
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
