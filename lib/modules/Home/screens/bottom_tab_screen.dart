import 'package:flutter/material.dart';
import 'package:recipe_app/modules/Home/screens/bookmark_screen.dart';
import 'package:recipe_app/modules/Home/screens/home_screen.dart';
import 'package:recipe_app/widget/bottom_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;

  final _listPages = [
    HomeScreen(),
    BookmarkScreen(),
    Center(child: Text('Notifications')),
    Center(child: Text('Profile')),
  ];

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
