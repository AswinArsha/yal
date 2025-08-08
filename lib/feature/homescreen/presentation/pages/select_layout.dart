import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/constants/tournament_token_service.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/bottom_navigation.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/portal_tile.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_layout.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/permission_dialog.dart';

class SelectLayoutScreen extends StatefulWidget {
  const SelectLayoutScreen({super.key});

  @override
  State<SelectLayoutScreen> createState() => _SelectLayoutScreenState();
}

class _SelectLayoutScreenState extends State<SelectLayoutScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  String? name;
  String? userName;
  @override
  int selectedTileIndex = -1;
  bool isSelected = false;
  Future<void> _loadUser() async {
    final user = await TokenService.getUser();
    setState(() {
      name = user?['name'] ?? 'Guest';
      userName = user?['username'] ?? 'guest_user';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    // Start rotation
    _rotationController.forward();

    _rotationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await _scaleController.forward();
        //  await _audioPlayer.play(AssetSource('sounds/ding.mp3'));
        await _scaleController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1A0825),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg/map_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 1.h),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Logo
                    // App Logo
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/logos/app-logo.png',
                                height: 32),
                            const SizedBox(width: 8),
                            Image.asset('assets/images/logos/app-title.png',
                                height: 32),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: -0.3, duration: 500.ms),

                    const SizedBox(height: 20),

                    // Profile Card
                    // Profile Card with proper border radius relationships
                    Container(
                      padding: const EdgeInsets.all(16), // 16px padding
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(77, 77, 76, 76),
                        borderRadius:
                            BorderRadius.circular(16), // Outer radius: 16px
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage('assets/user.png'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name != null ? '$name' : 'Loading...',
                                      style: AppTextStyles.mediumBold(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    Text(
                                      userName != null
                                          ? '@$userName'
                                          : 'Loading...',
                                      style: AppTextStyles.small(
                                        fontWeight: FontWeight.w400,
                                        size: 12,
                                        color: const Color.fromRGBO(
                                            126, 110, 131, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 5.h,
                                  right: 12.h,
                                  top: 3.h,
                                  bottom: 5.h,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.05),
                                  borderRadius: BorderRadius.circular(34.r),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16.r,
                                      backgroundColor: const Color.fromRGBO(
                                          138, 255, 253, 0.15),
                                      child: Image.asset(
                                        height: 20.h,
                                        'assets/icons/alien.png',
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DID Score',
                                          style: AppTextStyles.small(
                                            fontWeight: FontWeight.w400,
                                            size: 10,
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.6),
                                          ),
                                        ),
                                        TweenAnimationBuilder<int>(
                                          tween: IntTween(begin: 1, end: 120),
                                          duration: const Duration(seconds: 2),
                                          builder: (context, value, child) {
                                            return Text(
                                              '$value',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Badge + XP Progress - FIXED BORDER RADIUS
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(22, 9, 26, 0.3),
                              borderRadius: BorderRadius.circular(
                                  8), // CHANGED FROM 1 TO 8
                              // Formula: innerRadius = outerRadius - padding
                              // 16 (outer) - 8 (visual spacing) = 8 (inner)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Current Level',
                                      style: AppTextStyles.small(
                                        fontWeight: FontWeight.w400,
                                        size: 12,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 0.4),
                                      ),
                                    ),
                                    AnimatedBuilder(
                                      animation: Listenable.merge([
                                        _rotationController,
                                        _scaleController
                                      ]),
                                      builder: (context, child) {
                                        final rotationAngle =
                                            _rotationController.value * 2 * pi;
                                        final scale = _scaleAnimation.value;
                                        return Transform.rotate(
                                          angle: rotationAngle,
                                          child: Transform.scale(
                                            scale: scale,
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        'assets/icons/star_badge.png',
                                        height: 33,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Level 1: Novice Explorer',
                                  style: AppTextStyles.mediumBold(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: 0.02,
                                    minHeight: 8,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.yellow),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '20XP',
                                            style:
                                                TextStyle(color: Colors.yellow),
                                          ),
                                          TextSpan(
                                            text: ' / 1000XP',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      '980 XP Until Level 2',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .scale(duration: 400.ms, curve: Curves.easeOutBack),

                    const SizedBox(height: 24),

                    // Portal Section
                    Text('Portal Selection',
                        style: AppTextStyles.large(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            size: 24)),
                    const SizedBox(height: 8),
                    Text(
                        'Select your favorite section to start \nyour journey with YALGAMERS',
                        style: AppTextStyles.small(
                            color: AppColors.baseWhite.withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            size: 14)),
                    const SizedBox(height: 16),

                    Column(
                      children: [
                        portalTile(
                          borderColor: const Color.fromRGBO(237, 173, 255, 1),
                          isSelected: selectedTileIndex == 0,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const BottomNavigationScreen()),
                            );
                            // setState(() {
                            //   isSelected = true;
                            //   selectedTileIndex = 0;
                            // });
                          },
                          tileColor: const Color.fromRGBO(86, 43, 98, 1),
                          imagePath: 'assets/icons/home.png',
                          iconBgColor: const Color.fromRGBO(188, 90, 215, 0.15),
                          title: 'Play, Match & Progress',
                          subtitle: 'Play, explore, and stay \nengaged.',
                        ),
                        portalTile(
                          borderColor: const Color.fromRGBO(194, 232, 255, 1),
                          isSelected: selectedTileIndex == 1,
                          onTap: () async {
                            final tournamentToken = await TournamentTokenService
                                .getTournamentAccessToken();

                            if (tournamentToken == null) {
                              // Show the access dialog only if token is missing
                              showYalGamersAccessDialog(context);
                            } else {
Navigator.of(context).pop();                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const TournamentLayoutScreen()),
                              );

                              // Optionally update state if needed
                              // setState(() {
                              //   isSelected = true;
                              //   selectedTileIndex = 1;
                              // });
                            }
                          },
                          tileColor: const Color.fromRGBO(81, 114, 135, 0.4),
                          imagePath: 'assets/icons/swords.png',
                          iconBgColor:
                              const Color.fromRGBO(142, 201, 237, 0.15),
                          title: 'E-sports',
                          subtitle:
                              'Join tournaments, and prove \nyour skills.',
                        )
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .slideX(begin: 0.2, duration: 600.ms)
                            .then(delay: 100.ms),
                      ],
                    ),

                    // PrimaryButton(
                    //   label: 'Continue',
                    //   onPressed: () {
                    //     if (selectedTileIndex == 0) {
                    //       // Navigate to BottomNavigationScreen if first tile selected
                    //       Navigator.of(context).push(_createRoute());
                    //     } else if (selectedTileIndex == 1) {
                    //       // Navigate to another screen if second tile selected
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //       builder: (_) => const TournamentListScreen()),
                    //       );
                    //     }
                    //   },
                    //   textColor:
                    //       isSelected ? Colors.black : AppColors.buttonText,
                    //   gradient: isSelected ? buttonGradience() : null,
                    // )
                    //     .animate()
                    //     .scale(duration: 500.ms, curve: Curves.easeOutBack)
                    //     .animate()
                    //     .scale(duration: 500.ms, curve: Curves.easeOutBack),

                    //  const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const BottomNavigationScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var fadeTween = Tween<double>(begin: 0, end: 1);

      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(
          opacity: animation.drive(fadeTween),
          child: child,
        ),
      );
    },
  );
}
