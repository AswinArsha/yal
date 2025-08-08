import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/rewards_button.dart';
import 'package:yalgamers/feature/notifications/presentation/pages/notifications.dart';

class WelcomeProfileWidget extends StatefulWidget {
  const WelcomeProfileWidget({super.key});

  @override
  State<WelcomeProfileWidget> createState() => _WelcomeProfileWidgetState();
}

class _WelcomeProfileWidgetState extends State<WelcomeProfileWidget> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await TokenService.getUser();
    setState(() {
      userName = user?['name'] ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(21, 11, 24, 1),
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 150, 150, 151).withOpacity(0.2),
            width: 0.5.w, // Using ScreenUtil for responsive width
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/user.png'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back!',
                  style: AppTextStyles.medium(
                      color: Colors.white70, size: 12)),
              Text(
                  userName != null
                      ? '$userName!'
                      : 'Loading...',
                  style: AppTextStyles.medium(
                      color: Colors.white,
                      size: 16,
                      fontWeight: FontWeight.bold))
            ],
          ),
          const Spacer(),
          const RewardsCard(),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotificationsScreen()));
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.3),
              radius: 20,
              child: Image.asset(
                'assets/icons/Notification.png',
                width: 20,
                height: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}