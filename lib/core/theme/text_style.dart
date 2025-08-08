import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static const Color _defaultColor = Colors.black;

  static const double _superLargeSize = 28;
  static const double _largeSize = 20;
  static const double _mediumSize = 16;
  static const double _smallSize = 14;
  static const double _verySmallSize = 12;

  static TextStyle superLarge({
    Color color = _defaultColor,
    double size = _superLargeSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle superLargeBold({
    Color color = _defaultColor,
    double size = _superLargeSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle large({
    Color color = _defaultColor,
    double size = _largeSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle largeBold({
    Color color = _defaultColor,
    double size = _largeSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle medium({
    Color color = _defaultColor,
    double size = _mediumSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle mediumBold({
    Color color = _defaultColor,
    double size = _mediumSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle mediumWithLine({
    Color color = _defaultColor,
    double size = _mediumSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
      decoration: TextDecoration.lineThrough,
    );
  }

  static TextStyle small({
    Color color = _defaultColor,
    double size = _smallSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle smallBold({
    Color color = _defaultColor,
    double size = _smallSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle smallW600({
    Color color = _defaultColor,
    double size = _smallSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle verySmall({
    Color color = _defaultColor,
    double size = _verySmallSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle verySmallBold({
    Color color = _defaultColor,
    double size = _verySmallSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  static TextStyle verySmallWithLine({
    Color color = _defaultColor,
    double size = _verySmallSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
      decoration: TextDecoration.lineThrough,
    );
  }

  static TextStyle verySmallWithUnderLine({
    Color color = _defaultColor,
    double size = _verySmallSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.poppins(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: TextDecoration.underline,
        decorationThickness: 1.3);
  }
}
