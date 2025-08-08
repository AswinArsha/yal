import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/core/constants/token_service.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({super.key});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

 
class _ProfileDialogState extends State<ProfileDialog> {
String? name;
  String? userName;
  
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  
   Future<void> _loadUser() async {
    final user = await TokenService.getUser();
    setState(() {
      name = user?['name'] ?? 'Guest';
      userName=user?['username']??'guest_user';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Header
                          Text(
                            'My Profile',
                            style: AppTextStyles.largeBold(
                              color: AppColors.baseWhite.withOpacity(0.9),
                              size: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Profile Avatar (Large)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 24,
                                backgroundImage: AssetImage('assets/user.png'),
                              ),
                              const SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        name??'Guest',
                                        style: AppTextStyles.largeBold(
                                          color: AppColors.baseWhite
                                              .withOpacity(0.9),
                                          size: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.verified,
                                        color: AppColors.xpColor,
                                        size: 14,
                                      )
                                    ],
                                  ),
                                  Text(
                                    userName??'guest_user',
                                    style: AppTextStyles.medium(
                                      color:
                                          AppColors.baseWhite.withOpacity(0.6),
                                      size: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 6),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Stats Row
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const SubscribersDialog(),
                                    );
                                  },
                                  child: _buildStatColumn(
                                    'Total Subscribers',
                                    '572',
                                    isClickable: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: _buildStatColumn(
                                  'My Memberships',
                                  '31',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Action Buttons
                          Container(
                            width: double.infinity,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.xpColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'View My Marketplace Profile',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          Container(
                            width: double.infinity,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B5CF6).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF8B5CF6).withOpacity(0.3),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'View My Collections',
                                style: TextStyle(
                                  color: Color(0xFF8B5CF6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Recent Subscriptions
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String title, String value,
      {bool isClickable = false}) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.baseWhite.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Container(
          decoration: isClickable
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.xpColor.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                )
              : null,
          child: Text(
            value,
            style: TextStyle(
              color: isClickable ? AppColors.xpColor : AppColors.baseWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// Subscribers Dialog - Second Dialog
class SubscribersDialog extends StatelessWidget {
  const SubscribersDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final subscribers = [
      {'name': 'Mousa Al Khoury', 'time': 'Today on 12:32', 'verified': true},
      {'name': 'Mousa Al Khoury', 'time': 'Today on 12:32', 'verified': false},
      {'name': 'Mousa Al Khoury', 'time': 'Today on 12:32', 'verified': false},
      {'name': 'Mousa Al Khoury', 'time': 'Today on 12:32', 'verified': false},
      {'name': 'Mousa Al Khoury', 'time': 'Today on 12:32', 'verified': false},
      {'name': 'Mousa Al Khoury', 'time': 'Today on 12:32', 'verified': false},
      {'name': 'Mousa Al Khoury', 'time': 'Today on 12:32', 'verified': false},
    ];

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A).withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => const ProfileDialog(),
                      );
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.baseWhite.withOpacity(0.7),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Creating a Post',
                    style: TextStyle(
                      color: AppColors.baseWhite.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColors.baseWhite.withOpacity(0.7),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  _buildTab('Explore', false),
                  const SizedBox(width: 24),
                  _buildTab('My Posts', false),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.tune,
                        color: AppColors.baseWhite.withOpacity(0.6),
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: AppColors.baseWhite.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Subscribers Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'My Subscribers',
                    style: TextStyle(
                      color: AppColors.baseWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: AppColors.baseWhite.withOpacity(0.7),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Subscribers List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: subscribers.length,
                itemBuilder: (context, index) {
                  final subscriber = subscribers[index];
                  return _buildSubscriberTile(
                    subscriber['name'] as String,
                    subscriber['time'] as String,
                    subscriber['verified'] as bool,
                  );
                },
              ),
            ),

            // Bottom Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // MR. Beast section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.xpColor,
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/mr_beast.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFF2A2A2A),
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.baseWhite.withOpacity(0.5),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, bool isActive) {
    return Text(
      title,
      style: TextStyle(
        color: isActive
            ? AppColors.baseWhite
            : AppColors.baseWhite.withOpacity(0.6),
        fontSize: 14,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
      ),
    );
  }

  Widget _buildSubscriberTile(String name, String time, bool isVerified) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isVerified
                    ? AppColors.xpColor
                    : AppColors.baseWhite.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/subscriber_avatar.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF2A2A2A),
                    child: Icon(
                      Icons.person,
                      color: AppColors.baseWhite.withOpacity(0.5),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: AppColors.baseWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (isVerified) ...[
                      const SizedBox(width: 6),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.xpColor,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    color: AppColors.baseWhite.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
