import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/pages/login_screen.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/splash/presentation/widgets/onboarding_appbar.dart';
import 'dart:ui';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> titles = [
    "Powering the future of web 3.0 gaming in the mena region.",
    "Articles and Tutorials about latest web3 games at the same place.",
    "Enjoy, earn from local tournaments on your city, and from online.",
  ];

  void _nextPage() {
    if (_currentPage < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
              child: Column(
                children: [
                  const OnboardingAppBar(),
                  const SizedBox(height: 60),
                  Container(
                    height: 250,
                    color: const Color.fromARGB(
                      30,
                      255,
                      255,
                      255,
                    ),
                    child: Center(
                      child: Text(
                        'Video',
                        style:
                            AppTextStyles.large(size: 34, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  titleAndDots(),
                  const Spacer(),
                  if (_currentPage == 2)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: PrimaryButton(
                          textColor: Colors.black,
                          label: 'Get Started',
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF416C), Color(0xFFFFD200)],
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('hasSeenOnboarding', true);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              left: _currentPage == 1 ? null : -170,
              right: _currentPage == 1 ? -170 : null,
              top: 150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _currentPage == 1
                          ? Colors.purple.withValues(alpha: 0.3)
                          : _currentPage == 2
                              ? Colors.orange.withValues(alpha: 0.3)
                              : Color(0xFF8EC9ED).withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                    radius: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////////////////

  SizedBox titleAndDots() {
    return SizedBox(
      height: 180,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    titles[index],
                    style: AppTextStyles.medium(
                        color: Colors.white,
                        size: 24,
                        fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white10,
                child: IconButton(
                  onPressed: _prevPage,
                  icon: const Icon(Icons.arrow_back_ios_outlined,
                      color: Colors.white),
                  iconSize: 14,
                ),
              ),
              Row(
                children: List.generate(
                  3,
                  (index) {
                    bool isActive = _currentPage == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 30 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.yellow : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  },
                ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white10,
                child: IconButton(
                  onPressed: _nextPage,
                  icon: const Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.white),
                  iconSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
