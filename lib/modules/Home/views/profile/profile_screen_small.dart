import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/controller/home_controller.dart';
import 'package:recipe_app/modules/Home/views/profile/format_phone_number.dart';
import 'package:recipe_app/modules/Home/views/profile/item_profile_screen.dart';

class ProfileScreenSmall extends StatelessWidget {
  ProfileScreenSmall({super.key});

  final List<Map<String, dynamic>> profileOptions = [
    {'icon': Icons.edit_outlined, 'title': 'Edit Profile'},
    {'icon': Icons.info_outlined, 'title': 'About Us'},
    {'icon': Icons.phone_outlined, 'title': 'Contact Us'},
    {'icon': Icons.description_outlined, 'title': 'Term Of Use'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return _buildBody(context);
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 25),
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF129575), Color(0xFF0d6f59)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 50,
                child: Text(
                  controller.name.value,
                  style: AppTextStyle.poppinsLargeBold20(),
                ),
              ),
              Positioned(
                bottom: 50,
                child: Text(
                  'Welcome to HONG RECIPES',
                  style: AppTextStyle.poppinsSmallRegular14(),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Text(
                  PhoneNumberFormatter.format(controller.phone.value),
                  style: AppTextStyle.poppinsSmallBold14(),
                ),
              ),
              CircleAvatar(
                radius: 75,
                backgroundColor: Colors.white30,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white24,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage:
                        controller.profileImage.value != null
                            ? FileImage(controller.profileImage.value!)
                            : AssetImage('assets/images/hong_profile.png')
                                as ImageProvider,
                    // AssetImage(
                    //   'assets/images/hong_profile.png',
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Column(
          children: List.generate(profileOptions.length, (index) {
            final option = profileOptions[index];
            return _buildListTile(
              context,
              icon: option['icon'],
              title: option['title'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ItemProfileScreen(
                          index: index,
                          title: option['title'],
                        ),
                  ),
                );
              },
            );
          }),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Sign Out',
                  style: AppTextStyle.poppinsSmallRegular14(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 14, right: 14, top: 14),
      child: Material(
        color: AppColors.primaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primaryColor, size: 28),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle.poppinsNormalRegular16(
                      color: AppColors.neutral,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
