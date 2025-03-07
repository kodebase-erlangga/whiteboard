import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelection extends StatefulWidget {
  final Function(String) onImageSelected;

  const ImageSelection({super.key, required this.onImageSelected});

  @override
  State<ImageSelection> createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  String? selectedImage;
  List<String> imagePaths = [
    "assets/images/blackBoard.jpeg",
    "assets/images/chalkBoard.png",
    "assets/images/plainBoard.png",
  ];
  final ImagePicker _picker = ImagePicker();

  Widget _buildImageCard(String imagePath) {
    bool isSelected = selectedImage == imagePath;
    bool isLocalFile = !imagePath.startsWith("assets/");

    return AspectRatio(
      aspectRatio: 18 / 9,
      child: GestureDetector(
        onTap: () {
          setState(() => selectedImage = imagePath);
          widget.onImageSelected(imagePath);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.blueAccent : Colors.grey.shade400,
              width: isSelected ? 3 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isSelected ? 0.3 : 0.1),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                isLocalFile
                    ? _buildFileImage(imagePath)
                    : Image.asset(imagePath, fit: BoxFit.cover),
                if (isSelected)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 20, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Ayo Mulai Belajar",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 18 / 9,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  ...imagePaths.map((path) => _buildImageCard(path)),
                  _buildAddCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCard() {
    return AspectRatio(
      aspectRatio: 18 / 9,
      child: GestureDetector(
        onTap: pickImage,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.blueAccent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo, size: 32, color: Colors.blueAccent.shade700),
              const SizedBox(height: 12),
              Text(
                "Tambahkan Gambar",
                style: GoogleFonts.poppins(
                  color: Colors.blueAccent.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileImage(String path) {
    return FutureBuilder(
      future: File(path).exists(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return Image.file(File(path), fit: BoxFit.cover);
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade300, size: 32),
              const SizedBox(height: 8),
              Text("File tidak ditemukan", style: TextStyle(color: Colors.red.shade300)),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePaths.add(pickedFile.path);
        selectedImage = pickedFile.path;
      });
      widget.onImageSelected(pickedFile.path);
    }
  }
}
