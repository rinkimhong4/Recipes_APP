import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:recipe_app/modules/Home/models/recipe_models.dart';

class BookmarkCard extends StatefulWidget {
  final Recipe recipe;

  const BookmarkCard({super.key, required this.recipe});

  @override
  State<BookmarkCard> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        isLoading = false;
      });
    });
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 160, width: double.infinity, color: Colors.white),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Container(height: 16, width: 120, color: Colors.white),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Container(height: 12, width: 200, color: Colors.white),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: List.generate(
                3,
                (_) => Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Container(height: 12, width: 60, color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    var recipe = widget.recipe;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          child: SizedBox(
            height: 160,
            child: PageView.builder(
              itemCount: 2,
              itemBuilder:
                  (context, index) => Image.network(
                    recipe.image ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            recipe.name ?? "No name",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            " ${recipe.mealType?.join(" • ") ?? ''}",
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: AppColors.neutral[500]),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              ...List.generate(
                5,
                (_) => Icon(Icons.star, size: 16, color: AppColors.ratingColor),
              ),
              SizedBox(width: 4),
              Text(
                recipe.rating?.toStringAsFixed(1) ?? "0.0",
                style: AppTextStyle.poppinsSmallRegular12(
                  color: AppColors.neutral,
                ),
              ),
              SizedBox(width: 6),
              Text(
                "${recipe.reviewCount ?? 0}+ Ratings",
                style: AppTextStyle.poppinsSmallRegular12(
                  color: AppColors.neutral[600],
                ),
              ),
              SizedBox(width: 12),
              Icon(Icons.access_time, size: 17, color: AppColors.neutral[400]),
              SizedBox(width: 4),
              Text(
                "${(recipe.prepTimeMinutes ?? 0) + (recipe.cookTimeMinutes ?? 0)} Min",
                style: AppTextStyle.poppinsSmallRegular12(
                  color: AppColors.neutral,
                ),
              ),
              SizedBox(width: 12),
              SizedBox(width: 4),
              Text(
                "Enjoy your day!",
                style: AppTextStyle.poppinsSmallRegular12(
                  color: AppColors.neutral,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
