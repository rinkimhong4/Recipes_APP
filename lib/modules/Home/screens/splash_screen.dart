import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/auth/login/login_screen.dart';
import 'package:recipe_app/widget/button_custom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/BGSplashScreen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black26, Colors.black87],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: 160,
            right: 0,
            left: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/hong_profile.png'),
                ),
                SizedBox(height: 14),
                Text(
                  '100K+ Premium Recipe ',
                  style: AppTextStyle.poppinsLargeRegular20(),
                ),
                SizedBox(height: 222),
                Text('Get ', style: AppTextStyle.poppinsTitleBoldBig50()),
                Text('Cooking', style: AppTextStyle.poppinsTitleBoldBig50()),
                SizedBox(height: 20),
                Text(
                  'Simple way to find Tasty Recipe',
                  style: AppTextStyle.poppinsNormalRegular16(),
                ),
                SizedBox(height: 60),
                NavButton(
                  context,
                  label: 'Start Cooking',
                  icon: Icons.chevron_right,
                  width: 250,
                  height: 54,
                  textStyle: AppTextStyle.poppinsNormalBold16(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
