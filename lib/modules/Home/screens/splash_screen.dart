import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/screens/home_screen.dart';

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
        // Use Stack to layer widgets
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://wallpapers.com/images/hd/android-food-background-2160-x-3840-syqu229ro3tr8nt9.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black45, Colors.black87],
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
                  style: AppTextStyle.poppinsLargeRegular(),
                ),
                SizedBox(height: 222),
                Text('Get ', style: AppTextStyle.poppinsTitleBoldBig()),
                Text('Cooking', style: AppTextStyle.poppinsTitleBoldBig()),
                SizedBox(height: 20),
                Text(
                  'Simple way to find Tasty Recipe',
                  style: AppTextStyle.poppinsNormalRegular(),
                ),
                SizedBox(height: 60),
                _buildNavButton(
                  context,
                  label: 'Start Cooking',
                  icon: Icons.arrow_forward_ios,
                  width: 250,
                  height: 60,
                  textStyle: AppTextStyle.poppinsNormalBold(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
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

  Widget _buildNavButton(
    BuildContext context, {
    required String label,
    IconData? icon,
    VoidCallback? onPressed,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.neutral[100],
          textStyle: textStyle ?? AppTextStyle.poppinsSmallRegular(),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            const SizedBox(width: 9),
            Icon(icon, color: AppColors.neutral[100], size: 24),
          ],
        ),
      ),
    );
  }
}
