import 'package:flutter/material.dart';
import 'package:recipe_app/config/function/responsive/main_responsive.dart';
import 'package:recipe_app/modules/Home/binding/home_binding.dart';
import 'package:recipe_app/modules/Home/views/notifications/notification_screen.dart';
import 'package:recipe_app/modules/Home/views/profile/profile_binding.dart';
import 'package:recipe_app/modules/Home/views/profile/profile_screen_small.dart';
import 'package:recipe_app/modules/Home/views/SaveRecipe/save_recipe_screen_medium.dart';
import 'package:recipe_app/modules/Home/views/SaveRecipe/save_recipe_screen_small.dart';
import 'package:recipe_app/modules/Home/views/home_screen_small.dart';
import 'package:recipe_app/modules/Home/views/home_screen_medium.dart'; // 👈 Add this
import 'package:recipe_app/widget/bottom_navigation.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedPage = 0;
  final List _listPages = [];

  @override
  void initState() {
    super.initState();
    ProfileBinding().dependencies();
    HomeBinding().dependencies();
    _listPages.addAll([
      MainResponsive(small: HomeScreenSmall(), medium: HomeScreenMedium()),
      MainResponsive(
        small: SaveRecipeScreenSmall(),
        medium: SaveRecipeScreenMedium(),
      ),
      NotificationScreen(),
      ProfileScreenSmall(),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPages[_selectedPage],
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedPage,
        onTap: _onItemTapped,
      ),
    );
  }
}
