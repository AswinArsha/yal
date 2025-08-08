import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/my_clans_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/my_tournaments_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_leaderboard_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_list_screen.dart';
import 'dart:ui';

class FloatingNavWidget extends StatefulWidget {
  const FloatingNavWidget({super.key});

  @override
  State<FloatingNavWidget> createState() => _FloatingNavWidgetState();
}

class _FloatingNavWidgetState extends State<FloatingNavWidget>
    with TickerProviderStateMixin {
  bool isFloatingNavVisible = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFloatingNav() {
    setState(() {
      isFloatingNavVisible = !isFloatingNavVisible;
    });
    if (isFloatingNavVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

Widget _buildNavButton(String svgPath, Color backgroundColor, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(833),
        color: backgroundColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(833),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(833),
              color: backgroundColor, // This creates the colored overlay
            ),
            child: SvgPicture.asset(
              svgPath,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    ),
  );
}

  Widget _buildCenterButton() {
    return InkWell(
      onTap: _toggleFloatingNav,
      child: Container(
      
        
        child: Container(
         
          width: 48,
          height: 48,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: SvgPicture.asset(
              'assets/bottom_nav/cancel_nav.svg',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isFloatingNavVisible)
          AnimatedBuilder(
            animation: _opacityAnimation,
            builder: (context, child) {
              return GestureDetector(
                onTap: _toggleFloatingNav,
                child: Container(
                  color: Colors.black.withOpacity(0.5 * _opacityAnimation.value),
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),

        if (isFloatingNavVisible)
          Positioned(
            bottom: -70.h,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Center(
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Container(
                        key: const ValueKey('nav_bar'),
                        width: 220.w,
                        height: 220.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Left Column
                            Container(
                              margin: const EdgeInsets.only(top: 32, right: 6),
                              child: Column(
                                children: [
                                  _buildNavButton(
                                    'assets/bottom_nav/map_nav.svg',
                                    const Color(0x2640F293),
                                    () {
                                      _toggleFloatingNav();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const TournamentListScreen(initialTabIndex: 1),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  _buildNavButton(
                                    'assets/bottom_nav/clan_nav.svg',
                                    const Color(0x26FDEB56),
                                    () {
                                      _toggleFloatingNav();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const MyClansScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // Center Column
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              child: Column(
                                children: [
                                  _buildNavButton(
                                    'assets/bottom_nav/sword_nav.svg',
                                    const Color(0x26457BF1),
                                    () {
                                      _toggleFloatingNav();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const TournamentListScreen(initialTabIndex: 0),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  _buildCenterButton(),
                                ],
                              ),
                            ),
                            // Right Column
                            Container(
                              margin: const EdgeInsets.only(top: 32),
                              child: Column(
                                children: [
                                  _buildNavButton(
                                    'assets/bottom_nav/stat_nav.svg',
                                    const Color(0x26FFBF66),
                                    () {
                                      _toggleFloatingNav();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const TournamentLeaderboardScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  _buildNavButton(
                                    'assets/bottom_nav/badge_nav.svg',
                                    const Color(0x26FF6BDD),
                                    () {
                                      _toggleFloatingNav();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const MyTournamentsScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        Positioned(
          bottom: 35.h,
          left: 0,
          right: 0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: !isFloatingNavVisible
                ? Center(
                    child: GestureDetector(
                      key: const ValueKey('fab'),
                      onTap: _toggleFloatingNav,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: AppColors.xpColor,
                        ),
                        child: Image.asset('assets/icons/ham_more.png'),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}