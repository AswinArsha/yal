import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/floating_nav_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/welcome_profile_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/clan_details_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/create_clan_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyClansScreen extends StatelessWidget {
  const MyClansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 11, 24, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // App Bar with original background
                // Container(
                //   color: const Color.fromRGBO(21, 11, 24, 1),

                //   child: Row(
                //     children: [
                //       Container(

                //         child: IconButton(
                //           icon: const Icon(Icons.arrow_back, color: Colors.white),
                //           onPressed: () => Navigator.of(context).pop(),
                //         ),
                //       ),
                //       SizedBox(width: 8.w),
                //       Text(
                //         'My Clans',
                //         style: AppTextStyles.medium(
                //           color: Colors.white,
                //           size: 18,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // Background image starts from Discover Clans section
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/tournament/tournament_background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            color: const Color.fromRGBO(21, 11, 24, 1),
                            child: const WelcomeProfileWidget(),
                          ),
                        ),

                        SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 10.h, left: 16.w, right: 16.w),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 99.w),
                                  child: Text(
                                    "Discover Clans",
                                    style: TextStyle(
                                      color: Color(0xE5FFFFFF),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateClanScreen(),
                                        ),
                                      );
                                    },
                                    child: IntrinsicHeight(
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
                                              Color(0xFFAB9E3A),
                                            ],
                                          ),
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              margin:
                                                  EdgeInsets.only(left: 12.w),
                                              width: 14.w,
                                              height: 14.w,
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
                                                  "Create New",
                                                  style: TextStyle(
                                                    color: Color(0xFF24210A),
                                                    fontSize: 14.sp,
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SliverToBoxAdapter(
                          child: SizedBox(height: 20.h),
                        ),

// Replace your existing "Clan Cards List" SliverList with this:

                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              // Define badge properties based on index
                              String badgeText;
                              String badgeIcon;
                              List<Color> badgeColors;
                              String backgroundImage;

                              if (index == 0) {
                                // Public badge
                                badgeText = 'Public';
                                badgeIcon =
                                    "assets/images/tournament/clans/user-group.svg";
                                badgeColors = [
                                  Color(0xFF1CA82A),
                                  Color(0xFF0B4210),
                                ];
                                backgroundImage =
                                    "assets/images/tournament/clans/clan_card_background.png";
                              } else if (index == 1) {
                                // Private badge
                                badgeText = 'Invite Only';
                                badgeIcon =
                                    "assets/images/tournament/clans/invite_only.svg";
                                badgeColors = [
                                  Color(0xFFD72121),
                                  Color(0xFF771515),
                                ];
                                backgroundImage =
                                    "assets/images/tournament/clans/clan_card_background.png";
                              } else {
                                // Another Public badge
                                badgeText = 'Public';
                                badgeIcon =
                                    "assets/images/tournament/clans/user-group.svg";
                                badgeColors = [
                                  Color(0xFF1CA82A),
                                  Color(0xFF0B4210),
                                ];
                                backgroundImage =
                                    "assets/images/tournament/clans/clan_card_background.png";
                              }

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ClanDetailsScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 12.h, left: 16.w, right: 16.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromARGB(
                                            255, 120, 85, 129), // 100% opacity
                                        Color(0x008E6998), // 0% opacity
                                      ],
                                    ),
                                  ),
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(.7), // 1px border width
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11
                                          .r), // Slightly smaller to account for the gradient border
                                      color: Color.fromARGB(255, 50, 35, 56),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Background Image Section with Badge and Profile Image
                                        Container(
                                          margin: EdgeInsets.only(bottom: 48.h),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              // Background Image Container
                                            Container(
  padding: EdgeInsets.only(top: 8.h, bottom: 61.h),
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12.r),
      topRight: Radius.circular(12.r),
    ),
    image: DecorationImage(
      image: AssetImage(backgroundImage), // Changed from NetworkImage to AssetImage
      fit: BoxFit.cover,
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Badge
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          gradient: LinearGradient(
            begin: Alignment(-1, 1),
            end: Alignment(1, 1),
            colors: badgeColors,
          ),
        ),
        padding: EdgeInsets.only(
            top: 3.h,
            bottom: 3.h,
            left: 4.w,
            right: 8.w),
        margin: EdgeInsets.only(left: 8.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
              ),
              margin: EdgeInsets.only(right: 4.w),
              width: 14.w,
              height: 14.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: SvgPicture.asset( // Changed from Image.network to SvgPicture.asset
                  badgeIcon,
                  fit: BoxFit.cover,
                  width: 14.w,
                  height: 14.w,
                ),
              ),
            ),
            Text(
              badgeText,
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
                                              // Profile Image - Positioned at the bottom center
                                              Positioned(
                                                bottom: 0,
                                                left: 135.w,
                                                right: 135.w,
                                                height: 72.h,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                  ),
                                                  transform:
                                                      Matrix4.translationValues(
                                                          0, 36, 0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                        child: Image.asset(
                                                      "assets/images/tournament/clans/clan_card_profile.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Content Section
                                        Container(
                                          margin: EdgeInsets.only(left: 10.w),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 12.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Clan Name and Send Join Request Button Row
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 16.h),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right: 12
                                                                            .w),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              2.h),
                                                                      child:
                                                                          Text(
                                                                        "Abyssal Templars",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFFFFFFFF),
                                                                          fontSize:
                                                                              16.sp,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "ALTS",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF8EC9ED),
                                                                        fontSize:
                                                                            12.sp,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 129
                                                                  .w, // Set a fixed width (adjust as needed)
                                                              child: InkWell(
                                                                onTap: () {
                                                                  print(
                                                                      'Send Join Request pressed');
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Color(
                                                                          0x26FFFFFF),
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.r),
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin:
                                                                          Alignment(
                                                                              1,
                                                                              -1),
                                                                      end: Alignment(
                                                                          1, 1),
                                                                      colors: [
                                                                        Color(
                                                                            0xFFFDEB56),
                                                                        Color(
                                                                            0xFFADA13D),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          4.h,
                                                                      horizontal:
                                                                          8.w),
                                                                  child: Text(
                                                                    "Send Join Request",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF24210A),
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center, // Move text to right side
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      // Stats Row
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Clan Level Card
                                                          Expanded(
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                                color: Color(
                                                                    0x0DFFFFFF),
                                                              ),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 6.h,
                                                                      bottom:
                                                                          6.h,
                                                                      left: 8.w,
                                                                      right:
                                                                          8.w),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          11.w),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            4.h),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          margin:
                                                                              EdgeInsets.only(bottom: 2.h),
                                                                          child:
                                                                              Text(
                                                                            "Clan Level",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color(0xFFFFFFFF),
                                                                              fontSize: 10.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "02",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFFFFFFFF),
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // Progress Bar
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(100.r),
                                                                          color:
                                                                              Color(0x1AFFFFFF),
                                                                        ),
                                                                        width:
                                                                            93.w,
                                                                        height:
                                                                            4.h,
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(100.r),
                                                                                gradient: LinearGradient(
                                                                                  begin: Alignment(1, 1),
                                                                                  end: Alignment(-1, 1),
                                                                                  colors: [
                                                                                    Color(0xFF539BFF),
                                                                                    Color(0xFF1E5FBB),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              width: 75.w,
                                                                              height: 4.h,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          // Members Card
                                                          Expanded(
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                                color: Color(
                                                                    0x0DFFFFFF),
                                                              ),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          6.h),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            2.h,
                                                                        left: 7
                                                                            .w),
                                                                    child: Text(
                                                                      "Members",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFFFFFFFF),
                                                                        fontSize:
                                                                            10.sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            4.h,
                                                                        left: 7
                                                                            .w),
                                                                    child: Text(
                                                                      "41/50",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFFFFFFFF),
                                                                        fontSize:
                                                                            14.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: 8
                                                                            .w),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(100.r),
                                                                            color:
                                                                                Color(0x1AFFFFFF),
                                                                          ),
                                                                          width:
                                                                              93.w,
                                                                          height:
                                                                              4.h,
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(100.r),
                                                                                  gradient: LinearGradient(
                                                                                    begin: Alignment(1, -1),
                                                                                    end: Alignment(-1, -1),
                                                                                    colors: [
                                                                                      Color(0xFF55FFF6),
                                                                                      Color(0xFF1F8D88),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                width: 75.w,
                                                                                height: 4.h,
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
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                            height: 16
                                                .h), // Add some bottom padding
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const FloatingNavWidget(),
          ],
        ),
      ),
    );
  }
}
