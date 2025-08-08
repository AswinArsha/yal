import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/floating_nav_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/joined_clan_details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClanDetailsScreen extends StatefulWidget {
  const ClanDetailsScreen({super.key});

  @override
  State<ClanDetailsScreen> createState() => _ClanDetailsScreenState();
}

class _ClanDetailsScreenState extends State<ClanDetailsScreen> {
  bool _isOverviewExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xFF100613), // Updated background color to match second code
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

            Column(
              children: [
                // Fixed Header - Back button and title (outside scroll view)
                Container(
                  margin: EdgeInsets.only(
                      top: 16.h, left: 16.w, right: 16.w, bottom: 12.h),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: const Color(
                                0x12FFFFFF), // Semi-transparent white
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 10.w),
                          margin: EdgeInsets.only(right: 100.w),
                          child: Container(
                            width: 15.w,
                            height: 12.h,
                           child: SvgPicture.asset(
  "assets/images/tournament/clans/Arrow-Left.svg",
  fit: BoxFit.fill,
),

                          ),
                        ),
                      ),
                      Text(
                        "Clan Details",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Top Section with Background Image and Profile
                        Container(
                          margin: EdgeInsets.only(left: 16.w, right: 16.w),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Background Image and Profile Section
                              Column(
                                children: [
                                  // Background Image Card
                                  Container(
  padding: EdgeInsets.only(top: 6.h, bottom: 52.h),
  width: double.infinity,
  height: 90.h,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16.r),
    image: DecorationImage(
      image: AssetImage("assets/images/tournament/clans/clan_detail_backgound.png"), 
      fit: BoxFit.cover,
    ),
  ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Member avatars section
                                        Container(
                                          padding: EdgeInsets.only(right: 3.w),
                                          margin: EdgeInsets.only(left: 6.w),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 10.w),
                                                width: 62.w,
                                                height: 26.h,
                                               child: Image.asset(
  "assets/images/tournament/clans/clan_members_joined.png", 
    fit: BoxFit.fill,
),

                                              ),
                                              Text(
                                                "+29 Other Joined",
                                                style: TextStyle(
                                                  color: Color(0xFFFFFFFF),
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Profile Image
                                  Transform.translate(
                                    offset: Offset(0, -40.h),
                                    child: Container(
                                      width: 80.w,
                                      height: 80.h,
                                      child: Image.asset(
  "assets/images/tournament/clans/clan_card_profile.png", 
    fit: BoxFit.fill,
),

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Move everything from here upward by 10.h
                        Transform.translate(
                          offset: Offset(0, -30.h),
                          child: Column(
                            children: [
                              // Clan Name and Join Button Row
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 16.h, left: 16.w, right: 16.w),
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 12.w),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 2.h),
                                              width: double.infinity,
                                              child: Text(
                                                "Abyssal Templars",
                                                style: TextStyle(
                                                  color: Color(0xFFFFFFFF),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "ALTS",
                                              style: TextStyle(
                                                color: Color(0xFF8EC9ED),
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Navigate to the joined clan details screen
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const JoinedClanDetailsScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0x26FFFFFF),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          gradient: LinearGradient(
                                            begin: Alignment(1, -1),
                                            end: Alignment(1, 1),
                                            colors: [
                                              Color(0xFFFDEB56),
                                              Color(0xFFADA13D),
                                            ],
                                          ),
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 6.h),
                                        width: 150.w,
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 8.w, right: 6.w),
                                              width: 14.w,
                                              height: 14.h,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                               child: SvgPicture.asset(
  "assets/images/tournament/clans/add-01.svg",
  fit: BoxFit.fill,
),

                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  "Send Join Request",
                                                  style: TextStyle(
                                                    color: Color(0xFF24210A),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Horizontal line above overview
                              Container(
                                color: Color(0x1AFFFFFF),
                                margin: EdgeInsets.only(
                                    bottom: 15.h, left: 16.w, right: 16.w),
                                height: 1.h,
                                width: double.infinity,
                              ),

                              // Overview Section
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 16.h, left: 16.w, right: 16.w),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 4.h),
                                      child: Text(
                                        "Overview",
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Color(0x99FFFFFF),
                                            fontSize: 12.sp,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: _isOverviewExpanded
                                                  ? 'Welcome to the heart-pounding spectacle that is The Red Village Survival Championship – an eagerly anticipated annual event that unites adventurers and thrill-seekers from diverse backgrounds. Nestled in the breathtaking landscapes of the Red Village, this comprehensive competition showcases the ultimate gaming skills and strategic thinking required to dominate in the competitive gaming arena.'
                                                  : 'Welcome to the heart-pounding spectacle that is The Red Village Survival Championship – an eagerly anticipated annual event that unites adventurers and thrill-seekers from diverse backgrounds. Nestled in the breathtaking landscapes of the Red Village, this',
                                            ),
                                            TextSpan(
                                              text: _isOverviewExpanded
                                                  ? ' See Less...'
                                                  : ' See More...',
                                              style: TextStyle(
                                                color: const Color(0xFFDAA520),
                                                fontSize: 12.sp,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  setState(() {
                                                    _isOverviewExpanded =
                                                        !_isOverviewExpanded;
                                                  });
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Clan Stats
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Clan Level
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Color(0x0DFFFFFF),
                                      ),
                                      padding: EdgeInsets.all(8.w),
                                      margin: EdgeInsets.only(bottom: 8.h),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 8.h),
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 4.h),
                                                          child: Text(
                                                            "Clan Level",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                              fontSize: 10.sp,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "12",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 22.h),
                                                  child: Text(
                                                    "1200/380",
                                                    style: TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                              color: Color(0x1AFFFFFF),
                                            ),
                                            width: double.infinity,
                                            height: 6.h,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.r),
                                                    gradient: LinearGradient(
                                                      begin: Alignment(1, 1),
                                                      end: Alignment(-1, 1),
                                                      colors: [
                                                        Color(0xFF539BFF),
                                                        Color(0xFF1E5FBB),
                                                      ],
                                                    ),
                                                  ),
                                                  width: 84.w,
                                                  height: 6.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Members
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Color(0x0DFFFFFF),
                                      ),
                                      padding: EdgeInsets.all(8.w),
                                      margin: EdgeInsets.only(bottom: 8.h),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 8.h),
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 4.h),
                                                  child: Text(
                                                    "Members",
                                                    style: TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 10.sp,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "32/50",
                                                  style: TextStyle(
                                                    color: Color(0xFFFFFFFF),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                              color: Color(0x1AFFFFFF),
                                            ),
                                            width: double.infinity,
                                            height: 6.h,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.r),
                                                    gradient: LinearGradient(
                                                      begin: Alignment(1, -1),
                                                      end: Alignment(-1, -1),
                                                      colors: [
                                                        Color(0xFF55FFF6),
                                                        Color(0xFF1F8D88),
                                                      ],
                                                    ),
                                                  ),
                                                  width: 200.w,
                                                  height: 6.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Active Mission
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Color(0x0DFFFFFF),
                                      ),
                                      padding: EdgeInsets.all(8.w),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 8.h),
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 12.w),
                                                    width: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 4.h),
                                                          child: Text(
                                                            "Active Mission",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                              fontSize: 10.sp,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            "Win 5 Tournaments in 30 day's.",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFFFFFFFF),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 22.h),
                                                  child: Text(
                                                    "01/05",
                                                    style: TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                              color: Color(0x1AFFFFFF),
                                            ),
                                            width: double.infinity,
                                            height: 6.h,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100.r),
                                                    gradient: LinearGradient(
                                                      begin: Alignment(1, 1),
                                                      end: Alignment(-1, 1),
                                                      colors: [
                                                        Color(0xFFFF9253),
                                                        Color(0xFFBB551E),
                                                      ],
                                                    ),
                                                  ),
                                                  width: 63.w,
                                                  height: 6.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 24.h),

                              // Updated Members List based on second code
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                    gradient: LinearGradient(
                                      begin: Alignment(-1, 1),
                                      end: Alignment(1, 1),
                                      colors: [
                                        Color(0x1CFFFFFF),
                                        Color(0x00FFFFFF),
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(12.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Header with title and count
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 1.h),
                                        margin: EdgeInsets.only(bottom: 10.h),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 4.w),
                                                width: double.infinity,
                                                child: Text(
                                                  "Clan Members",
                                                  style: TextStyle(
                                                    color: Color(0xFFFFFFFF),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  "12",
                                                  style: TextStyle(
                                                    color: Color(0xFFFFFFFF),
                                                    fontSize: 10.sp,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Member List
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Member 1 - Leader
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                color: Color(0x08FFFFFF),
                                              ),
                                              padding: EdgeInsets.all(6.w),
                                              margin:
                                                  EdgeInsets.only(bottom: 6.h),
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 12.w),
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        10.w),
                                                            width: 36.w,
                                                            height: 36.h,
                                                           child: Image.asset(
  "assets/images/tournament/leaderboard/solo_leaderboard.png", 
    fit: BoxFit.fill,
),

                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Mousa al Khourey",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xE5FFFFFF),
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              Text(
                                                                "mousa583",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0x66FFFFFF),
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.r),
                                                      color: Color(0x1A1FD031),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        top: 3.h,
                                                        bottom: 3.h,
                                                        left: 4.w,
                                                        right: 8.w),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100.r),
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 4.w),
                                                          width: 12.w,
                                                          height: 12.h,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100.r),
                                                           child: SvgPicture.asset(
  "assets/images/tournament/clans/clan_star.svg",
  fit: BoxFit.fill,
),

                                                          ),
                                                        ),
                                                        Text(
                                                          "Leader",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF1FD030),
                                                            fontSize: 10.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Member 2
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                color: Color(0x08FFFFFF),
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: 6.h,
                                                  bottom: 6.h,
                                                  left: 6.w),
                                              margin:
                                                  EdgeInsets.only(bottom: 6.h),
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                    width: 36.w,
                                                    height: 36.h,
                                                    child: Image.asset(
  "assets/images/tournament/leaderboard/solo_leaderboard.png", 
    fit: BoxFit.fill,
),

                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Wael Alshamery",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xE5FFFFFF),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "wael455",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0x66FFFFFF),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Member 3
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                color: Color(0x08FFFFFF),
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: 6.h,
                                                  bottom: 6.h,
                                                  left: 6.w),
                                              margin:
                                                  EdgeInsets.only(bottom: 6.h),
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                    width: 36.w,
                                                    height: 36.h,
                                                   child: Image.asset(
  "assets/images/tournament/leaderboard/solo_leaderboard.png", 
    fit: BoxFit.fill,
),

                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Jhon William",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xE5FFFFFF),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "jhon990",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0x66FFFFFF),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Member 4
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                color: Color(0x08FFFFFF),
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: 6.h,
                                                  bottom: 6.h,
                                                  left: 6.w),
                                              margin:
                                                  EdgeInsets.only(bottom: 6.h),
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                    width: 36.w,
                                                    height: 36.h,
                                                   child: Image.asset(
  "assets/images/tournament/leaderboard/solo_leaderboard.png", 
    fit: BoxFit.fill,
),

                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Wael Alshamery",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xE5FFFFFF),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "wael455",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0x66FFFFFF),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Member 5
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                color: Color(0x08FFFFFF),
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: 6.h,
                                                  bottom: 6.h,
                                                  left: 6.w),
                                              margin:
                                                  EdgeInsets.only(bottom: 6.h),
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                    width: 36.w,
                                                    height: 36.h,
                                                  child: Image.asset(
  "assets/images/tournament/leaderboard/solo_leaderboard.png", 
    fit: BoxFit.fill,
),

                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Jhon William",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xE5FFFFFF),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "jhon990",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0x66FFFFFF),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Member 6
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                color: Color(0x08FFFFFF),
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: 6.h,
                                                  bottom: 6.h,
                                                  left: 6.w),
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10.w),
                                                    width: 36.w,
                                                    height: 36.h,
                                                   child: Image.asset(
  "assets/images/tournament/leaderboard/solo_leaderboard.png", 
    fit: BoxFit.fill,
),

                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Jhon William",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xE5FFFFFF),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        "jhon990",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0x66FFFFFF),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 100.h), // Extra space for floating nav
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Floating Navigation
            const FloatingNavWidget(currentTabIndex: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildFullWidthStatCard(String title, String value, String rightValue,
      double progress, Color progressColor, bool isTransparent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isTransparent
            ? const Color(0xFF3D2B5F).withOpacity(0.3)
            : const Color(0xFF3D2B5F),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.7),
                  size: 10.sp, // Further reduced font size
                ),
              ),
              if (rightValue.isNotEmpty)
                Text(
                  rightValue,
                  style: AppTextStyles.medium(
                    color: AppColors.baseWhite.withOpacity(0.7),
                    size: 10.sp, // Further reduced font size
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.largeBold(
              color: AppColors.baseWhite,
              size: 16.sp, // Further reduced font size
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 6.h,
            width:
                double.infinity, // Full width background for unfilled portion
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3), // Unfilled background
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionStatCard(
      String title,
      String missionText,
      String progress,
      double progressValue,
      Color progressColor,
      bool isTransparent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isTransparent
            ? const Color(0xFF3D2B5F).withOpacity(0.3)
            : const Color(0xFF3D2B5F),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.7),
                  size: 10.sp, // Further reduced font size
                ),
              ),
              Text(
                progress,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.7),
                  size: 10.sp, // Further reduced font size
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            missionText,
            style: AppTextStyles.largeBold(
              color: AppColors.baseWhite,
              size: 14.sp, // Further reduced font size
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progressValue,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberItem(
      String name, String role, String username, String imagePath, int index) {
    return Row(
      children: [
        // Member Avatar - Larger size
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 12.w), // Reduced spacing to bring name closer

        // Member Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite,
                  size: 12.sp, // Further reduced text size
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                username,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.6),
                  size: 12.sp, // Reduced text size
                ),
              ),
            ],
          ),
        ),

        // Leader Badge (only for leader)
        if (role == 'Leader')
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50)
                  .withOpacity(0.3), // Medium green with transparency
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: const Color(0xFF81C784), // Light green color
                  size: 14.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Leader',
                  style: AppTextStyles.medium(
                    color: const Color(0xFF81C784), // Light green color
                    size: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
