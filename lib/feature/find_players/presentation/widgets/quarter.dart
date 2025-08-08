
import 'package:flutter/material.dart';

class QuarterFadedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..shader = SweepGradient(
        startAngle: 3 * 3.14 / 2, // 270°
        endAngle: 2 * 3.14, // 360°
        colors: [
          Colors.yellow.withOpacity(0.0),
          Colors.white,
          Colors.yellow.withOpacity(0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
        transform: const GradientRotation(3 * 3.14 / 2),
      ).createShader(rect);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3 * 3.14 / 2,
      3.14 / 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
