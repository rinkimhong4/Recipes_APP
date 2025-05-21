import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

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
        child: ListView.builder(
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
                CircleAvatar(
                  // backgroundImage: NetworkImage(imageUrl),
                  backgroundImage: AssetImage(imageUrl),
                  backgroundColor: Colors.amber,
                  radius: 25,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14),
        Container(height: 1, width: 350, color: Colors.grey.shade300),
      ],
    );
  }
}
