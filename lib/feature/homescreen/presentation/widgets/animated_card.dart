import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/feature/achievements/presentation/pages/achievements_screen.dart';
import 'package:yalgamers/feature/community/presentation/pages/community_screen.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/rewards_dialog.dart';
import 'package:yalgamers/feature/leaderboard/presentation/pages/leaderboard_screen.dart';
import 'package:yalgamers/feature/marketplace/presentation/pages/marketplace_screen.dart';
import 'package:yalgamers/feature/rewards/presentation/pages/rewards_page.dart';
import 'package:yalgamers/feature/networking/presentation/pages/networking_screen.dart';
import 'package:yalgamers/feature/wallet/presentation/pages/wallet_screen.dart';

import '../../../../core/theme/text_style.dart';

class AnimatedIconCard extends StatefulWidget {
  const AnimatedIconCard({super.key});

  @override
  State<AnimatedIconCard> createState() => _AnimatedIconCardState();
}

class _AnimatedIconCardState extends State<AnimatedIconCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _rotation = Tween<double>(begin: pi, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // Delay the start slightly to ensure it's visible
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isUnder(double value) => value > pi / 2;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotation,
      builder: (context, child) {
        final angle = _rotation.value;
        final isUnder = _isUnder(angle);

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // 3D perspective
            ..rotateY(angle),
          child: isUnder ? const SizedBox.shrink() : _buildMainCard(context),
        );
      },
    );
  }

  Widget _buildMainCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
              gradient: const LinearGradient(
                colors: [Color(0xFF1E1420), Color(0xFF2C1B2F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 1.1,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _iconTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const RewardsPage(),
                  )),
                  'Rewards',
                  'assets/icons/rewards-icon.png',
                  const Color(0xFFFDEB56),
                ),
                _iconTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => NetworkingScreen(),
                    ));
                  },
                  'Networking',
                  'assets/icons/networking.png',
                  const Color(0xFF8EFF78),
                ),
                _iconTile(
                  'Leaderboard',
                  'assets/icons/leaderboard-icon.png',
                  const Color(0xFF69A9FF),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const LeaderboardScreen(),
                    ));
                  },
                ),
                _iconTile(
                  'Marketplace',
                  'assets/icons/marketplace-icon.png',
                  const Color(0xFF72F0DB),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => MarketplaceScreen(),
                    ));
                  },
                ),
                _iconTile(
                  'Community',
                  'assets/icons/community-icon.png',
                  const Color(0xFFB47EFF),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const CommunityScreen(),
                    ));
                  },
                ),
                _iconTile(
                  'My Wallet',
                  'assets/icons/wallet-icon.png',
                  const Color(0xFFFF829D),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return WalletScreen();
                      },
                    ));
                  },
                ),
              ],
            ),
          ),

          // Top glow
          Positioned(
            top: -90,
            right: -90,
            child: IgnorePointer(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0x00ffffff).withOpacity(0.3),
                      Colors.transparent,
                    ],
                    radius: 0.6,
                  ),
                ),
              ),
            ),
          ),

          // Bottom glow
          Positioned(
            bottom: -90,
            left: -90,
            child: IgnorePointer(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFDEB56).withOpacity(0.3),
                      Colors.transparent,
                    ],
                    radius: 0.6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconTile(
    String label,
    String assetPath,
    Color bgColor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor.withOpacity(0.2),
                border: Border.all(
                  color: bgColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Image.asset(
                assetPath,
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.small(color: Colors.white, size: 12),
            ),
          ],
        ),
      ),
    );
  }
}
