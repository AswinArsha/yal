import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/feature/game_section/presentation/pages/game_overview.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  bool isScreenDisabled = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    // Optional 4-second delay before allowing unlock
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        // Still requires user interaction to unlock
        // You can auto-unlock here if you want by setting isScreenDisabled = false;
      });
    });
  }

  void _unlockScreen() {
    setState(() {
      isScreenDisabled = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg/game_bg.jpeg', // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),

            // Main content with tab bar and button
            Positioned.fill(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Row(
                        children: [
                          const CustomArrowBack(),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                // All Games button (selected)
                                GestureDetector(
                                  onTap: () {
                                    _tabController.index = 0;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: _tabController.index == 0
                                          ? Colors.blue.withOpacity(0.2)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      'All Games',
                                      style: TextStyle(
                                        color: Colors.lightBlue[
                                            100], // Brighter when selected
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // Newest button with inline red dot
                                GestureDetector(
                                  onTap: () {
                                    _tabController.index = 1;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Newest',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                                _tabController.index == 1
                                                    ? 1
                                                    : 0.7),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.red,
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        Center(
                            child: Text('',
                                style: TextStyle(color: Colors.white))),
                        Center(
                            child: Text('',
                                style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 24.0, left: 16, right: 16),
                    child: Column(
                      children: [
                        ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const DinoGameScreen()));
                            },
                            leading: const CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/bg/game_bg.jpeg'),
                            ),
                            title: const Text(
                              ' Dino T-Rex',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            subtitle: const Text(
                              'Copyright by "Yalgamers"',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            trailing: const Icon(
                                size: 15,
                                Icons.info_outline,
                                color: Colors.blue)),
                        const Divider(thickness: 0.1, color: Colors.grey),
                        const SizedBox(height: 5),
                        PrimaryButton(
                          textColor: Colors.black,
                          label: 'Play Now',
                          gradient: buttonGradience(),
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (isScreenDisabled)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _unlockScreen,
                  onVerticalDragUpdate: (_) => _unlockScreen(),
                  child: Container(
                    color: Colors.grey.shade900.withValues(alpha: 0.7),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.swipe, color: Colors.white, size: 40),
                          SizedBox(height: 12),
                          Text(
                            "Scroll!",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
