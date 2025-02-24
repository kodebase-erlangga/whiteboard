// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ImageSelection extends StatefulWidget {
  final Function(String) onImageSelected; // Callback ke Board.dart

  const ImageSelection({super.key, required this.onImageSelected});

  @override
  State<ImageSelection> createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  String? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildImageCard("assets/images/papanTulis.png"),
          const SizedBox(width: 20),
          buildImageCard("assets/images/blackBoard.jpeg"),
        ],
      ),
    );
  }

  Widget buildImageCard(String imagePath) {
    bool isSelected = selectedImage == imagePath;

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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.3 : 0.1),
              blurRadius: isSelected ? 10 : 5,
              spreadRadius: isSelected ? 3 : 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Center(
                  child: Text(
                    imagePath.contains("papanTulis") ? "White Board" : "Black Board",
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
}
