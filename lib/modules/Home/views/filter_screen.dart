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
    Get.back();
  }
}

Future<dynamic> buildPopup() {
  final controller = Get.put(RecipeFilterController());

  return showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      final screenSize = MediaQuery.of(context).size;
      final bool isSmallScreen = screenSize.height < 600;
      final double maxHeight =
          isSmallScreen ? screenSize.height : screenSize.height * 0.7;
      final double padding = screenSize.width * 0.05;
      final double fontScale = screenSize.width < 600 ? 0.9 : 1.0;

      return Container(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          minHeight:
              isSmallScreen ? screenSize.height * 0.8 : screenSize.height * 0.5,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding).copyWith(
              bottom: padding + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Recipes',
                  style: AppTextStyle.poppinsLargeBold20(
                    color: AppColors.neutral,
                  ).copyWith(fontSize: 20 * fontScale),
                ),
                SizedBox(height: padding * 0.5),
                Text(
                  'Time',
                  style: AppTextStyle.poppinsSmallBold14(
                    color: AppColors.neutral,
                  ).copyWith(fontSize: 14 * fontScale),
                ),
                SizedBox(height: padding * 0.25),
                Obx(
                  () => Wrap(
                    spacing: padding * 0.5,
                    runSpacing: padding * 0.5,
                    children: [
                      _buildTimeChip('All', controller, fontScale),
                      _buildTimeChip('Popular', controller, fontScale),
                      _buildTimeChip('Oldest', controller, fontScale),
                      _buildTimeChip('Popularity', controller, fontScale),
                    ],
                  ),
                ),
                SizedBox(height: padding * 0.5),
                Text(
                  'Rate',
                  style: AppTextStyle.poppinsSmallBold14(
                    color: AppColors.neutral,
                  ).copyWith(fontSize: 14 * fontScale),
                ),
                SizedBox(height: padding * 0.25),
                Obx(
                  () => Wrap(
                    spacing: padding * 0.5,
                    runSpacing: padding * 0.5,
                    children:
                        [5, 4, 3, 2, 1].map((rating) {
                          return FilterChip(
                            showCheckmark: false,
                            selectedColor: AppColors.primaryColor,
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('$rating'),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18 * fontScale,
                                ),
                              ],
                            ),
                            labelStyle: AppTextStyle.poppinsSmallRegular14(
                              color:
                                  controller.selectedRating.value == rating
                                      ? Colors.white
                                      : AppColors.neutral,
                            ).copyWith(fontSize: 14 * fontScale),
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
                SizedBox(height: padding * 0.5),
                Text(
                  'Category',
                  style: AppTextStyle.poppinsSmallBold14(
                    color: AppColors.neutral,
                  ).copyWith(fontSize: 14 * fontScale),
                ),
                SizedBox(height: padding * 0.25),
                Obx(
                  () => Wrap(
                    spacing: padding * 0.5,
                    runSpacing: padding * 0.5,
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
                            ).copyWith(fontSize: 14 * fontScale),
                            selected:
                                controller.selectedCategory.value == category,
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
                SizedBox(height: padding),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton(
                    onPressed: controller.applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: padding * 0.5),
                    ),
                    child: Text(
                      'Apply',
                      style: AppTextStyle.poppinsSmallRegular14(
                        color: Colors.white,
                      ).copyWith(fontSize: 14 * fontScale),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildTimeChip(
  String label,
  RecipeFilterController controller,
  double fontScale,
) {
  return FilterChip(
    showCheckmark: false,
    selectedColor: AppColors.primaryColor,
    label: Text(label),
    labelStyle: AppTextStyle.poppinsSmallRegular14(
      color:
          controller.selectedTimeFilter.value == label
              ? Colors.white
              : AppColors.neutral,
    ).copyWith(fontSize: 14 * fontScale),
    selected: controller.selectedTimeFilter.value == label,
    onSelected: (val) {
      controller.setTimeFilter(val ? label : 'All');
    },
    shape: StadiumBorder(
      side: BorderSide(color: AppColors.primaryColor, width: 1),
    ),
  );
}
