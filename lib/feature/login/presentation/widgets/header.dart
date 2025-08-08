import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: const Color(0xFF1C121F),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logos/app-logo.png',
          ),
          const SizedBox(width: 20),
          Image.asset(
            'assets/images/logos/app-title.png',
          ),
        ],
      ),
    );
  }
}
