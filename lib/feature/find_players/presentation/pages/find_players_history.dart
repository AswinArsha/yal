import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/detail_profile.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/other_profile.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/profile_overlaps.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';

class FindPlayersHistory extends StatefulWidget {
  const FindPlayersHistory({super.key});

  @override
  State<FindPlayersHistory> createState() => _FindPlayersHistoryState();
}

class _FindPlayersHistoryState extends State<FindPlayersHistory>
    with TickerProviderStateMixin {
  bool showSecondContent = false;
  late AnimationController _rippleController;
  late List<AnimationController> _individualRippleControllers;
  late List<Animation<double>> _rippleAnimations;

  // Add floating animation controller and animation
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  final int maxRipples = 6;
  final double rippleInterval = 0.5; // Time between each ripple in seconds

  final List<Map<String, String>> items = [
    {"title": "Level", "subtitle": "10"},
    {"title": "Rank", "subtitle": "Master"},
    {"title": "Favourite Game", "subtitle": "Shooter"},
    {"title": "Did Score", "subtitle": "1299439"},
    {"title": "XP", "subtitle": "150000"},
    {"title": "Achievements", "subtitle": "04"},
  ];

  @override
  void initState() {
    super.initState();

    // Initialize individual controllers for each ripple
    _individualRippleControllers = List.generate(maxRipples, (index) {
      return AnimationController(
        duration: const Duration(seconds: 5),
        vsync: this,
      );
    });

    // Create animations for each ripple
    _rippleAnimations = _individualRippleControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));
    }).toList();

    // Initialize floating animation controller
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

    // Start the repeating floating animation
    _floatingController.repeat(reverse: true);

    // Start ripples sequentially
    _startSequentialRipples();

    // Trigger content switch after 10 seconds
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          showSecondContent = true;
        });
      }
    });
  }

  void _startSequentialRipples() {
    for (int i = 0; i < maxRipples; i++) {
      Future.delayed(
          Duration(milliseconds: (i * rippleInterval * 1000).round()), () {
        if (mounted) {
          _individualRippleControllers[i].repeat();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _individualRippleControllers) {
      controller.dispose();
    }
    _floatingController
        .dispose(); // Don't forget to dispose the floating controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/searching.png'),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: showSecondContent
                      ? _buildSecondContent()
                      : _buildInitialContent(),
                ),
              ),
            ),
            // Searching animation - completely separate from AnimatedSwitcher
            if (!showSecondContent)
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Sequential ripple circles
                    ...List.generate(maxRipples, (index) {
                      return AnimatedBuilder(
                        animation: _rippleAnimations[index],
                        builder: (context, child) {
                          // Start from the container size and expand outward with proper spacing
                          double baseSize = 180 +
                              (index *
                                  60); // Start closer but with more spacing
                          double animatedSize = baseSize +
                              (100 *
                                  _rippleAnimations[index]
                                      .value); // Larger expansion

                          return Container(
                            width: animatedSize,
                            height: animatedSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF3E321F).withOpacity(
                                  (0.5 - (index * 0.06)) *
                                      (1 - _rippleAnimations[index].value),
                                ),
                                width: 1.0,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    // Static circle border (positioned absolutely to avoid animation)
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFDEB56),
                          width: 8,
                        ),
                      ),
                    ),
                    // Center image with floating animation
                    AnimatedBuilder(
                      animation: _floatingAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -_floatingAnimation.value),
                          child: Image.asset(
                            'assets/find-players-searching.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            // "Searching..." text - completely separate and static
            if (!showSecondContent)
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 230),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(
                          0xFF32292A)), // Position below the circular container
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    'Searching...',
                    style: AppTextStyles.medium(
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.baseWhite.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialContent() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        key: const ValueKey('first'),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildOverlappingAvatars(),
          Text(
            textAlign: TextAlign.center,
            'Searching for Peoples to \nMake a Match...',
            style: AppTextStyles.medium(
              size: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.baseWhite.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondContent() {
    return Column(
      key: const ValueKey('second'),
      children: [
        // Main content scrollable with padding inside
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const IntrinsicWidth(
                    child: LuminousCard(
                      luminousColor: Colors.green,
                      label: 'Match Found!',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DetailProfileCard(items: items),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const OtherProfileCard();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // Persistent button (no padding)
        Container(
          decoration: BoxDecoration(color: Color(0xFF100613)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              prefixIcon: Icons.search,
              label: 'Search Again',
              onPressed: () {},
              textColor: AppColors.xpColor,
              backgroundColor: AppColors.xpColor.withOpacity(0.15),
            ),
          ),
        ),
      ],
    );
  }
}
