import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/pages/find_players_history.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/concentric_circles.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/profile_overlaps.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/ripples.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/bottom_navigation.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/animated_card.dart';

import '../widgets/quarter.dart';

class FindPlayersScreen extends StatefulWidget {
  const FindPlayersScreen({super.key});

  @override
  State<FindPlayersScreen> createState() => _FindPlayersScreenState();
}

class _FindPlayersScreenState extends State<FindPlayersScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;
  final List<Tab> myTabs = const [Tab(text: 'Single'), Tab(text: 'Team')];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Create a smooth floating animation
    _floatingAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    // Start the repeating animation
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg/searching.png'),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                ColoredBox(
                  color: AppColors.appBarBackground,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Match Making',
                            style: AppTextStyles.mediumBold(
                              size: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black
                                  .withOpacity(0.5), // optional dim background
                              barrierDismissible: true, // tap outside to close
                              builder: (context) => const Dialog(
                                backgroundColor: Colors
                                    .transparent, // so your card glow shows
                                insetPadding: EdgeInsets.all(
                                    16), // optional margin around card
                                child: AnimatedIconCard(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.white.withAlpha(25),
                              radius: 20,
                              child: Image.asset(
                                'assets/icons/hamburger.png',
                                height: 22.h,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      buildOverlappingAvatars(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(188, 90, 215, 1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          '250+ People Used',
                          style: AppTextStyles.small(
                            size: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.baseWhite.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color.fromRGBO(35, 26, 38, 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icons/clock.png',
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 5),
                              Text('History',
                                  style: AppTextStyles.verySmall(
                                      size: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.baseWhite
                                          .withOpacity(0.9))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 200.h),
                buildRippleSearchButton(),
                const Spacer(),
                // Add padding to prevent overlap with bottom navigation
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextandTab(myTabs: myTabs),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRippleSearchButton() {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 120.h,
        width: double.infinity,
        child: CustomPaint(
          painter: RippleCirclePainter(),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const FindPlayersHistory();
                }));
              },
              child: Image.asset('assets/images/bg/find_players.png')

              //  Container(
              //   width: 80.w,
              //   height: 80.h,
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle,
              //     gradient: LinearGradient(
              //       colors: [
              //         AppColors.xpColor,
              //         Color.fromRGBO(151, 140, 51, 1),
              //       ],
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         color: AppColors.xpColor,
              //         blurRadius: 15,
              //         // spreadRadius: 20,
              //       ),
              //     ],
              //   ),
              //   child: Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           'assets/icons/Search-findplayers.png',
              //           width: 32,
              //           height: 32,
              //           fit: BoxFit.contain,
              //         ),
              //         const SizedBox(height: 4),
              //         Text(
              //           "Find Now",
              //           style: AppTextStyles.mediumBold(
              //             fontWeight: FontWeight.w600,
              //             size: 16,
              //             color: const Color.fromRGBO(66, 61, 17, 1),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              ),
        ),
      ),
    );
  }
}

class RippleCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final Paint ripplePaint = Paint()..style = PaintingStyle.stroke;

    for (int i = 1; i <= 3; i++) {
      final radius = 65.0 + i * 25;
      ripplePaint.color = AppColors.xpColor.withOpacity(0.1 / i);
      ripplePaint.strokeWidth = 1.0;
      canvas.drawCircle(center, radius, ripplePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
