import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/config/theme/theme_style.dart';

class InboxController extends GetxController {
  final inboxItems =
      <Map<String, dynamic>>[
        {'icon': Icons.access_alarm_outlined, 'title': 'Reminder'},
        {'icon': Icons.message, 'title': 'New Message'},
      ].obs;
}

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Inbox',
          style: AppTextStyle.poppinsLargeRegular20(color: AppColors.neutral),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final controller = Get.put(InboxController());
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemCount: controller.inboxItems.length,
        itemBuilder: (context, index) {
          final item = controller.inboxItems[index];
          return _buildListTile(
            context,
            icon: item['icon'],
            title: item['title'],
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Material(
        color: AppColors.primaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        elevation: 2,
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
