import 'package:flutter/material.dart';
import 'package:recipe_app/config/function/responsive/main_responsive.dart';
import 'package:recipe_app/modules/Home/screens/profile_screen_small.dart';
import 'package:recipe_app/modules/Home/screens/save_recipe_screen_medium.dart';
import 'package:recipe_app/modules/Home/screens/save_recipe_screen_small.dart';
import 'package:recipe_app/modules/Home/screens/home_screen_small.dart';
import 'package:recipe_app/modules/Home/screens/home_screen_medium.dart'; // 👈 Add this
import 'package:recipe_app/widget/bottom_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;
  final List<Widget> _listPages = [];

  @override
  void initState() {
    super.initState();
    _listPages.addAll([
      MainResponsive(small: HomeScreenSmall(), medium: HomeScreenMedium()),
      MainResponsive(
        small: SaveRecipeScreenSmall(),
        medium: SaveRecipeScreenMedium(),
      ),

      const Center(child: Text('Notifications')),
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
