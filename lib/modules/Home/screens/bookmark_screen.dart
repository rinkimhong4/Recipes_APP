import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/modules/Home/controller/home_controller.dart';
import 'package:recipe_app/modules/Home/widgets/bookmark_card.dart';
import 'package:recipe_app/modules/item/item_detail.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Saved Recipes"),
      ),
      body: Obx(() {
        var recipes = controller.recipeModels.recipes ?? [];
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ItemDetail(recipe: recipe));
                  },
                  child: BookmarkCard(recipe: recipe),
                );
              },
            );
      }),
    );
  }
}
