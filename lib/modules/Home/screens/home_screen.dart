import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final List<String> tabTitles = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Dessert',
    'Vegan',
    'Meat',
    'Drink',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(length: 10, child: _buildBodyNested),
      ),
    );
  }

  get _buildBodyNested {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [_buildAppBar];
      },
      body: TabBarView(
        children: List.generate(
          tabTitles.length,
          (index) => Center(child: Text('${tabTitles[index]} Content')),
        ),
      ),
    );
  }

  get _buildAppBar => SliverAppBar(
    expandedHeight: 220,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    flexibleSpace: FlexibleSpaceBar(
      background: Padding(
        padding: EdgeInsets.fromLTRB(24, 70, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Hong',
              style: AppTextStyle.poppinsLargeBold(color: AppColors.neutral),
            ),
            SizedBox(height: 6),
            Text(
              'What are you cooking today?',
              style: AppTextStyle.poppinsSmallerRegular(
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
                        hintStyle: AppTextStyle.poppinsSmallRegular(
                          color: Colors.grey[700],
                        ),
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey[700]),
                      ),
                      style: AppTextStyle.poppinsSmallRegular(
                        color: Colors.black,
                      ),
                      onChanged: (value) {},
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 44,
                      width: 44,
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
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: AppColors.neutral[300],
          dividerColor: Colors.transparent,
          tabs: List.generate(
            tabTitles.length,
            (index) => Tab(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                child: Text(
                  tabTitles[index],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
