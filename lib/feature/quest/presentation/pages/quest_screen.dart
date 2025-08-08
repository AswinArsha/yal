import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/contents/daily_quest_content.dart';
import 'package:yalgamers/feature/quest/presentation/contents/project_quest_tab.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/custom_tabbar.dart';

class QuestScreen extends StatelessWidget {
  final List<Tab> myTabs = const <Tab>[
    Tab(text: 'Daily Quest'),
    Tab(text: 'Project Quest'),
  ];

  const QuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              ColoredBox(
                color: const Color(0xFF150B18),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(28, 18, 31, 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Quest',
                                style: AppTextStyles.mediumBold(
                                    size: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              radius: 20,
                              child: Image.asset(
                                'assets/icons/hamburger.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTabBar(myTabs: myTabs),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    const DailyQuestTabContent(),
                    GestureDetector(
                      onTap: () {
                        context.read<ProjectBloc>().add(LoadProjects());
                      },
                      child: const ProjectQuestTabContent(),
                    ),
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
