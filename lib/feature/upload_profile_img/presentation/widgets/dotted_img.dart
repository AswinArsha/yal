import 'package:flutter/material.dart';
import 'dart:math';

class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const int numberOfCircles = 5;
    for (int i = 1; i <= numberOfCircles; i++) {
      final radius = (size.width / 2) * (i / numberOfCircles);

      drawDottedCircle(canvas, size.center(Offset.zero), radius, paint);
    }
  }

  void drawDottedCircle(Canvas canvas, Offset center, double radius, Paint paint) {
    const double gapSize = 5;
    const double dashSize = 5;
    final double circumference = 2 * pi * radius;
    final int dashCount = (circumference / (dashSize + gapSize)).floor();

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = (2 * pi / dashCount) * i;
      final Offset start = Offset(
        center.dx + radius * cos(startAngle),
        center.dy + radius * sin(startAngle),
      );
      canvas.drawCircle(start, 1, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
