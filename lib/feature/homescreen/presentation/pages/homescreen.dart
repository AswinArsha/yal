import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/constants/common_widgets/notification_dot.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/pages/view_profile.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/animated_card.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/recent_games_card.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/referall_card.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/rewards_button.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/spin_wheel_card.dart';
import 'package:yalgamers/feature/notifications/presentation/pages/notifications.dart';
import 'package:yalgamers/feature/search_screen/presentation/pages/search_screen.dart';
import 'package:badges/badges.dart' as badges;

import '../widgets/community_card.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  const HomeScreen({super.key, required this.scrollController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      body: SafeArea(
        top: true,
        bottom: false,
        child: CustomScrollView(
          controller: widget.scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _HeaderDelegate(
                minHeight: 70,
                maxHeight: 70,
                child: Container(
                  color: const Color(0xFF150B18),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const ViewProfileScreen();
                            },
                          ));
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome Back!',
                              style: AppTextStyles.medium(
                                  color: Colors.white70, size: 12)),
                          Text(userName != null ? '$userName!' : 'Loading...',
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
                            builder: (context) => NotificationsScreen(),
                          ));
                        },
                        child: Image.asset(
                          'assets/images/bg/notification_circle.png',
                          width: 40.w,
                          height: 40.h,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            /// 🔍 Search Bar (scrolls away)
            SliverToBoxAdapter(
              child: Container(
                color: const Color(0xFF150B18),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to your search screen or perform any action
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SearchScreen()), // your screen
                          );
                        },
                        child: AbsorbPointer(
                          // prevent default keyboard behavior
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle:
                                    AppTextStyles.medium(color: Colors.white60),
                                prefixIcon: Image.asset(
                                  'assets/icons/Search.png', // Replace with your image path
                                  width: 10,
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.asset(
                        'assets/icons/Filter.png', // Replace with your image path
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: const Color(0xFF1C121F), // Match background

                child: Divider(
                  height: 1,
                  thickness: .7,
                  color: Colors.white24,
                ),
              ),
            ),
            // 🌟 Main scrollable content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 160,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                      ),
                      items: [
                        'assets/images/logos/carousal-image.png',
                        // You can add more image paths here if needed
                      ].map((imagePath) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AnimatedIconCard(),
                    const SizedBox(
                      height: 10,
                    ),
                    const ReferallCard(), const SizedBox(height: 16),

                    communityCard(),

                    const SizedBox(height: 20),

                    // XP Card
                    spinWheelCard(),

                    const SizedBox(height: 20),

                    // Recently Launched
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recently Launched \nGames',
                            style: AppTextStyles.largeBold(
                                color: const Color.fromRGBO(255, 255, 255, 0.9),
                                size: 20,
                                fontWeight: FontWeight.w600)),
                        Text('See All',
                            style: AppTextStyles.small(
                                color: const Color.fromRGBO(253, 235, 86, 1),
                                size: 14,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    recentGamesCard(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconTile(
    String label,
    String assetPath,
    Color bgColor, {
    VoidCallback? onTap, // optional onTap parameter
  }) {
    return GestureDetector(
      onTap: onTap, // will do nothing if null
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

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  _HeaderDelegate(
      {required this.child, required this.minHeight, required this.maxHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _HeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}
