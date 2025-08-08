import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C121F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Group Details',
          style: AppTextStyles.small(color: Colors.white, size: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: () {
                  _showLeaveGroupDialog(context);
                },
                icon: const Icon(Icons.logout,
                    color: Colors.pinkAccent, size: 18),
                label: Text(
                  'Leave Group',
                  style:
                      AppTextStyles.small(color: Colors.pinkAccent, size: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(
                  'assets/profile-networking.jpg'), // replace with actual image
            ),
            const SizedBox(height: 12),
            Text(
              'Shockwaves Ai',
              style: AppTextStyles.small(
                  color: Colors.white, size: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Created on 02 Jun, 2024',
              style: AppTextStyles.small(color: Colors.grey, size: 12),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2633),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.group, size: 14, color: Colors.blue),
                      SizedBox(width: 4),
                      Text('21 Members',
                          style: AppTextStyles.small(
                              color: Colors.white, size: 12)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2633),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 12, color: Colors.green),
                      SizedBox(width: 4),
                      Text('12 Online',
                          style: AppTextStyles.small(
                              color: Colors.white, size: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1C121F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About This Project',
                    style: AppTextStyles.small(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Shockwaves uses crypto and AIs to democratize e-sport through a sustainable economic system. Immerse yourself in colorful 8V8 battles and earn your rewards.',
                    style: AppTextStyles.small(color: Colors.grey, size: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Social Media',
                style: AppTextStyles.small(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var icon in [
                  Icons.telegram,
                  Icons.language,
                  Icons.facebook,
                  Icons.camera_alt,
                  Icons.discord,
                  Icons.sports_esports
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(icon, size: 18, color: Colors.black),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Group Members',
                  style: AppTextStyles.small(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  '21 Members',
                  style: AppTextStyles.small(color: Colors.grey, size: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                          Text(
                            'Ali Haninah',
                            style: AppTextStyles.small(color: Colors.white),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Joined Today',
                            style: AppTextStyles.small(
                                color: Colors.grey, size: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showLeaveGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C121F),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Are you sure you want to leave this group?',
            style: AppTextStyles.small(
                color: Colors.white, fontWeight: FontWeight.bold, size: 16),
          ),
          content: Text(
            'If you leave this group, you will not be able to join this group anymore.',
            style: AppTextStyles.small(color: Colors.grey, size: 13),
          ),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close, color: Colors.white),
              label: Text(
                'Cancel',
                style: AppTextStyles.small(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF2B2B2B),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                // Call leave group logic here
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: Text(
                'Leave Group',
                style: AppTextStyles.small(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        );
      },
    );
  }
}
