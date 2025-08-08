import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/pages/game_recommendation_screen.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/profile_overlaps.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/solid_button.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/core/constants/token_service.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  String? name;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await TokenService.getUser();
    setState(() {
      name = user?['name'] ?? 'Guest';
      userName = user?['username'] ?? 'guest_user';
    });
  }

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
        title: Text(
          "$name's Profile",
          style: AppTextStyles.medium(
            fontWeight: FontWeight.w400,
            size: 12.sp,
            color: AppColors.baseWhite.withOpacity(0.4),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Cover + Avatar
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Banner
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg/profile_banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Avatar with green status dot
                Positioned(
                  bottom: -35, // Pull avatar downwards to make it fully visible
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/user.png'),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
                height: 40), // Add spacing to account for avatar overlap
            const SizedBox(height: 16),

            // Name and handle
            Text(
              name ?? 'Guest',
              style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                  size: 16.sp),
            ),
            Text(
              userName ?? 'guest_user',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  color: AppColors.baseWhite.withOpacity(0.5),
                  size: 12.sp),
            ),
            const SizedBox(height: 8),
            Text(
              'Real web3 gamer. Hardcore Gamer.Real web3 gamer. Hardcore Gamer.Real web3 gamer.',
              textAlign: TextAlign.center,
              style: AppTextStyles.small(
                  color: AppColors.baseWhite.withOpacity(0.4), size: 12.sp),
            ),
            const SizedBox(height: 16),

            // Followers
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildOverlappingAvatars(),
                Text(
                  '120+ Followers',
                  style: AppTextStyles.small(
                      color: const Color(0xFF8EC9ED),
                      size: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Follow / Message Buttons
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SolidButton(
                      height: 30.h,
                      onPressed: () {},
                      label: 'Follow',
                      buttonColor: AppColors.xpColor,
                      prefixImage: 'assets/icons/add.png'),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 180.w,
                  height: 30.h,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const GameRecommendationScreen();
                      }));
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Message',
                      style: AppTextStyles.small(
                          size: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.baseWhite),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              thickness: 1,
              color: Color(0x1AFFFFFF),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: All the text + progress bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Level 1 : Novice Explorer',
                      style: AppTextStyles.medium(
                        color: AppColors.baseWhite,
                        fontWeight: FontWeight.w500,
                        size: 14.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Constrain the width
                    Stack(
                      children: [
                        Container(
                          height: 6.h,
                          width: 250.w,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Container(
                          height: 6.h,
                          width: 200 * 703 / 1000,
                          decoration: BoxDecoration(
                            gradient: buttonGradience(),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),
                    SizedBox(
                      width:
                          250.w, // Ensure this matches the progress bar width
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '700XP',
                                  style: AppTextStyles.small(
                                    color: AppColors.xpColor,
                                    size: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: ' / 1000XP',
                                  style: AppTextStyles.small(
                                    color: Colors.grey,
                                    size: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '297 XP Until Level 2',
                            style: AppTextStyles.small(
                              color: Colors.grey,
                              size: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Right: Star badge
                const SizedBox(width: 12),

                Image.asset(
                  'assets/icons/star_badge.png',
                  width: 75.w,
                  height: 75.h,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile earned Badges',
                  style: AppTextStyles.small(
                      color: AppColors.baseWhite.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      size: 12.sp),
                ),
                const Text('06', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: List.generate(6, (index) {
                  return Image.asset(
                    'assets/icons/yal_badge.png',
                    width: 32,
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),
            const Divider(
              thickness: 1,
              color: Color(0x1AFFFFFF),
            ),
            const SizedBox(height: 16),

            // Social Media
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Social Media',
                style: AppTextStyles.small(
                    color: AppColors.baseWhite.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    size: 12.sp),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Image.asset('assets/icons/twitter.png', height: 25.h),
                SizedBox(width: 5.h),
                Image.asset('assets/icons/x.png', height: 25.h),
                SizedBox(width: 5.h),
                Image.asset('assets/icons/fb.png', height: 25.h),
                SizedBox(width: 5.h),
                Image.asset('assets/icons/insta.png', height: 25.h),
                SizedBox(width: 5.h),
                Image.asset('assets/icons/discord.png', height: 25.h),
                SizedBox(width: 5.h),
                Image.asset('assets/icons/message.png', height: 25.h),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              thickness: 1,
              color: Color(0x1AFFFFFF),
            ),
            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Projects NFT’s Achieved",
                style: AppTextStyles.small(
                    color: AppColors.baseWhite.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    size: 14.sp),
              ),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return Container(
                  height: 150, // Adjust as needed
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg/free_fire.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1FD031),
                          borderRadius: BorderRadius.circular(63),
                        ),
                        child: Text(
                          'Active',
                          style: AppTextStyles.small(
                            color: const Color(0xFF2A0D32),
                            size: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ); // Replace
              },
            ),
            const SizedBox(height: 16),
            const Divider(
              thickness: 1,
              color: Color(0x1AFFFFFF),
            ),
            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Favourite Games",
                style: AppTextStyles.small(
                    color: AppColors.baseWhite.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    size: 14.sp),
              ),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return Container(
                  height: 150, // Adjust as needed
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/bg/pubg.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1FD031),
                          borderRadius: BorderRadius.circular(63),
                        ),
                        child: Text(
                          'Active',
                          style: AppTextStyles.small(
                            color: const Color(0xFF2A0D32),
                            size: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ); // Replace
              },
            ),
          ],
        ),
      ),
    );
  }
}
