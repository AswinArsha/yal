import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yalgamers/core/constants/common_widgets/custom_app_bar.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/register_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/game_center_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/game_info_card.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/matches_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/players_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/rewards_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/sponsor_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/stream_widget.dart';
import 'package:yalgamers/feature/wallet/presentation/pages/send_screen.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({super.key});

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  int selectedTabIndex = 0;
  final List<String> tabs = [
    'Overview',
    'Rewards',
    'Players',
    'Matches',
    'Game Center',
    'Stream',
    'Sponsor'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: CustomAppBar(title: 'PUBG mobile mena...'),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            padding:
                const EdgeInsets.only(bottom: 140), // space for bottom overlay
            child: Column(
              children: [
                // Tournament Banner

                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.26,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/bg/game_bg.jpeg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF443F20),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Upcoming',
                                  style: AppTextStyles.small(
                                    color: Color(0xFFFDEB56),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    // Background pattern
                  ],
                ),

                // Mode Selection
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildModeChip('Solo', true),
                      const SizedBox(width: 8),
                      _buildModeChip('Registration Ongoing', false,
                          isStatus: true),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Tournament Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'PUBG Mobile Mena Summer',
                      style: AppTextStyles.small(
                        color: Colors.white,
                        size: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                  color: Color(0xFF271E2A),
                  height: 2,
                ),

                // Tab Bar - Now horizontally scrollable
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < tabs.length; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTabIndex = i;
                            });
                          },
                          child: _buildTab(tabs[i], selectedTabIndex == i),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Tab Content
                _buildTabContent(),

                const SizedBox(height: 12),

                // Details Section (only show in Overview)
                if (selectedTabIndex == 0) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Details',
                        style: AppTextStyles.small(
                          color: Colors.white,
                          size: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Welcome to the heart-pounding spectacle that is The Red Village Survival Championship – an eagerly anticipated annual event that unites adventurers and thrill-seekers from diverse backgrounds. Nestled in the breathtaking landscapes of the Red Village, this survival tournament is not just a competition, it's a journey into the realms of skill, strategy, and endurance.Imagine an immersive experience where participants, driven by passion and determination, converge to face the ultimate test of their abilities. The Red Village Survival Championship transforms the serene ambiance of Red Village into a battleground for those seeking to push the boundaries of physical and mental prowess.Set against the backdrop of the enchanting Red Village, surrounded by rolling hills and lush forests, this championship is more than just a series of challenges – it's an odyssey. Participants find themselves in a dynamic arena where every twist and turn unveils a new test, each more demanding than the last. From navigating dense woodlands to crossing tumultuous rivers, competitors must summon their survival instincts to conquer the unforgiving wilderness.The tournament is a meticulously crafted adventure, combining elements of athleticism, problem-solving, and teamwork. An intricate obstacle course awaits, designed to challenge agility and resilience. Puzzles, both physical and mental, dot the landscape, ensuring that participants must not only conquer the terrain but also engage their minds in the pursuit of victory.",
                      style: AppTextStyles.small(
                        color: Colors.white70,
                        size: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Divider(
                    color: Color(0xFF271E2A),
                    height: 2,
                  ),
                  const SizedBox(height: 12),
                  GameInfoCard(
                    imagePath: 'assets/images/bg/game_bg.jpeg',
                    deviceType: 'Mobile',
                    gameName: "The First Adventure",
                  ),
                ]
              ],
            ),
          ),

          // Floating Countdown + Register Button

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(16, 6, 19, 0.0), // rgba(16, 6, 19, 0.00)
                    Color.fromRGBO(16, 6, 19, 0.95), // rgba(16, 6, 19, 0.95)
                  ],
                  stops: [0.0, 0.255], // 0% and 25.5%
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Registration Time Left',
                    style: AppTextStyles.small(
                        color: Color(0xFF878289),
                        size: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '08d : 12h : 32m : 46s',
                    style: AppTextStyles.small(
                      color: Colors.white,
                      size: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      print("object");
                    },
                    child: PrimaryButton(
                      label: "Register Now",
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return RegistrationScreen();
                          },
                        ));
                      },
                      gradient: buttonGradience(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 0: // Overview
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildInfoRow(Icons.people, '16 Players'),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child:
                        _buildInfoRow(Icons.monetization_on, '\$00 Entry Fee'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoRow(Icons.schedule, 'Registration Starts in 32h:32m'),
              const SizedBox(height: 8),
              Divider(
                color: Color(0xFF271E2A),
                height: 2,
              ),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.group_add, '04 Players Joined',
                  color: Colors.green),
              const SizedBox(height: 16),
              _buildInfoRow(Icons.event, 'Match Starts on 01 March, 2025'),
              const SizedBox(height: 8),
              Divider(
                color: Color(0xFF271E2A),
                height: 2,
              ),
            ],
          ),
        );
      case 1: // Rewards
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TournamentRewardsWidget(),
        );
      case 2: // Players
        return PlayersWidget();
      case 3: // Matches

        return TournamentBracketWidget(
          rounds: [
            TournamentRound(
              title: 'Round 1',
              matches: [
                Match(
                    player1: 'Player 1',
                    player2: 'Player 2',
                    matchLabel: 'Match 1'),
                Match(
                    player1: 'Player 3',
                    player2: 'Player 4',
                    matchLabel: 'Match 2'),
                Match(
                    player1: 'Player 5',
                    player2: 'Player 6',
                    matchLabel: 'Match 3'),
                Match(
                    player1: 'Player 7',
                    player2: 'Player 8',
                    matchLabel: 'Match 4'),
                Match(
                    player1: 'Player 9',
                    player2: 'Player 10',
                    matchLabel: 'Match 5'),
                Match(
                    player1: 'Player 11',
                    player2: 'Player 12',
                    matchLabel: 'Match 6'),
                Match(
                    player1: 'Player 13',
                    player2: 'Player 14',
                    matchLabel: 'Match 7'),
                Match(
                    player1: 'Player 15',
                    player2: 'Player 16',
                    matchLabel: 'Match 8'),
              ],
            ),
            TournamentRound(
              title: 'Round 2',
              matches: [
                Match(
                    player1: 'Match 1 Winner',
                    player2: 'Match 2 Winner',
                    matchLabel: 'Match 1'),
                Match(
                    player1: 'Match 3 Winner',
                    player2: 'Match 4 Winner',
                    matchLabel: 'Match 2'),
                Match(
                    player1: 'Match 5 Winner',
                    player2: 'Match 6 Winner',
                    matchLabel: 'Match 3'),
                Match(
                    player1: 'Match 7 Winner',
                    player2: 'Match 8 Winner',
                    matchLabel: 'Match 4'),
              ],
            ),
            TournamentRound(
              title: 'Semi Finals',
              matches: [
                Match(
                    player1: 'Round 2 Match 1 Win',
                    player2: 'Round 2 Match 2 Win',
                    matchLabel: 'Match 1'),
                Match(
                    player1: 'Round 2 Match 3 Win',
                    player2: 'Round 2 Match 4 Win',
                    matchLabel: 'Match 2'),
              ],
            ),
            TournamentRound(
              title: 'Final',
              matches: [
                Match(
                    player1: 'Semi Final 1 Winner',
                    player2: 'Semi Final 2 Winner',
                    matchLabel: 'Final'),
              ],
            ),
          ],
        );
      case 4:
        return GameCenterWidget(
          imagePaths: [
            "assets/images/bg/gamecenter-1.png",
            "assets/images/bg/gamecenter-2.png"
          ],
        );
      case 5:
        return StreamWidget();
      case 6:
        return SponsorsSection();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildModeChip(String text, bool isSelected, {bool isStatus = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF292D3E)
            : isStatus
                ? const Color(0xFF111A16)
                : const Color(0xFF37474f),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) ...[
            const Icon(Icons.person, color: Color(0xFF8EC9ED), size: 16),
            const SizedBox(width: 4),
          ],
          if (isStatus) ...[
            const Icon(Icons.access_time, color: Color(0xFF1FD031), size: 16),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: AppTextStyles.small(
              color: isSelected ? Color(0xFF8EC9ED) : Color(0xFF1FD031),
              size: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFF8EC9ED) : Color(0xFF271E2A),
              width: 2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyles.small(
              color: isSelected ? const Color(0xFF8EC9ED) : Colors.white60,
              size: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? color}) {
    return Row(
      children: [
        Icon(
          icon,
          color: color ?? Colors.white70,
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: AppTextStyles.small(
            color: color ?? Colors.white70,
            size: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
