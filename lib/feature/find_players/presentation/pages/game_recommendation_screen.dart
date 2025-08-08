import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/feature/find_players/presentation/pages/chat_screen.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/input_bar_widget.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/recommended_games_widget.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';

import '../../../../core/theme/text_style.dart';

class GameRecommendationScreen extends StatefulWidget {
  const GameRecommendationScreen({super.key});
  @override
  State<GameRecommendationScreen> createState() =>
      _GameRecommendationScreenState();
}

class _GameRecommendationScreenState extends State<GameRecommendationScreen> {
  bool showProfile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.buttonBackground,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomArrowBack(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage(
                  'assets/images/bg/dall_e.png'), // Replace with actual image
              radius: 18.h,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ali Haninah's Profile",
                  style: AppTextStyles.medium(
                    fontWeight: FontWeight.w500,
                    size: 14.sp,
                    color: AppColors.baseWhite,
                  ),
                ),
                Text("@alihaninah880",
                    style: AppTextStyles.medium(
                      fontWeight: FontWeight.w400,
                      size: 10.sp,
                      color: AppColors.baseWhite.withOpacity(0.4),
                    ))
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            height: 35.h,
            width: double.infinity,
            color: const Color(0xFF8EC9ED),
            child: TextButton.icon(
              iconAlignment: IconAlignment.end,
              onPressed: () => setState(() => showProfile = !showProfile),
              icon: const Icon(Icons.keyboard_arrow_down_outlined,
                  color: Colors.black),
              label: Text(
                "Choose Recommended Games",
                style: AppTextStyles.small(
                    size: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF212F38)),
              ),
            ),
          ),
        ),
      ),
      body: showProfile
          ? _buildProfileView()
          : RecommendedGamesView(
              gameCardBuilder: () => _buildGameCard(),
            ),
    );
  }

  Widget _buildProfileView() {
    return Column(
      children: [
        // Scrollable profile content (excluding recommended games)
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 60.h),
                CircleAvatar(
                  radius: 40.h,
                  backgroundImage:
                      const AssetImage('assets/images/bg/dall_e.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 8),
                Text(
                  "Ali Haninah",
                  style: AppTextStyles.medium(
                    fontWeight: FontWeight.w600,
                    size: 20.sp,
                    color: AppColors.baseWhite,
                  ),
                ),
                Text(
                  "@alihaninah880",
                  style: AppTextStyles.medium(
                    fontWeight: FontWeight.w400,
                    size: 14.sp,
                    color: AppColors.baseWhite.withOpacity(0.4),
                  ),
                ),
                SizedBox(height: 12.h),
                IntrinsicWidth(
                  child: LuminousCard(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      luminousColor: Color(0xFFBC5AD7),
                      label: 'View Profile'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        // Recommended Games section (fixed at bottom above input)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.border, AppColors.border.withOpacity(0.3)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recommended Games",
                      style: AppTextStyles.mediumBold(
                          size: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.baseWhite.withOpacity(0.9))),
                  const SizedBox(height: 8),
                  _buildGameCard(),
                  const SizedBox(height: 8),
                  _buildGameCard(),
                ],
              ),
            ),
          ),
        ),

        // Input bar
        Container(
          decoration: BoxDecoration(
            color: AppColors.baseWhite.withOpacity(0.06),
            border: Border(
              top: BorderSide(
                color: AppColors.baseWhite.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: InputBar(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return ChatScreen();
                },
              ));
            },
          ),
        ),
      ],
    );
  }

  // Widget _buildInputBar() {
  //   return Padding(
  //     padding: const EdgeInsets.all(12),
  //     child: Row(
  //       children: [
  //         Image.asset(height: 40.h, 'assets/icons/gallery.png'),
  //         const SizedBox(width: 10),
  //         Image.asset(height: 40.h, 'assets/icons/smile.png'),
  //         const SizedBox(width: 10),
  //         Expanded(
  //           child: TextField(
  //             onTap: () {
  //               Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) {
  //                   return ChatScreen();
  //                 },
  //               ));
  //             },
  //             decoration: InputDecoration(
  //               hintText: "Type here...",
  //               filled: true,
  //               hintStyle: AppTextStyles.small(
  //                   color: AppColors.baseWhite.withOpacity(0.6),
  //                   size: 14.sp,
  //                   fontWeight: FontWeight.w400),
  //               fillColor: AppColors.baseWhite.withOpacity(0.05),
  //               contentPadding:
  //                   const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(3.36),
  //                 borderSide: BorderSide.none,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildGameCard() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.baseWhite.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/bg/free_fire_blue.png',
              width: 90.w,
              height: 90.h,
              fit: BoxFit.cover), // Replace with actual asset
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Free Fire",
                        style: AppTextStyles.mediumBold(
                            size: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.baseWhite.withOpacity(0.9))),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.yellow, size: 18),
                    const SizedBox(width: 6),
                    Text("4.8",
                        style: AppTextStyles.small(
                            fontWeight: FontWeight.w500,
                            size: 12,
                            color: AppColors.xpColor)),
                  ],
                ),
                const SizedBox(height: 10),
                Text("Welcome to the heart-poun...",
                    style: AppTextStyles.small(
                        size: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.baseWhite.withOpacity(0.5))),
                const SizedBox(height: 12),
                Row(
                  children: [
                    LuminousCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        prefixIcon: Icons.circle,
                        iconSize: 4.h,
                        fontWeight: FontWeight.w500,
                        luminousColor: const Color(0xFF8EC9ED),
                        label: 'Fighting'),
                    const SizedBox(width: 6),
                    LuminousCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        prefixIcon: Icons.circle,
                        iconSize: 4.h,
                        fontWeight: FontWeight.w500,
                        label: "Open World",
                        luminousColor: const Color(0xFF8EC9ED)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
