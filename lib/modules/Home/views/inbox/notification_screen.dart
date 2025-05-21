import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _isLoading = true;

  final List<Map<String, dynamic>> notificationList = [
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'New Message',
      'subtitle': 'You received a message from Alice.',
    },
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'Order Shipped',
      'subtitle': 'Your order #1234 has been shipped.',
    },
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'Payment Received',
      'subtitle': 'You received \$250 from Bob.',
    },
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'Event Reminder',
      'subtitle': 'Meeting with client at 10:00 AM.',
    },
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'Friend Request',
      'subtitle': 'Charlie sent you a friend request.',
    },
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'App Update',
      'subtitle': 'Version 2.1 is now available.',
    },
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'Promotion',
      'subtitle': 'Get 20% off your next order!',
    },
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'Task Completed',
      'subtitle': 'You finished the project milestone.',
    },
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'Security Alert',
      'subtitle': 'New login from unknown device.',
    },
    {
      'imageUrl': 'assets/images/profile_app.png',
      'title': 'Subscription Expiring',
      'subtitle': 'Your plan expires in 3 days.',
    },
  ];

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

    //
    Future.delayed(Duration(milliseconds: 400), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color get appBarColor => _isScrolled ? AppColors.primaryColor : Colors.white;

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
                ? _buildShimmer
                : ListView.builder(
                  controller: _scrollController,
                  itemCount: notificationList.length,
                  itemBuilder: (context, index) {
                    final notification = notificationList[index];
                    return NotificationItem(
                      imageUrl: notification['imageUrl'],
                      title: notification['title'],
                      subtitle: notification['subtitle'],
                      onTap: () {},
                    );
                  },
                ),
      ),
    );
  }

  get _buildShimmer {
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
                CircleAvatar(radius: 36),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 10.0,
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
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CircleAvatar(
                //   backgroundImage: AssetImage(imageUrl),
                //   backgroundColor: AppColors.primaryColor,
                //   radius: 25,
                // ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.asset(imageUrl, fit: BoxFit.cover),
                ),
                SizedBox(width: 16),
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
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyle.poppinsSmallRegular12(
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
        SizedBox(height: 8),
        Container(height: 1, width: 350, color: Colors.grey.shade300),
      ],
    );
  }
}
