import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/controller/home_controller.dart';
import 'package:recipe_app/modules/Home/widgets/save_recipe_card.dart';
import 'package:recipe_app/modules/item/item_detail.dart';

class SaveRecipeScreenMedium extends StatelessWidget {
  const SaveRecipeScreenMedium({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Saved Recipes"),
        backgroundColor: AppColors.neutral[100],
      ),
      body: Container(
        color: Colors.white,
        child: Obx(
          () =>
              controller.isLoading.value
                  ? SizedBox()
                  : controller.errorMessage.value.isNotEmpty
                  ? Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: AppTextStyle.poppinsSmallRegular14(
                        color: AppColors.neutral,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                  : SmartRefresher(
                    controller: controller.refreshController.value,
                    enablePullDown: true,
                    header: WaterDropHeader(
                      waterDropColor: AppColors.primaryColor,
                    ),
                    onRefresh: controller.onRefresh,
                    child: GridView.builder(
                      padding: EdgeInsets.all(12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: controller.recipeModels.recipes?.length ?? 0,
                      itemBuilder: (context, index) {
                        final recipe = controller.recipeModels.recipes![index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ItemDetail(recipe: recipe));
                          },
                          child: BookmarkCard(recipe: recipe),
                        );
                      },
                    ),
                  ),
        ),
      ),
    );
  }
}
