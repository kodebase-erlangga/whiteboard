// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelection extends StatefulWidget {
  final Function(String) onImageSelected; // Callback ke Board.dart

  const ImageSelection({super.key, required this.onImageSelected});

  @override
  State<ImageSelection> createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  String? selectedImage;
  List<String> imagePaths = [
    "assets/images/papanTulis.png",
    "assets/images/blackBoard.jpeg",
  ];
  final ImagePicker _picker = ImagePicker();

  Widget buildImageCard(String imagePath) {
    bool isSelected = selectedImage == imagePath;
    bool isLocalFile = !imagePath.startsWith("assets/");

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = imagePath;
        });
        widget.onImageSelected(imagePath);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.blueAccent, width: 4)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.4 : 0.15),
              blurRadius: isSelected ? 12 : 6,
              spreadRadius: isSelected ? 3 : 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: isLocalFile
                  ? (File(imagePath).existsSync()
                      ? Image.file(File(imagePath),
                          width: 200, height: 200, fit: BoxFit.cover)
                      : const Center(child: Text("Gambar tidak ditemukan")))
                  : Image.asset(imagePath,
                      width: 200, height: 200, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.6),
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Center(
                  child: Text(
                    imagePath.contains("papanTulis")
                        ? "White Board"
                        : imagePath.contains("blackBoard")
                            ? "Black Board"
                            : "Custom Image",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            if (isSelected)
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: imagePaths.map((path) => buildImageCard(path)).toList(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.add_photo_alternate, size: 24),
          label: const Text("Tambahkan Gambar"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePaths.add(pickedFile.path);
        selectedImage = pickedFile.path;
      });
      widget.onImageSelected(pickedFile.path);
    }
  }
}