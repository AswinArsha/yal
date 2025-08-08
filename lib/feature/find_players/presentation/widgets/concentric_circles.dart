
import 'package:flutter/material.dart';

class ConcentricCirclesPainter extends CustomPainter {
  final double maxRadius;
  final int circleCount;
  final double animationValue; // 0.0 to 1.0

  ConcentricCirclesPainter({
    required this.maxRadius,
    this.circleCount = 3,
    this.animationValue = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < circleCount; i++) {
      // Calculate progress per circle with offset for animation
      double progress = ((animationValue + i / circleCount) % 1.0);
      final radius = maxRadius * progress;

      // Fade circle out as it grows
      paint.color = Colors.white.withOpacity(1.0 - progress);

      if (radius > 0) {
        canvas.drawCircle(center, radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ConcentricCirclesPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
