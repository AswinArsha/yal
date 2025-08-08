import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final String assetPath;

  const SocialIcon({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        assetPath,
        height: 24,
        width: 24,
      ),
    );
  }
}
