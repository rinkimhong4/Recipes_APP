import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/models/recipe_models.dart';

class ItemDetail extends StatefulWidget {
  final Recipe recipe;
  const ItemDetail({super.key, required this.recipe});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.recipe.name ?? 'Recipe Detail'),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: _isLoading ? _buildShimmer(context) : _buildRecipeDetail(),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: _buildShimmerDetail(),
    );
  }

  Widget _buildShimmerDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 410,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(height: 25, width: 350, color: Colors.white),
        ),
        SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(height: 14, width: 150, color: Colors.white),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(height: 14, width: 180, color: Colors.white),
        ),
        SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(height: 14, width: 140, color: Colors.white),
        ),
        SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(height: 14, width: 160, color: Colors.white),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(height: 14, width: 170, color: Colors.white),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(height: 14, width: 170, color: Colors.white),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(height: 14, width: 170, color: Colors.white),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(height: 24, width: 100, color: Colors.white),
        ),
        SizedBox(height: 8),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 16,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: List.generate(
            3,
            (index) => Chip(
              label: Container(width: 50, height: 16, color: Colors.white),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.recipe.image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(widget.recipe.image!),
          ),
        SizedBox(height: 16),
        Text(
          widget.recipe.name ?? 'Untitled',
          style: AppTextStyle.poppinsHeaderRegular30(color: AppColors.neutral),
        ),
        SizedBox(height: 8),
        Text(
          'Cuisine: ${widget.recipe.cuisine ?? 'Unknown'}',
          style: AppTextStyle.poppinsNormalRegular16(color: AppColors.neutral),
        ),
        Text(
          'Difficulty: ${widget.recipe.difficulty ?? 'Unknown'}',
          style: AppTextStyle.poppinsNormalRegular16(color: AppColors.neutral),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Rating: ${widget.recipe.rating?.toStringAsFixed(1) ?? 'N/A'}',
              style: AppTextStyle.poppinsNormalRegular16(
                color: AppColors.neutral,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '(${widget.recipe.reviewCount ?? 0} reviews)',
              style: AppTextStyle.poppinsNormalRegular16(
                color: AppColors.neutral,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Prep Time: ${widget.recipe.prepTimeMinutes ?? 0} minutes',
          style: AppTextStyle.poppinsNormalRegular16(color: AppColors.neutral),
        ),
        Text(
          'Cook Time: ${widget.recipe.cookTimeMinutes ?? 0} minutes',
          style: AppTextStyle.poppinsNormalRegular16(color: AppColors.neutral),
        ),
        Text(
          'Servings: ${widget.recipe.servings ?? 1}',
          style: AppTextStyle.poppinsNormalRegular16(color: AppColors.neutral),
        ),
        Text(
          'Calories per Serving: ${widget.recipe.caloriesPerServing ?? 0} kcal',
          style: AppTextStyle.poppinsNormalRegular16(color: AppColors.neutral),
        ),
        SizedBox(height: 16),
        Text(
          'Ingredients',
          style: AppTextStyle.poppinsMediumBold18(color: AppColors.neutral),
        ),
        SizedBox(height: 8),
        ...widget.recipe.ingredients?.map((ingredient) {
              return Text(
                '- $ingredient',
                style: AppTextStyle.poppinsNormalRegular16(
                  color: AppColors.neutral,
                ),
              );
            }).toList() ??
            [],
        SizedBox(height: 16),
        Text(
          'Instructions',
          style: AppTextStyle.poppinsMediumBold18(color: AppColors.neutral),
        ),
        SizedBox(height: 8),
        ...widget.recipe.instructions?.asMap().entries.map((entry) {
              int index = entry.key + 1;
              String instruction = entry.value;
              return Text(
                '$index. $instruction',
                style: AppTextStyle.poppinsNormalRegular16(
                  color: AppColors.neutral,
                ),
              );
            }).toList() ??
            [],
        SizedBox(height: 16),
        Text(
          'Tags',
          style: AppTextStyle.poppinsMediumBold18(color: AppColors.neutral),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children:
              widget.recipe.tags?.map((tag) {
                return Chip(
                  label: Text(tag, style: AppTextStyle.poppinsSmallBold14()),
                  backgroundColor: AppColors.primaryColor,
                  side: BorderSide.none,
                );
              }).toList() ??
              [],
        ),
      ],
    );
  }
}
