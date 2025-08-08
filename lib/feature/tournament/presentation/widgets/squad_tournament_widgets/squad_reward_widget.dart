import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class SquadRewardWidget extends StatelessWidget {
  const SquadRewardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tournament Rewards',
            style: AppTextStyles.small(
              color: Colors.white,
              size: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const SquadRewardTile(
            position: "Winning Team",
            xp: "100",
            money: "100",
            icon: "assets/title_reward.jpg", // your gold 1st place image
            bgColor: Color(0xFF271C1A),
          ),
          const SizedBox(height: 12),
          const SquadRewardTile(
            position: "Runners-Up Team",
            xp: "100",
            money: "100",
            icon: "assets/title_reward.jpg", // your silver 2nd place image
            bgColor: Color(0xFF1C1929),
          ),
          const SizedBox(height: 12),
          const SquadRewardTile(
            position: "3rd Place",
            xp: "100",
            money: "100",
            icon: "assets/title_reward.jpg", // your bronze 3rd place image
            bgColor: Color(0xFF1C1929),
          ),
          const Divider(height: 32, color: Color(0xFF2B2B3D)),
          const SquadRewardTile(
            position: "Other Participating Players",
            xp: "100 Each Player",
            money: null,
            icon: "assets/icons/3star.png", // generic icon for users
            bgColor: Color(0xFF1C1929),
          ),
        ],
      ),
    );
  }
}

class SquadRewardTile extends StatelessWidget {
  final String position;
  final String xp;
  final String? money;
  final String icon;
  final Color bgColor;

  const SquadRewardTile({
    super.key,
    required this.position,
    required this.xp,
    this.money,
    required this.icon,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                position,
                style: AppTextStyles.small(
                  color: const Color(0xFFA4A3A9),
                  size: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/xp-icon.png', // Replace with your actual asset path
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$xp',
                    style: AppTextStyles.small(
                      color: Colors.white,
                      size: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (money != null) ...[
                    const SizedBox(width: 12),
                    const Icon(Icons.monetization_on,
                        color: Color(0xFF8EC9ED), size: 18),
                    const SizedBox(width: 4),
                    Text(
                      "$money",
                      style: AppTextStyles.small(color: Colors.white),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
