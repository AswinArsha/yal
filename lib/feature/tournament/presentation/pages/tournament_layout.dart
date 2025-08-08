import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/profile_overlaps.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/squad_tournament/squad_tournament_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_list_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/floating_nav_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/top_nav_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/welcome_profile_widget.dart';

class TournamentLayoutScreen extends StatefulWidget {
  const TournamentLayoutScreen({super.key});

  @override
  State<TournamentLayoutScreen> createState() => _TournamentLayoutScreenState();
}

class _TournamentLayoutScreenState extends State<TournamentLayoutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF140D1F),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 100.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopNavWidget(),
                    const WelcomeProfileWidget(),

                    // Tournament Card
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color.fromRGBO(188, 90, 215, 0.5),
                            Color.fromRGBO(99, 47, 113, 0)
                          ]),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        padding:
                            EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.local_fire_department,
                                      color: Colors.red, size: 16.r),
                                  SizedBox(width: 4.w),
                                  Text("Hot Tournaments",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp)),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Free Fire Championship 2025",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "The Free Fire Championship 2025 promises an exhilarating year for esports enthusiasts, featuring...",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 12.sp),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        buildOverlappingAvatars(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 4.h),
                                          decoration: BoxDecoration(
                                            color: Colors.purple.shade400,
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          child: Text("+504 Other Joined",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 50.h),
                                    Row(
                                      children: List.generate(3, (index) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 6.w),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            child: Image.asset(
                                              'assets/images/logos/pubg_man.png',
                                              height: 40.h,
                                              width: 40.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                                Image.asset(
                                  'assets/images/bg/sword_man.png',
                                  height: 140.h,
                                  width: 170.w,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Section Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Upcoming Tournaments',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: AppColors.baseWhite.withOpacity(0.9),
                                fontSize: 20.sp,
                              )),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const TournamentListScreen(),
                              ));
                            },
                            child: Text('See All',
                                style: GoogleFonts.poppins(
                                  color: AppColors.xpColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Tournament List
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const TournamentScreen(),
                              ));
                            },
                            child: TournamentCard(
                              status: "Upcoming",
                              statusColor:
                                  const Color(0xFF805724).withOpacity(.7),
                              gameMode: "Solo",
                              gameModeColor: Colors.blue,
                              statusTextColor: const Color(0xFFFDEB56),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const SquadTournamentScreen(),
                              ));
                            },
                            child: TournamentCard(
                              status: "Ongoing",
                              statusColor:
                                  const Color(0xFF183514).withOpacity(.7),
                              gameMode: "Squad",
                              gameModeColor: Colors.purple,
                              statusTextColor: const Color(0xFF1FD031),
                            ),
                          ),
                          TournamentCard(
                            status: "Registration Ongoing",
                            statusColor:
                                const Color(0xFF183514).withOpacity(.7),
                            gameMode: "Squad",
                            gameModeColor: Colors.purple,
                            statusTextColor: const Color(0xFF1FD031),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const FloatingNavWidget(),
        ],
      ),
    );
  }
}

class TournamentCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String gameMode;
  final Color gameModeColor;
  final Color statusTextColor;

  const TournamentCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.gameMode,
    required this.gameModeColor,
    required this.statusTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1923),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side - Image with status and location
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/bg/game_bg.jpeg',
                  width: 140,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    status,
                    style: AppTextStyles.small(
                      size: 10,
                      fontWeight: FontWeight.bold,
                      color: statusTextColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 6,
                left: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF183514).withOpacity(.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        "Jeddah, Saudi...",
                        style: AppTextStyles.small(
                          size: 10,
                          color: const Color(0xFF1FD031),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Right Side - Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PUBG Mobile\nMena Summer",
                  style: AppTextStyles.small(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Prize Money
                    Text("Prize Money:",
                        style: AppTextStyles.small(color: Colors.grey)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.attach_money,
                            color: Colors.blue, size: 16),
                        const SizedBox(width: 4),
                        Text("500 USD",
                            style: AppTextStyles.small(color: Colors.blue)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Game Mode
                    Text("Game Mode:",
                        style: AppTextStyles.small(color: Colors.grey)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.person,
                            color: Colors.white54, size: 16),
                        const SizedBox(width: 4),
                        Text(gameMode,
                            style: AppTextStyles.small(color: gameModeColor)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Date
                    Text("Date:",
                        style: AppTextStyles.small(color: Colors.grey)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text("09 Aug, 2024",
                            style: AppTextStyles.small(color: Colors.amber)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
