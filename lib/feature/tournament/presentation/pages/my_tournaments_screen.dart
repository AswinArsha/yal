import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/top_nav_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/welcome_profile_widget.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/create_tournament_screen.dart'; 
import 'package:yalgamers/feature/tournament/presentation/widgets/floating_nav_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyTournamentsScreen extends StatefulWidget {
  const MyTournamentsScreen({super.key});

  @override
  State<MyTournamentsScreen> createState() => _MyTournamentsScreenState();
}

class _MyTournamentsScreenState extends State<MyTournamentsScreen> {
  int selectedTab = 0; // 0 for Joined Tournament, 1 for Created Tournament
  bool hasAccess = false; // Track if user has access to create tournaments

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.background,
    body: SafeArea( // Wrap body in Stack
      child: Stack(
          children: [
        // Your existing UI
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/tournament/tournament_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              
              const TopNavWidget(),
              const WelcomeProfileWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tab Selection Container
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0x08FFFFFF),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0x08FFFFFF),
                          ),
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.only(bottom: 20),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Your existing tab selection code...
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTab = 0;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: selectedTab == 0 
                                          ? const Color(0x1AFFFFFF) 
                                          : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                                    margin: const EdgeInsets.symmetric(vertical: 0),
                                    width: double.infinity,
                                    child: Text(
                                      "Joined Tournament",
                                      style: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTab = 1;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: selectedTab == 1 
                                          ? const Color(0x1AFFFFFF) 
                                          : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                    width: double.infinity,
                                    child: Text(
                                      "Created Tournament",
                                      style: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Content based on selected tab
                        if (selectedTab == 1) _buildCreatedTournamentContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Add FloatingNavWidget as overlay
        const FloatingNavWidget(currentTabIndex: 2),
      ],
    ),
    ),
  );
}

  Widget _buildCreatedTournamentContent() {
    if (!hasAccess) {
      // Show the "no access" content
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 14, bottom: 46, left: 13, right: 13),
            width: 112,
            height: 112,
            child: SvgPicture.asset(
                    "assets/images/tournament/tournament/unavailable.svg",
  fit: BoxFit.fill,
),  
  

          ),
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8, left: 22, right: 22),
                  width: double.infinity,
                  child: const Text(
                    "You don't have access to create tournaments.",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: const Text(
                    "Can't create tournaments yet. \nGet access first.",
                    style: TextStyle(
                      color: Color(0xCCFFFFFF),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                hasAccess = true; // Grant access when button is pressed
              });
              print('Pressed Get Access');
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0x26FFFFFF),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment(1, -1),
                  end: Alignment(1, 1),
                  colors: [
                    Color(0xFF51F257),
                    Color(0xFF2F8C32),
                  ],
                ),
              ),
              padding: const EdgeInsets.only(top: 11, bottom: 11, left: 24, right: 24),
              child: const Text(
                "Get Access",
                style: TextStyle(
                  color: Color(0xFF07280A),
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // Show the tournament list content
      return _buildTournamentList();
    }
  }

  Widget _buildTournamentList() {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "My Created Tournament",
                      style: TextStyle(
                        color: Color(0xE6FFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () { 
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateTournamentScreen(),
                      ),
                    );
                    print('Pressed Create New'); 
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0x26FFFFFF),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment(1, -1),
                        end: Alignment(1, 1),
                        colors: [
                          Color(0xFFFDEB56),
                          Color(0xFFAB9E3A),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: const EdgeInsets.only(right: 6),
                          width: 14,
                          height: 14,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                          child: SvgPicture.asset(
  "assets/images/tournament/clans/add-01.svg",
  fit: BoxFit.fill,
),

                          )
                        ),
                        Text(
                          "Create New",
                          style: TextStyle(
                            color: Color(0xFF24210A),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ]
            ),
          ),
          // Tournament cards
          _buildTournamentCard(
            imageUrl: "assets/images/tournament/tournament/created_tournaments.png",
            status: "Upcoming",
            statusColor: Color(0xFFFDEB56),
            statusBgColor: Color(0x33FDEB56),
            statusBorderColor: Color(0x1AFDEB56),
          ),
          SizedBox(height: 10),
          _buildTournamentCard(
            imageUrl: "assets/images/tournament/tournament/created_tournaments.png",
            status: "Finished",
            statusColor: Color(0xFFFF4949),
            statusBgColor: Color(0x33D62121),
            statusBorderColor: Color(0xFFD62121),
          ),
          SizedBox(height: 10),
          _buildTournamentCard(
            imageUrl: "assets/images/tournament/tournament/created_tournaments.png",
            status: "Finished",
            statusColor: Color(0xFFFF4949),
            statusBgColor: Color(0x33D62121),
            statusBorderColor: Color(0xFFD62121),
      
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentCard({
    required String imageUrl,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
    required Color statusBorderColor,
    bool isCompact = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0x0DFFFFFF),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
        color: Color(0x0DFFFFFF),
      ),
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 6, 
                bottom: isCompact ? 68 : 162
              ),
             margin: const EdgeInsets.only(right: 12),
width: double.infinity,
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(6),
  image: DecorationImage(
    image: AssetImage(imageUrl), // Changed from NetworkImage to AssetImage
    fit: BoxFit.cover
  ),
),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () { 
                      print('Pressed $status'); 
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: statusBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        color: statusBgColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      margin: const EdgeInsets.only(left: 6),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: isCompact ? const EdgeInsets.only(top: 12) : EdgeInsets.zero,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    width: double.infinity,
                    child: Text(
                      "PUBG Mobile Mena Summer",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (!isCompact) ...[
                    _buildInfoRow(
                      label: "Prize Money:",
                      value: "500 USD",
                      iconUrl: "assets/images/tournament/tournament/dollar-circle.svg",
                      valueColor: Color(0xFF8EC9ED),
                    ),
                    SizedBox(height: 6),
                    _buildInfoRow(
                      label: "Game Mode:",
                      value: "Solo",
                      iconUrl: "assets/images/tournament/tournament/user.svg",
                      valueColor: Color(0xFF8EC9ED),
                    ),
                    SizedBox(height: 6),
                    _buildInfoRow(
                      label: "Date:",
                      value: "09 Aug, 2024",
                      iconUrl: "assets/images/tournament/tournament/Calendar.svg",
                      valueColor: Color(0xFFFDEB56),
                      iconSize: Size(10, 11),
                    ),
                  ] else ...[
                    _buildInfoRow(
                      label: "Prize Money:",
                      value: "500 USD",
                      iconUrl: "assets/images/tournament/tournament/dollar-circle.svg",
                      valueColor: Color(0xFF8EC9ED),
                      iconSize: Size(14, 10),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required String iconUrl,
    required Color valueColor,
    Size iconSize = const Size(14, 14),
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 1),
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10,
            ),
          ),
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4),
              width: iconSize.width,
              height: iconSize.height,
              child: SvgPicture.asset(
                iconUrl,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
