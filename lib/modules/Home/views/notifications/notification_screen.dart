import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/views/notifications/new_recipe_notifications.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _isLoading = true;

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final isScrolledDown = _scrollController.offset > 10;
      if (isScrolledDown != _isScrolled) {
        setState(() {
          _isScrolled = isScrolledDown;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  Color get appBarColor => _isScrolled ? AppColors.primaryColor : Colors.white;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appBarColor,
        elevation: _isScrolled ? 4 : 0,
        title: Text(
          'Notifications',
          style: TextStyle(color: _isScrolled ? Colors.white : Colors.black),
        ),
        iconTheme: IconThemeData(
          color: _isScrolled ? Colors.white : Colors.black,
        ),
      ),
      body: Container(
        color: Colors.white,
        child:
            _isLoading
                ? _buildShimmer()
                : SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  header: WaterDropHeader(
                    waterDropColor: AppColors.primaryColor,
                  ),
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) {
                      final notification = notificationList[index];
                      return NotificationItem(
                        imageUrl: notification['imageUrl'] ?? '',
                        title: notification['title'] ?? '',
                        subtitle: notification['subtitle'] ?? '',
                        onTap: () {},
                      );
                    },
                  ),
                ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(radius: 36),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(imageUrl, fit: BoxFit.cover),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.poppinsSmallBold14(
                          color: AppColors.neutral,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyle.poppinsSmallerRegular11(
                          color: AppColors.neutral[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(height: 1, width: 350, color: Colors.grey.shade300),
      ],
    );
  }
}
