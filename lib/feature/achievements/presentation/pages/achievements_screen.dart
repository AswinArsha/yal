import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/achievements/presentation/widgets/badge_card.dart';
import 'package:yalgamers/feature/achievements/presentation/widgets/wallet_not_connected_dialog.dart';
import 'package:yalgamers/feature/achievements/presentation/widgets/wallet_option_tile.dart';
import 'package:yalgamers/feature/achievements/presentation/widgets/wallet_selection_dialog.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C121F),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF322A35),
              ),
              padding: const EdgeInsets.all(8),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
        title: Text(
          "Achievements",
          style: AppTextStyles.small(
              size: 12, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "My Achievements",
            style: AppTextStyles.medium(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          sectionHeader("Badges"),
          const SizedBox(height: 10),
          BadgeCard(
            image: 'assets/images/logos/Og-badge.png',
            status: "Claimed",
            title: "OG Badge",
            subtitle: "Earned on 11 March, 2024",
            isClaimed: true,
          ),
          BadgeCard(
            image: 'assets/images/logos/Og-badge.png',
            status: "Claimed",
            title: "OG Badge",
            subtitle: "Earned on 11 March, 2024",
            isClaimed: true,
          ),
          BadgeCard(
            buttonTextColor: const Color(0xFF1D2A33),
            icon: Icons.check_circle,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => WalletSelectionDialog(),
              );
            },
            image: 'assets/images/logos/Og-badge.png',
            status: "Claimable",
            title: "OG Badge",
            subtitle: "",
            isClaimed: false,
            buttonLabel: "Claim Now",
          ),
          const SizedBox(height: 24),
          sectionHeader("Project Task NFT"),
          const SizedBox(height: 10),
          BadgeCard(
            image: 'assets/freefire-image.png',
            status: "Claimed",
            title: "Yalgamers x Shockwaves",
            subtitle: "",
            isClaimed: true,
            buttonLabel: "Send NFT",
            buttonColor: const Color(0xFFB8E4FF),
            buttonTextColor: const Color(0xFF1D2A33),
            icon: Icons.arrow_outward,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const WalletNotConnectedDialog(),
              );
            },
          ),
          BadgeCard(
            image: 'assets/freefire-image.png',
            status: "Claimed",
            title: "Yalgamers x Shockwaves",
            subtitle: "",
            isClaimed: true,
            buttonLabel: "Send NFT",
            buttonColor: const Color(0xFFB8E4FF),
            buttonTextColor: const Color(0xFF1D2A33),
            icon: Icons.arrow_outward,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const WalletNotConnectedDialog(),
              );
            },
          ),
          BadgeCard(
            image: 'assets/freefire-image.png',
            status: "Claimable",
            title: "Yalgamers x Shockwaves",
            subtitle: "",
            isClaimed: false,
            buttonLabel: "Claim Now",
            buttonTextColor: const Color(0xFF1D2A33),
            icon: Icons.check_circle,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const WalletNotConnectedDialog(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.small(
              size: 16, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        Text(
          "See All",
          style: AppTextStyles.small(
              size: 14, color: Colors.yellow, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
