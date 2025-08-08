import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/feature/find_players/presentation/pages/find_players.dart';
import 'package:yalgamers/feature/game_section/presentation/pages/game_loading.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/homescreen.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/more_drawer.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/bottom_nav_item.dart';
import 'package:yalgamers/feature/quest/presentation/pages/quest_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _pageIndex = 0;
  bool _isNavVisible = true;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _setPage(int index) {
    if (index == 4) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      setState(() {
        _pageIndex = index;
      });
    }
  }
String? name;
  String? userName;

  Future<void> _loadUser() async {
    final user = await TokenService.getUser();
    setState(() {
      name = user?['name'] ?? 'Guest';
      userName=user?['username']??"guest_user";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isNavVisible) setState(() => _isNavVisible = false);
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isNavVisible) setState(() => _isNavVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(scrollController: _scrollController),
      const QuestScreen(),
      const GameScreen(),
      const FindPlayersScreen(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      extendBody: true,
      endDrawer: buildDrawer(name??"Guest", userName ?? "guest_user"),
      body: screens[_pageIndex],
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _isNavVisible ? const Offset(0, 0) : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isNavVisible ? 1.0 : 0.0,
          child: FloatingActionButton(
            elevation: 5,
            backgroundColor: const Color(0xFF8EC9ED),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xFFA3DCFF)),
              borderRadius: BorderRadius.circular(100),
            ),
            onPressed: () => _setPage(2),
            child: Icon(
              Icons.sports_esports_outlined,
              size: 30,
              color: _pageIndex == 2 ? Colors.white : AppColors.background,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _isNavVisible ? const Offset(0, 0) : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isNavVisible ? 1.0 : 0.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomAppBar(
              color: const Color(0xFF271E2A),
              elevation: 5,
              notchMargin: 5,
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavItem(
                    selectedImage: 'assets/bottom_nav/home_color.png',
                    image: 'assets/bottom_nav/home_grey.png',
                    label: 'Home',
                    isSelected: _pageIndex == 0,
                    onTap: () => _setPage(0),
                  ),
                  BottomNavItem(
                    selectedImage: 'assets/bottom_nav/quest_color.png',
                    image: 'assets/bottom_nav/quest_grey.png',
                    label: 'Quest',
                    isSelected: _pageIndex == 1,
                    onTap: () => _setPage(1),
                  ),
                  const SizedBox(width: 48),
                  BottomNavItem(
                    selectedImage: 'assets/bottom_nav/find_player_color.png',
                    image: 'assets/bottom_nav/find_player_grey.png',
                    label: 'Find Players',
                    isSelected: _pageIndex == 3,
                    onTap: () => _setPage(3),
                  ),
                  BottomNavItem(
                    selectedImage: 'assets/bottom_nav/more_color.png',
                    image: 'assets/bottom_nav/more_grey.png',
                    label: 'More',
                    isSelected: false,
                    onTap: () => _setPage(4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
