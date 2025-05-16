import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/config/theme/theme_style.dart';

class RecipeFilterController extends GetxController {
  var selectedTimeFilter = 'All'.obs;
  var selectedRating = 0.obs;
  var selectedCategory = 'All'.obs;

  void setTimeFilter(String filter) => selectedTimeFilter.value = filter;
  void setRating(int rating) => selectedRating.value = rating;
  void setCategory(String category) => selectedCategory.value = category;

  void applyFilters() {
    // Implement filter logic
    Get.back();
  }
}

Future<dynamic> buildPopup() {
  final controller = Get.put(RecipeFilterController());

  return showModalBottomSheet(
    context: Get.context!,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Recipes',
              style: AppTextStyle.poppinsLargeBold20(color: AppColors.neutral),
            ),
            const SizedBox(height: 16),
            Text(
              'Time',
              style: AppTextStyle.poppinsSmallBold14(color: AppColors.neutral),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Row(
                children: [
                  _buildTimeChip('All', controller),
                  const SizedBox(width: 8),
                  _buildTimeChip('Popular', controller),
                  const SizedBox(width: 8),
                  _buildTimeChip('Oldest', controller),
                  const SizedBox(width: 8),
                  _buildTimeChip('Popularity', controller),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Rate',
              style: AppTextStyle.poppinsSmallBold14(color: AppColors.neutral),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    [5, 4, 3, 2, 1].map((rating) {
                      return FilterChip(
                        showCheckmark: false,
                        selectedColor: AppColors.primaryColor,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('$rating'),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ],
                        ),
                        labelStyle: AppTextStyle.poppinsSmallRegular14(
                          color:
                              controller.selectedRating.value == rating
                                  ? Colors.white
                                  : AppColors.neutral,
                        ),
                        selected: controller.selectedRating.value == rating,
                        onSelected: (val) {
                          controller.setRating(val ? rating : 0);
                        },
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Category',
              style: AppTextStyle.poppinsSmallBold14(color: AppColors.neutral),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    ['All', 'Breakfast', 'Lunch', 'Dinner', 'Dessert'].map((
                      category,
                    ) {
                      return FilterChip(
                        showCheckmark: false,
                        selectedColor: AppColors.primaryColor,
                        label: Text(category),
                        labelStyle: AppTextStyle.poppinsSmallRegular14(
                          color:
                              controller.selectedCategory.value == category
                                  ? Colors.white
                                  : AppColors.neutral,
                        ),
                        selected: controller.selectedCategory.value == category,
                        onSelected: (val) {
                          controller.setCategory(val ? category : 'All');
                        },
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: AppColors.primaryColor,
                            width: 1,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: AppTextStyle.poppinsSmallRegular14(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildTimeChip(String label, RecipeFilterController controller) {
  return FilterChip(
    showCheckmark: false,
    selectedColor: AppColors.primaryColor,
    label: Text(label),
    labelStyle: AppTextStyle.poppinsSmallRegular14(
      color:
          controller.selectedTimeFilter.value == label
              ? Colors.white
              : AppColors.neutral,
    ),
    selected: controller.selectedTimeFilter.value == label,
    onSelected: (val) {
      controller.setTimeFilter(val ? label : 'All');
    },
    shape: const StadiumBorder(
      side: BorderSide(color: AppColors.primaryColor, width: 1),
    ),
  );
}
