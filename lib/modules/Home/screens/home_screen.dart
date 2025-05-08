import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/controller/home_controller.dart';
import 'package:recipe_app/modules/Home/models/recipe_models.dart';
import 'package:recipe_app/modules/Home/widgets/card.dart';
import 'package:recipe_app/modules/item/item_detail.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final List<String> tabTitles = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Dessert',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: tabTitles.length,
          child: _buildBodyNested,
        ),
      ),
    );
  }

  get _buildBodyNested {
    var recipeModels = controller.recipeModels.recipes;
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [_buildAppBar],
      body: Obx(
        () =>
            controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                  children:
                      tabTitles.map((category) {
                        final lowerCategory = category.toLowerCase();
                        final recipes =
                            category == 'All'
                                ? recipeModels ?? []
                                : (recipeModels ?? [])
                                    .where(
                                      (recipe) =>
                                          recipe.mealType
                                              ?.toString()
                                              .toLowerCase()
                                              .contains(lowerCategory) ??
                                          false,
                                    )
                                    .toList();

                        return _buildRecipeList(recipes, category);
                      }).toList(),
                ),
      ),
    );
  }

  get _buildAppBar => SliverAppBar(
    floating: false,
    expandedHeight: 220,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    pinned: false,
    flexibleSpace: FlexibleSpaceBar(
      background: Padding(
        padding: EdgeInsets.fromLTRB(24, 70, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Hong',
              style: AppTextStyle.poppinsLargeBold20(color: AppColors.neutral),
            ),
            SizedBox(height: 6),
            Text(
              'What are you cooking today?',
              style: AppTextStyle.poppinsSmallerRegular11(
                color: AppColors.neutral.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: AppTextStyle.poppinsSmallRegular14(
                          color: Colors.grey[700],
                        ),
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey[700]),
                      ),
                      style: AppTextStyle.poppinsSmallRegular14(
                        color: Colors.black,
                      ),
                      onChanged: (query) {},
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.tune, size: 24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(62),
      child: Container(
        color: Colors.white,
        child: TabBar(
          isScrollable: true,
          indicator: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: AppColors.primaryColor[500],
          dividerColor: Colors.transparent,
          labelPadding: EdgeInsets.zero,
          tabs:
              tabTitles.map((title) {
                return Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    ),
  );

  Widget _buildRecipeList(List<Recipe> recipes, String category) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  category,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ItemDetail(recipe: recipe));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: RecipeCard(
                          image: recipe.image ?? '',
                          rating: recipe.rating ?? 0.0,
                          title: recipe.name ?? 'Untitled',
                          time: '${recipe.prepTimeMinutes ?? 0} Mins',
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'New Recipe',
                  style: AppTextStyle.poppinsMediumBold18(
                    color: AppColors.neutral,
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final recipe = recipes[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ItemDetail(recipe: recipe));
                },
                child: RecipeCard(
                  image: recipe.image ?? '',
                  rating: recipe.rating ?? 0.0,
                  title: recipe.name ?? 'Untitled',
                  time: '${recipe.prepTimeMinutes ?? 0} Mins',
                ),
              );
            }, childCount: recipes.length),
          ),
        ),
      ],
    );
  }
}
