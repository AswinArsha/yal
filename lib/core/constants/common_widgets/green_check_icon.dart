import 'package:flutter/material.dart';

class GreenCheckIcon extends StatelessWidget {
  const GreenCheckIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF1D2E21),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ClipOval(
          child: Image.asset(
            'assets/icons/check-circle.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
