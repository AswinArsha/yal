import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/achievements/presentation/pages/achievements_screen.dart';
import 'package:yalgamers/feature/find_players/presentation/pages/view_profile.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/settings_screen.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/tournament_layout.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/logout_button.dart';
import 'package:yalgamers/feature/login/google_auth/bloc/google_sign_in_bloc.dart';
import 'package:yalgamers/feature/login/google_auth/bloc/google_sign_in_event.dart';
import 'package:yalgamers/feature/login/google_auth/bloc/google_sign_in_state.dart';
import 'package:yalgamers/feature/login/presentation/pages/login_screen.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';
import 'package:yalgamers/feature/support_ticket/presentation/pages/support_ticket.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_layout.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_list_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_screen.dart';

Widget buildDrawer(String name,String userName) {
  return Drawer(
    backgroundColor: const Color(0xFF1C1422),
    child: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // User info
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const ViewProfileScreen();
                              },
                            ));
                          },
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage("assets/user.png"),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: AppTextStyles.mediumBold(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.9),
                                      size: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                   userName != null
                                      ? '@$userName'
                                      : 'Loading...'  ,
                                    style: AppTextStyles.small(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.6),
                                      size: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 12,
                                color: AppColors.baseWhite.withOpacity(0.6),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Divider(
                          height: 0,
                          color: Color(0xFF281E2A),
                        ),
                        const SizedBox(height: 12),
                        // My Level Card
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "My Level",
                                    style: AppTextStyles.medium(
                                      fontWeight: FontWeight.w500,
                                      size: 14,
                                      color: const Color.fromRGBO(
                                          212, 207, 214, 1),
                                    ),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    'assets/icons/star_badge.png',
                                    height: 36.h,
                                    width: 48.w,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    "Level 1: ",
                                    style: AppTextStyles.medium(
                                      fontWeight: FontWeight.w400,
                                      size: 12,
                                      color: const Color.fromRGBO(
                                          158, 147, 127, 1),
                                    ),
                                  ),
                                  Text(
                                    "Novice Explorer",
                                    style: AppTextStyles.medium(
                                      fontWeight: FontWeight.w400,
                                      size: 12,
                                      color:
                                          const Color.fromRGBO(253, 235, 86, 1),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Stack(
                                children: [
                                  Container(
                                    height: 6.h,
                                    width: double.infinity,
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
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    "703XP / 1000XP",
                                    style: AppTextStyles.medium(
                                      fontWeight: FontWeight.w400,
                                      size: 12,
                                      color: const Color.fromRGBO(
                                          126, 110, 131, 1),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "297 XP Until Level 2",
                                    style: AppTextStyles.medium(
                                      fontWeight: FontWeight.w400,
                                      size: 12,
                                      color: const Color.fromRGBO(
                                          126, 110, 131, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Achievements Card
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const AchievementsScreen();
                              },
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(253, 235, 86, 0.05),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 65.h,
                                  width: 65.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color.fromRGBO(77, 56, 48, 1),
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          253, 235, 86, 0.8),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/3star.png',
                                      height: 30.h,
                                      width: 30.w,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My Achievements",
                                      style: AppTextStyles.medium(
                                        fontWeight: FontWeight.w500,
                                        size: 12,
                                        color: const Color.fromRGBO(
                                            227, 223, 183, 1),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Current Badge:",
                                      style: AppTextStyles.small(
                                        fontWeight: FontWeight.w400,
                                        size: 10,
                                        color: const Color.fromRGBO(
                                            158, 147, 127, 1),
                                      ),
                                    ),
                                    Text(
                                      "Original Gangstar",
                                      style: AppTextStyles.small(
                                        fontWeight: FontWeight.w500,
                                        size: 12,
                                        color: const Color.fromRGBO(
                                            253, 235, 86, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 12,
                                  color: AppColors.baseWhite.withOpacity(0.6),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Divider(
                          height: 0,
                          color: Color(0xFF281E2A),
                        ),
                        // Settings
                        ListTile(
                          leading: const Icon(
                            Icons.settings_outlined,
                            color: Color.fromRGBO(157, 249, 255, 0.8),
                            size: 20,
                          ),
                          title: Text(
                            "Setting",
                            style: AppTextStyles.small(
                              fontWeight: FontWeight.w400,
                              size: 14,
                              color: AppColors.baseWhite.withOpacity(0.8),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ));
                          },
                        ),

                        // Support
                        ListTile(
                          leading: Image.asset(
                            'assets/icons/customer-service-01.png', // Replace with your actual image path
                            width: 20,
                            height: 20,
                          ),
                          title: Text(
                            "Support Ticket",
                            style: AppTextStyles.small(
                              fontWeight: FontWeight.w400,
                              size: 14,
                              color: AppColors.baseWhite.withOpacity(0.8),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const SupportTicketScreen();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom pinned section
                Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          color: AppColors.baseWhite.withOpacity(0.05),
                          width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/white_sword.png', // replace with your asset path
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            activeColor: Colors.purple,
                            inactiveTrackColor: Colors.white.withAlpha(50),
                            inactiveThumbColor: Colors.white10,
                            value: false,
                            onChanged: (val) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TournamentLayoutScreen(),
                                ),
                              );
                            },
                            title: const Text(
                              "E Sports Mode",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocListener<GoogleSignInBloc, GoogleSignInState>(
                    listener: (context, state) {
                      if (state is LogoutSuccess) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoginScreen()), // Or your actual login route
                          (route) => false,
                        );
                      } else if (state is LogoutFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Logout failed: ${state.message}')),
                        );
                      }
                    },
                    child: BlocBuilder<GoogleSignInBloc, GoogleSignInState>(
                      builder: (context, state) {
                        final isLoading = state is GoogleSignInLoading;

                        return GestureDetector(
                          onTap: isLoading
                              ? null
                              : () {
                                  context
                                      .read<GoogleSignInBloc>()
                                      .add(StartLogout());
                                },
                          child: SizedBox(
                            height: 50.h,
                            width: double.infinity,
                            child: LogoutButton(
                              padding: const EdgeInsets.all(8),
                              radius: 6,
                              luminousColor: const Color(0xFFF71756),
                              label: isLoading ? 'Logging out...' : 'Logout',
                              prefixIcon: Icons.logout,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              iconSize: 20.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ]),
              ],
            ),
          );
        },
      ),
    ),
  );
}
