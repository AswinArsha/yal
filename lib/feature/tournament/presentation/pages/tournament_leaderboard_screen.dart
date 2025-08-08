import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/welcome_profile_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/floating_nav_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TournamentLeaderboardScreen extends StatefulWidget {
  const TournamentLeaderboardScreen({super.key});

  @override
  State<TournamentLeaderboardScreen> createState() =>
      _TournamentLeaderboardScreenState();
}

class _TournamentLeaderboardScreenState
    extends State<TournamentLeaderboardScreen> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 11, 24, 1),

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: Container(
      //     margin: EdgeInsets.all(8.w),
      //     decoration: BoxDecoration(

      //     ),
      //     child: IconButton(
      //       icon: const Icon(Icons.arrow_back, color: Colors.white),
      //       onPressed: () => Navigator.of(context).pop(),
      //     ),
      //   ),
      //   title: Text(
      //     'Leaderboard',
      //     style: AppTextStyles.medium(
      //       color: Colors.white,
      //       size: 18,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: false,
      //   titleSpacing: 8.w,
      // ),

         body: SafeArea(
        child: Stack(
          children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/tournament/tournament_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // Main Content
          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const WelcomeProfileWidget(),

// Tournament Card
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      height: 320.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(
                                0x805BE2DB), // Matches second UI - teal with opacity
                            Color.fromARGB(92, 53, 18,
                                66), // Matches second UI - transparent green
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Main content container
                          Container(
                            padding: EdgeInsets.only(
                              top: 12.h,
                              left: 12.w,
                              right: 12.w,
                              bottom: 12.h,
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Timer Section
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    color: const Color(0xFFFFFFFF),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 6.w),
                                        width: 14.w,
                                        height: 14.h,
                                       child: SvgPicture.asset(
  "assets/images/tournament/leaderboard/clock-01.svg",
  fit: BoxFit.fill,
),
                                      ),
                                      Text(
                                        "Time Left:",
                                        style: TextStyle(
                                          color: const Color(0xFF20A187),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        "08d : 23h : 45m : 56s",
                                        style: TextStyle(
                                          color: const Color(0xCC100613),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Season Title and Team Badge Row
                                Container(
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10.w),
                                        child: Text(
                                          "Season 03",
                                          style: TextStyle(
                                            color: const Color(0xFFFFFFFF),
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          color: const Color(0x1AFFFFFF),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 3.h),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 5.w),
                                              width: 11.w,
                                              height: 8.h,
                                            child: SvgPicture.asset(
  "assets/images/tournament/leaderboard/3_User.svg",
  fit: BoxFit.fill,
),
                                            ),
                                            Text(
                                              "Team",
                                              style: TextStyle(
                                                color: Color(0x99FFFFFF),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Date Range
                                Text(
                                  "From October 15 to November 13",
                                  style: TextStyle(
                                    color: const Color(0x99FFFFFF),
                                    fontSize: 14.sp,
                                  ),
                                ),

                                SizedBox(height: 11.h),

                                // Horizontal line
                                Container(
                                  color: const Color(0x1AFFFFFF),
                                  height: 1.h,
                                  width: double.infinity,
                                ),

                                SizedBox(height: 8.h),

                                // Participating Sponsors
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 4.h),
                                      child: Text(
                                        "Participating Sponsors",
                                        style: TextStyle(
                                          color: const Color(0xE5FFFFFF),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          width: 48.w,
                                          height: 48.h,
                                        child: SvgPicture.asset(
  "assets/images/tournament/leaderboard/sponsors.svg",
  fit: BoxFit.fill,
),


                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          width: 48.w,
                                          height: 48.h,
                                          child: SvgPicture.asset(
  "assets/images/tournament/leaderboard/sponsors.svg",
  fit: BoxFit.fill,
),

                                        ),
                                        Container(
                                          margin: EdgeInsets.only(right: 10.w),
                                          width: 48.w,
                                          height: 48.h,
                                          child: SvgPicture.asset(
  "assets/images/tournament/leaderboard/sponsors.svg",
  fit: BoxFit.fill,
),

                                        ),
                                        Container(
                                          width: 48.w,
                                          height: 48.h,
                                          child: SvgPicture.asset(
  "assets/images/tournament/leaderboard/sponsors.svg",
  fit: BoxFit.fill,
),

                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Ninja Image positioned at bottom right
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              width: 260.w,
                              height: 140.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                             child: Image.asset(
  "assets/images/tournament/leaderboard/tournament_player.png",
  fit: BoxFit.fill,
),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

// Updated Tab Section
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0x08FFFFFF),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(100.r),
                        color: const Color(0x08FFFFFF),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTabIndex = 0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: selectedTabIndex == 0
                                      ? const Color(0x1AFFFFFF)
                                      : Colors.transparent,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Text(
                                  "Team",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xE5FFFFFF),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTabIndex = 1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: selectedTabIndex == 1
                                      ? const Color(0x1AFFFFFF)
                                      : Colors.transparent,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Text(
                                  "Solo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xE5FFFFFF),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

// Updated Season Filter Row
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Seasonal Leaderboard",
                              style: TextStyle(
                                color: const Color(0xE5FFFFFF),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(100.r),
                              color: const Color(0xFF2D242D),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 6.h),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 12.w),
                                  child: Text(
                                    "This Season",
                                    style: TextStyle(
                                      color: const Color(0xCCFFFFFF),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                  width: 12.w,
                                  height: 12.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: SvgPicture.asset(
  "assets/images/tournament/leaderboard/arrow-down-01.svg",
  fit: BoxFit.fill,
),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Replace the Table Headers and Table Content sections in your TournamentLeaderboardScreen with this updated version

                    SizedBox(height: 16.h),

// Table Headers
                Container(
  margin: EdgeInsets.symmetric(horizontal: 16.w),
  decoration: BoxDecoration(
    border: Border(
      top: BorderSide(
        color: const Color(0x12FFFFFF),
        width: 1,
      ),
      bottom: BorderSide(
        color: const Color(0x12FFFFFF),
        width: 1,
      ),
    ),
    color: const Color(0x08FFFFFF),
  ),
  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
  child: Row(
    children: [
      Container(
        margin: EdgeInsets.only(right: 67.w),
        child: Text(
          "#",
          style: TextStyle(
            color: const Color(0x80FFFFFF),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Expanded(
        child: Text(
          selectedTabIndex == 0 ? "Team Name" : "Player Name",
          style: TextStyle(
            color: const Color(0x80FFFFFF),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Text(
        "Total Tournament Played",
        style: TextStyle(
          color: const Color(0x80FFFFFF),
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  ),
),

// Table Content
Column(
  children: List.generate(8, (index) {
    // Define gradients for top 3 positions
    LinearGradient? rowGradient;
    if (index == 0) {
      // Gold gradient for 1st place
      rowGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(60, 253, 236, 86), // Gold with opacity
          Color.fromARGB(40, 253, 236, 86), // Faded gold
        ],
      );
    } else if (index == 1) {
      // Purple gradient for 2nd place
      rowGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(60, 168, 142, 237), // Purple with opacity
          Color.fromARGB(40, 168, 142, 237), // Faded purple
        ],
      );
    } else if (index == 2) {
      // Pink gradient for 3rd place
      rowGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromARGB(60, 188, 90, 215), // Pink with opacity
          Color.fromARGB(40, 188, 90, 215), // Faded pink
        ],
      );
    }

    // Different avatar URLs based on selected tab
    List<String> avatarAssets = List.generate(8, (index) {
      return selectedTabIndex == 0
          ? "assets/images/tournament/leaderboard/team_leaderboard.png"
          : "assets/images/tournament/leaderboard/solo_leaderboard.png";
    });

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: index < 3
                ? const Color.fromARGB(255, 173, 173, 173).withOpacity(0.3)
                : const Color.fromARGB(255, 151, 150, 150).withOpacity(0.2),
            width: 0.3,
          ),
        ),
        gradient: rowGradient,
        color: rowGradient == null ? Colors.transparent : null,
      ),
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
                right: index == 6 ? 24.w : 23.w), // Slight adjustment for "07"
            child: Text(
              "${index + 1}".padLeft(2, '0'),
              style: TextStyle(
                color: const Color(0xCCFFFFFF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 18.w),
            width: 24.w,
            height: 24.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3.r),
              child: Image.asset(
                avatarAssets[index],
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback widget if image fails to load
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                    child: Icon(
                      selectedTabIndex == 0 ? Icons.group : Icons.person,
                      color: Colors.white,
                      size: 16.r,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Text(
              selectedTabIndex == 0
                  ? "Team Warfaze"
                  : "Mousa Al Khourey",
              style: TextStyle(
                color: const Color(0xCCFFFFFF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            "${15 - index}",
            style: TextStyle(
              color: const Color(0xCCFFFFFF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }),
),

SizedBox(height: 100.h), // Bottom padding for scroll // Bottom padding for scroll
                  ],
                ),
              ),
              const FloatingNavWidget(currentTabIndex: -1),
            ],
          ),
        ],
      ),
      ),
    );
  }

  TextStyle _headerStyle() {
    return AppTextStyles.medium(
      color: Colors.white.withOpacity(0.5),
      size: 14,
    );
  }
}
