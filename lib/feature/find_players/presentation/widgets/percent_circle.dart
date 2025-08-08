import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class PercentageCircle extends StatelessWidget {
  final double percent; // e.g., 99 for "99%"

  const PercentageCircle({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(30, 30),
            painter: CircleBorderPainter(percent: percent),
          ),
          Text(
            '${percent.toInt()}%',
            style: AppTextStyles.small(
              size: 10,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(31, 208, 49, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleBorderPainter extends CustomPainter {
  final double percent;

  CircleBorderPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 2.0;
    final rect = Offset.zero & size;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = Colors.green.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final progressPaint = Paint()
      ..color = const Color.fromRGBO(31, 208, 49, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw arc for percentage
    double sweepAngle = 2 * 3.14159265359 * (percent / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159265359 / 2, // start at top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
