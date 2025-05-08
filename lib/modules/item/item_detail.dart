import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/models/recipe_models.dart';

class ItemDetail extends StatefulWidget {
  final Recipe recipe;
  const ItemDetail({super.key, required this.recipe});
  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe.name ?? 'Recipe Detail')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.recipe.image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(widget.recipe.image!),
                ),
              SizedBox(height: 16),
              Text(
                widget.recipe.name ?? 'Untitled',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Cuisine: ${widget.recipe.cuisine ?? 'Unknown'}',
                style: AppTextStyle.poppinsNormalRegular16(
                  color: AppColors.neutral,
                ),
              ),
              Text(
                'Difficulty: ${widget.recipe.difficulty ?? 'Unknown'}',
                style: AppTextStyle.poppinsNormalRegular16(
                  color: AppColors.neutral,
                ),
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
                style: AppTextStyle.poppinsNormalRegular16(
                  color: AppColors.neutral,
                ),
              ),
              Text(
                'Cook Time: ${widget.recipe.cookTimeMinutes ?? 0} minutes',
                style: AppTextStyle.poppinsNormalRegular16(
                  color: AppColors.neutral,
                ),
              ),
              Text(
                'Servings: ${widget.recipe.servings ?? 1}',
                style: AppTextStyle.poppinsNormalRegular16(
                  color: AppColors.neutral,
                ),
              ),
              Text(
                'Calories per Serving: ${widget.recipe.caloriesPerServing ?? 0} kcal',
                style: AppTextStyle.poppinsNormalRegular16(
                  color: AppColors.neutral,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Ingredients',
                style: AppTextStyle.poppinsMediumBold18(
                  color: AppColors.neutral,
                ),
              ),
              SizedBox(height: 8),
              ...widget.recipe.ingredients?.map((ingredient) {
                    return Text(
                      '- $ingredient',
                      style: TextStyle(fontSize: 16),
                    );
                  }).toList() ??
                  [],
              SizedBox(height: 16),
              Text(
                'Instructions',
                style: AppTextStyle.poppinsMediumBold18(
                  color: AppColors.neutral,
                ),
              ),
              SizedBox(height: 8),
              ...widget.recipe.instructions?.map((instruction) {
                    return Text(
                      '${widget.recipe.instructions?.indexOf(instruction) ?? 0 + 1}. $instruction',
                      style: TextStyle(fontSize: 16),
                    );
                  }).toList() ??
                  [],
              SizedBox(height: 16),
              Text(
                'Tags',
                style: AppTextStyle.poppinsMediumBold18(
                  color: AppColors.neutral,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children:
                    widget.recipe.tags?.map((tag) {
                      return Chip(
                        label: Text(
                          tag,
                          style: AppTextStyle.poppinsSmallBold14(),
                        ),
                        backgroundColor: AppColors.primaryColor,
                        side: BorderSide.none,
                      );
                    }).toList() ??
                    [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
