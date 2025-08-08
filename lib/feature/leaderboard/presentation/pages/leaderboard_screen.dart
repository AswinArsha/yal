import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/leaderboard/presentation/widgets/sponsor_dialog.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

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
          'Leaderboard',
          style: AppTextStyles.medium(
            fontWeight: FontWeight.w400,
            size: 12,
            color: AppColors.baseWhite.withOpacity(0.4),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _seasonCard(context),
            const SizedBox(height: 16),
            Text("Ranking",
                style: AppTextStyles.largeBold(
                    size: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(233, 230, 234, 1))),
            const SizedBox(height: 10),
            _rankTile(
              "Ali Haninah (Me)",
              "assets/icons/badge.png",
              345,
            ),
            const SizedBox(height: 4),
            Divider(thickness: 1, color: AppColors.baseWhite.withOpacity(0.05)),
            const SizedBox(height: 8),
            _searchBar(),
            const SizedBox(height: 16),
            _tableHeader(),
            const SizedBox(height: 8),
            Divider(thickness: 1, color: AppColors.baseWhite.withOpacity(0.05)),
            const SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  final names = [
                    "William",
                    "Abdullah",
                    "Mousa",
                    "William",
                    "Abdullah",
                    "Abdullah",
                    "Abdullah",
                    "Abdullah",
                  ];
                  return _rankTile(
                    names[index],
                    'assets/icons/badge.png',
                    345,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _seasonCard(context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.baseWhite.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Season 1",
                            style: AppTextStyles.mediumBold(
                                color: AppColors.baseWhite.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                                size: 16)),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => TournamentDialog(),
                          );
                        },
                        child: Text("View Sponsors",
                            style: AppTextStyles.medium(
                                fontWeight: FontWeight.w400,
                                size: 12,
                                color: AppColors.xpColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text("From October 15 to November 13",
                      style: AppTextStyles.medium(
                          fontWeight: FontWeight.w400,
                          size: 12,
                          color: AppColors.baseWhite.withOpacity(0.5))),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 6,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            color: AppColors.baseWhite
                                .withOpacity(0.1), // background bar
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.80,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFF71756),
                                    Color(0xFFFDEB56)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.baseWhite.withOpacity(0.05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 16,
                              color: AppColors.baseWhite.withOpacity(0.7)),
                          const SizedBox(width: 6),
                          Text("Time Left",
                              style: AppTextStyles.medium(
                                  color: AppColors.baseWhite.withOpacity(0.7),
                                  size: 12,
                                  fontWeight: FontWeight.w400)),
                          const Spacer(),
                          Text("08d : 23h : 31m : 56s",
                              style: AppTextStyles.largeBold(
                                  color: AppColors.baseWhite.withOpacity(0.9),
                                  size: 16,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -90,
              left: -90,
              child: IgnorePointer(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color.fromRGBO(188, 90, 215, 0.2),
                        Colors.transparent,
                      ],
                      radius: 0.6,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _searchBar() {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.baseWhite
              .withOpacity(0.05), // Customize border color here
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Cube-like box with search icon
          Container(
              width: 36.w,
              height: 46.h,
              decoration: BoxDecoration(
                color: AppColors.baseWhite
                    .withOpacity(0.05), // Background color of the cube
              ),
              child: Image.asset('assets/icons/Search.png', height: 19.h)),
          const SizedBox(width: 12),

          // Hint text
          Expanded(
            child: Text(
              'Search by username...',
              style: AppTextStyles.medium(
                  size: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text("Rank",
                  style: AppTextStyles.small(
                      fontWeight: FontWeight.w400,
                      size: 12,
                      color: AppColors.baseWhite.withOpacity(0.4)))),
          Expanded(
            flex: 5,
            child: Text("Name",
                style: AppTextStyles.small(
                    fontWeight: FontWeight.w400,
                    size: 12,
                    color: AppColors.baseWhite.withOpacity(0.4))),
          ),
          Expanded(
              flex: 2,
              child: Text("XP",
                  textAlign: TextAlign.end,
                  style: AppTextStyles.small(
                      fontWeight: FontWeight.w400,
                      size: 12,
                      color: AppColors.baseWhite.withOpacity(0.4)))),
        ],
      ),
    );
  }

  Widget _rankTile(String name, String avatarPath, int xp,
      {bool isCurrentUser = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.baseWhite.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(
            avatarPath,
            height: 28.h,
          ),
          const SizedBox(width: 12),
          Text(name,
              style: AppTextStyles.medium(
                color: AppColors.baseWhite.withOpacity(0.8),
                size: 14,
                fontWeight: FontWeight.w500,
              )),
          const Spacer(),
          Image.asset('assets/icons/xp-icon.png', height: 14.h),
          const SizedBox(width: 8),
          Container(
            width: 0.5, // thickness of the line
            height: 14.h, // height of the line
            color: AppColors.baseWhite.withOpacity(0.08),
          ),
          const SizedBox(width: 8),
          Text(
            "$xp",
            style: AppTextStyles.small(
                color: AppColors.xpColor,
                fontWeight: FontWeight.w500,
                size: 12),
          )
        ],
      ),
    );
  }
}
