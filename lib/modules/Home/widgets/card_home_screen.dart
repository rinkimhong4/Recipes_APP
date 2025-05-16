import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:shimmer/shimmer.dart';

class RecipeCard extends StatefulWidget {
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

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool isLoading = true;

  bool get _isNetworkImage => widget.image.startsWith('http');

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget _buildImage() {
    return widget.image.startsWith('data:image')
        ? Image.memory(
          base64Decode(widget.image.split(',').last),
          fit: BoxFit.cover,
        )
        : _isNetworkImage
        ? CachedNetworkImage(
          imageUrl: widget.image,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(color: Colors.grey.shade300),
              ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        )
        : Image.asset(widget.image, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: isLoading ? _buildShimmer(context) : _buildContent(context),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: SizedBox(
                  width: double.infinity,
                  height: 130,
                  child: _buildImage(),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(
                        widget.rating.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.title,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Time', style: TextStyle(color: Colors.grey)),
                    Text(
                      widget.time,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.bookmark_border, color: AppColors.primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
