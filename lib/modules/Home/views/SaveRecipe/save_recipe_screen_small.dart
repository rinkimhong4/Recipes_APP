import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/controller/home_controller.dart';
import 'package:recipe_app/modules/Home/widgets/save_recipe_card.dart';
import 'package:recipe_app/modules/item/item_detail.dart';

class SaveRecipeScreenSmall extends StatefulWidget {
  const SaveRecipeScreenSmall({super.key});

  @override
  State<SaveRecipeScreenSmall> createState() => _SaveRecipeScreenSmallState();
}

class _SaveRecipeScreenSmallState extends State<SaveRecipeScreenSmall> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final isScrolledDown = _scrollController.offset > 10;
      if (isScrolledDown != _isScrolled) {
        setState(() {
          _isScrolled = isScrolledDown;
        });
      }
    });
  }

  Color get appBarColor => _isScrolled ? AppColors.primaryColor : Colors.white;
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Saved Recipes",
          style: TextStyle(color: _isScrolled ? Colors.white : Colors.black),
        ),
        backgroundColor: appBarColor,
        elevation: _isScrolled ? 4 : 0,
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
                      // complete: Container(
                      //   color: AppColors.primaryColor,
                      //   child: Center(
                      //     child: Text(
                      //       'Refresh completed',
                      //       style: AppTextStyle.poppinsSmallRegular14(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // idleIcon: Container(
                      //   color: AppColors.primaryColor,
                      //   child: Icon(Icons.arrow_downward, color: Colors.white),
                      // ),
                    ),
                    onRefresh: controller.onRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(12),
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
