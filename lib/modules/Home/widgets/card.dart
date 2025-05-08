import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String image;
  final double rating;
  final String title;
  final String time;

  const RecipeCard({
    super.key,
    required this.image,
    required this.rating,
    required this.title,
    required this.time,
  });

  bool get _isNetworkImage => image.startsWith('http');

  Widget _buildImage() {
    if (image.startsWith('data:image')) {
      final base64String = image.split(',').last;
      Uint8List imageBytes = base64Decode(base64String);
      return Image.memory(imageBytes, fit: BoxFit.cover);
    } else if (_isNetworkImage) {
      return Image.network(image, fit: BoxFit.cover);
    } else {
      return Image.asset(image, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: SizedBox(width: 180, height: 120, child: _buildImage()),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(
                        rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Time', style: TextStyle(color: Colors.grey)),
                    Text(
                      time,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Icon(Icons.bookmark_border, color: Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
