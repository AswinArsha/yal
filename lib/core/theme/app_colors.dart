import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF100613);
  static const Color card = Color(0xFF1C121F);
  static const Color appBarBackground = Color.fromRGBO(51, 41, 52, 1);
  // Primary & Accent
  static const Color primary = Color(0xFFF71756);
  static const Color secondary = Color(0xFFFDEB56);
  static const Color third = Color(0xFF241A26);

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white60;
  static const Color textHint = Color(0xFF575059);
  static const Color textMuted = Colors.white38;
  static const Color textNormal = Color(0xFF706A71);
  static const Color baseWhite = Color.fromRGBO(255, 255, 255, 1.0);

  // Borders
  static const Color border = Color(0xFF271E2A);

  // Buttons
  static const Color buttonBackground = Color(0xFF241A26);
  static const Color buttonText = Color(0xFFBDBABD);

  // Social Icons background
  static const Color socialIconBg = Colors.white10;

  // Others
  static const Color yellow = Colors.yellow;
  static const Color tabbarColor = Color.fromRGBO(255, 255, 255, 0.04);

  // card colors

  static const Color purple = Color.fromRGBO(188, 90, 215, 1);
  static const Color blue = Color.fromRGBO(142, 201, 237, 1.0);
  static const Color xpColor = Color.fromRGBO(253, 235, 86, 1.0);
  static const Color red = Color.fromRGBO(247, 23, 86, 1.0);
}

//button gradient colors

LinearGradient buttonGradience() {
  return const LinearGradient(
    colors: [
      Color(0xFFF71756),
      Color(0xFFFDEB56),
    ],
  );
}
