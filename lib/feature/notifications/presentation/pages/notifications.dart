import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/notifications/presentation/contents/gaming_task.dart';
import 'package:yalgamers/feature/notifications/presentation/contents/rewards_invit.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/custom_tabbar.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Rewards & Invitations'),
    const Tab(text: 'Gaming and Task'),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              ColoredBox(
                color: const Color.fromRGBO(28, 18, 31, 1),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CustomArrowBack(),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Notifications',
                                  style: AppTextStyles.small(
                                      fontWeight: FontWeight.w400,
                                      size: 12,
                                      color:
                                          AppColors.baseWhite.withOpacity(0.4)),
                                ),
                                const SizedBox(
                                    width: 5), // Reduced from 10 to 5
                                const CircleAvatar(
                                  backgroundColor:
                                      Color.fromRGBO(247, 23, 86, 1),
                                  radius: 10,
                                  child: Center(
                                    child: Text(
                                      '15',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomTabBar(myTabs: myTabs)
                    ],
                  ),
                ),
              ),
              const Flexible(
                child: TabBarView(
                  children: [
                    RewardsInvitationScreen(),
                    GamingTaskScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
