// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageSelection extends StatefulWidget {
//   final Function(String) onImageSelected;

//   const ImageSelection({super.key, required this.onImageSelected});

//   @override
//   State<ImageSelection> createState() => _ImageSelectionState();
// }

// class _ImageSelectionState extends State<ImageSelection> {
//   String? selectedImage;
//   List<String> imagePaths = [
//     "assets/images/papanTulis.png",
//     "assets/images/blackBoard.jpeg",
//     "assets/images/woodBoard.png",
//     "assets/images/chalkBoard.png",
//     "assets/images/plainBoard.png",
//   ];
//   final ImagePicker _picker = ImagePicker();

//   Widget _buildImageCard(String imagePath) {
//     bool isSelected = selectedImage == imagePath;
//     bool isLocalFile = !imagePath.startsWith("assets/");

//     return AspectRatio(
//       aspectRatio: 18 / 9,
//       child: GestureDetector(
//         onTap: () {
//           setState(() => selectedImage = imagePath);
//           widget.onImageSelected(imagePath);
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: isSelected ? Colors.blueAccent : Colors.grey.shade800,
//               width: isSelected ? 3 : 2,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(isSelected ? 0.3 : 0.1),
//                 blurRadius: 12,
//                 spreadRadius: 2,
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 isLocalFile
//                     ? _buildFileImage(imagePath)
//                     : Image.asset(imagePath, fit: BoxFit.cover),
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.7),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 12,
//                   left: 12,
//                   right: 12,
//                   child: Text(
//                     _getImageTitle(imagePath),
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       shadows: [
//                         Shadow(
//                           color: Colors.black.withOpacity(0.5),
//                           blurRadius: 6,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 if (isSelected)
//                   Positioned(
//                     top: 12,
//                     right: 12,
//                     child: Container(
//                       padding: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: Colors.blueAccent,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.blueAccent.withOpacity(0.4),
//                             blurRadius: 8,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                       child: const Icon(Icons.check,
//                           size: 20, color: Colors.white),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAddCard() {
//     return AspectRatio(
//       aspectRatio: 18 / 9,
//       child: GestureDetector(
//         onTap: pickImage,
//         child: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade900,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(
//               color: Colors.blueAccent,
//               width: 2,
//               style: BorderStyle.solid,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blueAccent.withOpacity(0.2),
//                 ),
//                 child: Icon(Icons.add_a_photo,
//                     size: 32, color: Colors.blueAccent.shade200),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 "Tambahkan Gambar",
//                 style: TextStyle(
//                   color: Colors.blueAccent.shade200,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFileImage(String path) {
//     return FutureBuilder(
//       future: File(path).exists(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData && snapshot.data!) {
//           return Image.file(File(path), fit: BoxFit.cover);
//         }
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, color: Colors.red.shade300, size: 32),
//               const SizedBox(height: 8),
//               Text("File tidak ditemukan",
//                   style: TextStyle(color: Colors.red.shade300)),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   String _getImageTitle(String path) {
//     return path
//         .split('/')
//         .last
//         .split('.')
//         .first
//         .toUpperCase()
//         .replaceAll('_', ' ')
//         .replaceAll('BOARD', ' BOARD');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Colors.grey.shade900,
//             Colors.blueGrey.shade900,
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "Pilih Kanvas",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.w800,
//                 letterSpacing: 1.2,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 childAspectRatio: 18 / 9,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 16,
//                 children: [
//                   ...imagePaths.map((path) => _buildImageCard(path)),
//                   _buildAddCard(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> pickImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         imagePaths.add(pickedFile.path);
//         selectedImage = pickedFile.path;
//       });
//       widget.onImageSelected(pickedFile.path);
//     }
//   }
// }
