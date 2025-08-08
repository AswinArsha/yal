import 'package:flutter/material.dart';

class NotificationDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.pinkAccent;
    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final dotRadius = 3.0;
    final center = Offset(size.width * 0.65, size.height * 0.28); // adjust for top-right

    // Draw dot
    canvas.drawCircle(center, dotRadius, paint);
    canvas.drawCircle(center, dotRadius, borderPaint); // optional black border
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
