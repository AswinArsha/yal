import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/secrets/app_secrets.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/select_layout.dart';
import 'package:yalgamers/feature/splash/presentation/pages/on_boarding_screen.dart';
import 'package:yalgamers/feature/login/presentation/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextScreen();
      }
    });
  }

  final secureStorage = const FlutterSecureStorage();
  Future<void> _navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final accessToken = await secureStorage.read(key: 'accessToken');

    // If onboarding not seen, go to onboarding
    if (!hasSeenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
      return;
    }

    // If accessToken is available, validate it using whoami API
    if (accessToken != null && accessToken.isNotEmpty) {
      final response = await TokenService.get(
        AppUrls.whoamiURL,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Valid token, navigate to home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SelectLayoutScreen()),
        );
        return;
      } else {
        // Invalid token - clear storage and go to login
        await TokenService.clearAll();
      }
    }

    // If no token or invalid token
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF100613),
              Color(0xFF100613),
              Color(0xFF291B20),
            ],
            stops: [
              0.0,
              0.60,
              1.0,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logos/app-logo.png',
                    height: 120,
                  ),
                  Image.asset(
                    'assets/images/logos/app-title.png',
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _controller.value,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade800,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.yellow),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Copyright © 2024 YAL GAMERS',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
