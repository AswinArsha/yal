import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/pages/login_screen.dart';

class OnboardingAppBar extends StatelessWidget {
  const OnboardingAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/logos/app-logo.png',
            height: 40,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/logos/app-title.png',
            height: 25,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('hasSeenOnboarding', true);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Skip >',
              style: AppTextStyles.small(color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}
