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
  final int currentTabIndex;
  
  const FloatingNavWidget({super.key, this.currentTabIndex = 0});

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

  // Pre-rendered blur widget for each icon position
  Widget _buildPreRenderedBlur({required double left, required double top}) {
    return Positioned(
      left: left,
      top: top,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String svgPath, Color backgroundColor, VoidCallback onTap, {bool isActive = false, Color? activeColor, Color? activeIconColor}) {
    final Color bgColor = isActive && activeColor != null ? activeColor : backgroundColor;
    
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(833),
          color: bgColor,
        ),
        child: SvgPicture.asset(
          svgPath,
          fit: BoxFit.contain,
          color: isActive && activeIconColor != null ? activeIconColor : null,
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return InkWell(
      onTap: _toggleFloatingNav,
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
                  color: Colors.black.withOpacity(0.7 * _opacityAnimation.value),
                ),
              );
            },
          ),

        // Pre-rendered blur layer - always present but controlled by opacity
        if (isFloatingNavVisible)
          Positioned(
            bottom: -70.h,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, child) {
                return Center(
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Container(
                        width: 240.w,
                        height: 240.h,
                        child: Stack(
                          children: [
                            // Pre-rendered blur spots for each icon position
                            _buildPreRenderedBlur(left: 40.w, top: 32.h), // Map icon
                            _buildPreRenderedBlur(left: 40.w, top: 90.h), // Clan icon
                            _buildPreRenderedBlur(left: 96.w, top: 0.h),  // Sword icon
                            _buildPreRenderedBlur(left: 150.w, top: 32.h), // Stats icon
                            _buildPreRenderedBlur(left: 151.w, top: 90.h), // Badge icon
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
                        width: 240.w, 
                        height: 240.h,
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
                                          builder: (context) => const TournamentListScreen(initialTabIndex: 0),
                                        ),
                                      );
                                    },
                                    isActive: widget.currentTabIndex == 0,
                                    activeColor: const Color(0xFF40F293),
                                    activeIconColor: Colors.white,
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      _toggleFloatingNav();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const MyClansScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(833),
                                        color: widget.currentTabIndex == 3 
                                          ? const Color(0xFFFDEB56) 
                                          : const Color(0x26FDEB56),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/bottom_nav/clan_nav.svg',
                                        fit: BoxFit.contain,
                                        color: widget.currentTabIndex == 3 
                                          ? const Color(0xFF302D12) 
                                          : null,
                                      ),
                                    ),
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
                                          builder: (context) => const TournamentListScreen(initialTabIndex: 1),
                                        ),
                                      );
                                    },
                                    isActive: widget.currentTabIndex == 1,
                                    activeColor: const Color(0xFF457CF1),
                                    activeIconColor: Colors.white,
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
                                  // Stat nav button
                                  GestureDetector(
                                    onTap: () {
                                      _toggleFloatingNav();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const TournamentLeaderboardScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(833),
                                        color: widget.currentTabIndex == -1 
                                          ? const Color(0xFFFFBF66) 
                                          : const Color(0x26FFBF66),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/bottom_nav/stat_nav.svg',
                                        fit: BoxFit.contain,
                                        color: widget.currentTabIndex == -1 
                                          ? Colors.white 
                                          : null,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      _toggleFloatingNav();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const MyTournamentsScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(833),
                                        color: widget.currentTabIndex == 2 
                                          ? const Color(0xFFFF6BDD) 
                                          : const Color(0x26FF6BDD),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/bottom_nav/badge_nav.svg',
                                        fit: BoxFit.contain,
                                        color: widget.currentTabIndex == 2 
                                          ? const Color(0xFFFFFFFF) 
                                          : null,
                                      ),
                                    ),
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