import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/feature/game_section/presentation/pages/game_description.dart';
import 'package:yalgamers/feature/game_section/presentation/pages/leaderboard.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/game_img_card.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/see_more.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/custom_tabbar.dart';

class DinoGameScreen extends StatelessWidget {
  final List<Tab> myTabs = const <Tab>[
    Tab(text: 'Leaderboard'),
    Tab(text: 'Details'),
  ];

  const DinoGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A1A2E),
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomArrowBack(),
          ),
          title: const Text('Dino T-Rex',
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromARGB(255, 12, 12, 21),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                gameImageCard(context),
                const SizedBox(height: 12),
                const Text('Dino T-Rex',
                    style: TextStyle(fontSize: 22, color: Colors.white)),
                const ExpandableTextWithSeeMore(
                  text:
                      'Dino T-Rex Glove Camel is a 2D browser game similar to the famous T-Rex game, worthy of mention. The events are engaging and fun for all ages.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                CustomTabBar(myTabs: myTabs),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Leaderboard Tab
                      buildLeaderboardTab(leaderboard),

                      const GameDescription(),
                    ],
                  ),
                ),
                PrimaryButton(
                  textColor: Colors.black,
                  label: 'Play Now',
                  gradient: buttonGradience(),
                  onPressed: () {
                    // Game launch logic
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
