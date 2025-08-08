import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/floating_nav_widget.dart';

class TournamentListScreen extends StatelessWidget {
  final int initialTabIndex;
  
  const TournamentListScreen({super.key, this.initialTabIndex = 0});

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF140D1F),
    appBar: AppBar(
      backgroundColor: const Color(0xFF140D1F),
      title: Text(
        "Tournaments",
        style: AppTextStyles.small(
            color: Colors.white, size: 22, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {},
        )
      ],
    ),
    body: Stack( // Wrap body in Stack
      children: [
        // Your existing UI
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TournamentTabBar(initialIndex: initialTabIndex),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const TournamentScreen();
                          },
                        ));
                      },
                      child: TournamentCard(
                        status: "Upcoming",
                        statusColor: const Color(0xFF805724).withOpacity(.7),
                        gameMode: "Solo",
                        gameModeColor: Colors.blue,
                        statusTextColor: const Color(0xFFFDEB56),
                      ),
                    ),
                    TournamentCard(
                      status: "Ongoing",
                      statusColor: const Color(0xFF183514).withOpacity(.7),
                      gameMode: "Squad",
                      gameModeColor: Colors.purple,
                      statusTextColor: const Color(0xFF1FD031),
                    ),
                    TournamentCard(
                      status: "Registration Ongoing",
                      statusColor: const Color(0xFF183514).withOpacity(.7),
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
        
        // Add FloatingNavWidget as overlay
        const FloatingNavWidget(),
      ],
    ),
  );
}

}

class TournamentTabBar extends StatefulWidget {
  final int initialIndex;
  
  const TournamentTabBar({super.key, this.initialIndex = 0});

  @override
  State<TournamentTabBar> createState() => _TournamentTabBarState();
}

class _TournamentTabBarState extends State<TournamentTabBar> {
  late int selectedIndex;
  
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  final List<String> tabs = ['Local Tournaments', 'Online Tournaments'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1923),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF271E2A)),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  // Handle tab logic here if needed
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF342C37) : const Color(0xFF1E1521),
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: AppTextStyles.small(
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.w400 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }),
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

  const TournamentCard(
      {super.key,
      required this.status,
      required this.statusColor,
      required this.gameMode,
      required this.gameModeColor,
      required this.statusTextColor});

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
                  'assets/images/bg/game_bg.jpeg', // Replace with your asset
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
