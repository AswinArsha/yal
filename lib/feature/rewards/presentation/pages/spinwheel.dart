import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/solid_button.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';

class DailySpinDialog extends StatefulWidget {
  const DailySpinDialog({super.key});

  @override
  DailySpinDialogState createState() => DailySpinDialogState();
}

class DailySpinDialogState extends State<DailySpinDialog>
    with TickerProviderStateMixin {
  late AnimationController _spinController;
  late Animation<double> _spinAnimation;
  ScrollController _dayScrollController = ScrollController();
  double _currentScrollOffset = 0.0;

  bool isSpinning = false;
  int spinsAvailable = 2;
  String selectedReward = '';
  bool showResult = false;

  final List<WheelSegment> segments = [
    WheelSegment('2X 50', const Color.fromRGBO(106, 148, 173, 1)), // Orange

    WheelSegment('50 XP', const Color.fromRGBO(187, 173, 60, 1)), // Purple
    WheelSegment('Bad Luck', const Color.fromRGBO(207, 0, 0, 1)), // Red
    WheelSegment('100 XP', const Color.fromRGBO(110, 51, 126, 1)), // Blue
    WheelSegment('2X 50', const Color.fromRGBO(106, 148, 173, 1)), // Orange
    WheelSegment('50 XP', const Color.fromRGBO(187, 173, 60, 1)), // Purple
    WheelSegment('Bad Luck', const Color.fromRGBO(207, 0, 0, 1)), // Red
    WheelSegment('100 XP', const Color.fromRGBO(110, 51, 126, 1)),

    WheelSegment('2X 50', const Color.fromRGBO(106, 148, 173, 1)), // Orange
    WheelSegment('50 XP', const Color.fromRGBO(187, 173, 60, 1)), // Purple
    WheelSegment('Bad Luck', const Color.fromRGBO(207, 0, 0, 1)), // Red
    WheelSegment('100 XP', const Color.fromRGBO(110, 51, 126, 1)), // Blue
  ];

  @override
  void initState() {
    super.initState();
// Add this in your initState():
    _dayScrollController.addListener(() {
      setState(() {
        _currentScrollOffset = _dayScrollController.offset;
      });
    });

    _spinController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _spinAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _spinController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _spinController.dispose();
// Don't forget to dispose in your dispose() method:
    _dayScrollController.dispose();
    super.dispose();
  }

  void spinWheel() {
    if (isSpinning || spinsAvailable <= 0) return;

    setState(() {
      isSpinning = true;
      showResult = false;
    });

    final randomRotations = 5 + math.Random().nextDouble() * 3;
    final finalPosition = math.Random().nextDouble();

    _spinAnimation = Tween<double>(
      begin: 0,
      end: randomRotations + finalPosition,
    ).animate(CurvedAnimation(
      parent: _spinController,
      curve: Curves.easeOut,
    ));

    _spinController.forward(from: 0).then((_) {
      final segmentAngle = 2 * math.pi / segments.length;
      final finalAngle = (randomRotations + finalPosition) * 2 * math.pi;
      final normalizedAngle = finalAngle % (2 * math.pi);
      final segmentIndex =
          ((2 * math.pi - normalizedAngle) / segmentAngle).floor() %
              segments.length;

      setState(() {
        selectedReward = segments[segmentIndex].label;
        spinsAvailable--;
        isSpinning = false;
        showResult = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromRGBO(28, 18, 31, 1),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color.fromRGBO(52, 49, 17, 1), width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header

              // Daily Spin Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daily Spin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.baseWhite.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Spin Available: ',
                            style: AppTextStyles.medium(
                              size: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.baseWhite.withOpacity(0.7),
                            ),
                          ),
                          TextSpan(
                            text: '02',
                            style: AppTextStyles.medium(
                              size: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Spinning Wheel
              SizedBox(
                height: 280,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        child: Image.asset(
                      'assets/images/bg/wheel_board.png',
                    )),

                    // Spinning wheel - on top of the background
                    AnimatedBuilder(
                      animation: _spinAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _spinAnimation.value * 2 * math.pi,
                          child: CustomPaint(
                            size: const Size(240, 240),
                            painter: WheelPainter(segments),
                          ),
                        );
                      },
                    ),

                    // Center button - on top of everything
                    GestureDetector(
                      onTap: spinWheel,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1C1C2E),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.3,
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFFD700),
                              width: 0.1,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Spin',
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Pointer triangle at top - on top of everything
                    Positioned(
                        top: -5,
                        child: Image.asset(
                          'assets/icons/spin_arrow.png',
                          height: 40.h,
                          width: 36.w,
                        )),
                  ],
                ),
              ),

              const SizedBox(
                  height:
                      20), // Add this as a class member in your DailySpinDialogState:

// Replace your existing ListView.builder with this:
              SizedBox(
                height: 120.h,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    final screenCenter = screenWidth / 2;
                    final itemWidth = 128.w; // 120.w card width + 8.w padding

                    return ListView.builder(
                      controller: _dayScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        // Calculate the center position of this item on screen
                        final itemStartPosition =
                            (index * itemWidth) - _currentScrollOffset;
                        final itemCenterPosition =
                            itemStartPosition + (itemWidth / 2);

                        // Calculate distance from screen center
                        final distanceFromScreenCenter =
                            (itemCenterPosition - screenCenter).abs();

                        // Calculate fade effect based on distance from screen center
                        final maxDistance = screenWidth / 2;
                        final normalizedDistance =
                            (distanceFromScreenCenter / maxDistance)
                                .clamp(0.0, 1.0);

                        // Calculate opacity (screen center = 1.0, edges fade to 0.3)
                        final opacity =
                            (1.0 - (normalizedDistance * 0.7)).clamp(0.3, 1.0);

                        // Calculate scale (screen center = 1.0, edges scale to 0.8)
                        final scale =
                            (1.0 - (normalizedDistance * 0.2)).clamp(0.8, 1.0);

                        return Transform.scale(
                          scale: scale,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 150),
                            opacity: opacity,
                            child: Container(
                              // Add subtle shadow for items near center
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: opacity > 0.8
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: index == 6 ? 0 : 8.w,
                                ),
                                child: _buildDayCard(
                                  'Day ${index + 1}',
                                  '${index == 1 ? 2 : 1}',
                                  index < 2,
                                  index == 1,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayCard(
      String day, String spinCount, bool claimed, bool current) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: const Color.fromRGBO(253, 235, 86, 1), width: 0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(day,
                        style: AppTextStyles.small(
                          size: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.baseWhite.withOpacity(0.5),
                        )),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    spinCount,
                    style: AppTextStyles.largeBold(
                      color: AppColors.baseWhite.withOpacity(0.9),
                      size: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  SolidButton(
                      width: 100.w,
                      height: 36.h,
                      onPressed: () {},
                      label: 'Claim',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      buttonColor: const Color.fromRGBO(253, 235, 86, 1))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WheelSegment {
  final String label;
  final Color color;

  WheelSegment(this.label, this.color);
}

class WheelPainter extends CustomPainter {
  final List<WheelSegment> segments;

  WheelPainter(this.segments);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.25; // Inner circle radius
    final segmentAngle = 2 * math.pi / segments.length;
    const spacing =
        0.02; // Reduced spacing between segments for even distribution

    for (int i = 0; i < segments.length; i++) {
      final startAngle = i * segmentAngle - math.pi / 2 + spacing / 2;
      final endAngle = startAngle + segmentAngle - spacing;

      // Create gradient paint from light center to darker edges
      final baseColor = segments[i].color;
      final lightColor = Color.lerp(baseColor, Colors.white, 0.4)!;
      final darkColor = Color.lerp(baseColor, Colors.black, 0.6)!;

      final gradientPaint = Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [lightColor, baseColor, darkColor],
          stops: const [0.0, 0.6, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: outerRadius));

      // Create rounded rectangle path for segment with curved ends
      final path = _createRoundedSegmentPath(
        center,
        innerRadius,
        outerRadius,
        startAngle,
        endAngle,
      );

      // Draw segment with gradient
      canvas.drawPath(path, gradientPaint);

      // Draw subtle border
      final borderPaint = Paint()
        ..color = Colors.black.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      canvas.drawPath(path, borderPaint);

      // Draw horizontal text in the middle of the segment
      final textAngle = startAngle + (endAngle - startAngle) / 2;

      _drawHorizontalText(
        canvas,
        segments[i].label,
        center,
        textAngle,
        innerRadius,
        outerRadius,
      );
    }
  }

  Path _createRoundedSegmentPath(
    Offset center,
    double innerRadius,
    double outerRadius,
    double startAngle,
    double endAngle,
  ) {
    final path = Path();

    // Calculate the key points
    final innerStart = Offset(
      center.dx + math.cos(startAngle) * innerRadius,
      center.dy + math.sin(startAngle) * innerRadius,
    );
    final outerEnd = Offset(
      center.dx + math.cos(endAngle) * outerRadius,
      center.dy + math.sin(endAngle) * outerRadius,
    );

    // Start the path from inner start
    path.moveTo(innerStart.dx, innerStart.dy);

    // Draw inner arc
    path.arcTo(
      Rect.fromCircle(center: center, radius: innerRadius),
      startAngle,
      endAngle - startAngle,
      false,
    );

    // Draw straight line to outer end
    path.lineTo(outerEnd.dx, outerEnd.dy);

    // Draw outer arc (in reverse direction)
    path.arcTo(
      Rect.fromCircle(center: center, radius: outerRadius),
      endAngle,
      -(endAngle - startAngle),
      false,
    );

    // Draw straight line back to inner start
    path.lineTo(innerStart.dx, innerStart.dy);

    path.close();
    return path;
  }

  void _drawHorizontalText(
    Canvas canvas,
    String text,
    Offset center,
    double angle,
    double innerRadius,
    double outerRadius,
  ) {
    // Determine text color based on segment text
    final textColor = text == 'Bad Luck' ? Colors.black : Colors.white;

    // Create text painter first to get dimensions
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: GoogleFonts.lexend(
          textStyle: TextStyle(
            color: textColor,
            fontSize: 15.5.sp, // Reduced font size to fit better
            fontWeight: FontWeight.w800,
            shadows: text == 'Bad Luck'
                ? null
                : [
                    const Shadow(
                      color: Color.fromRGBO(74, 13, 13, 0.9),
                      offset: Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
          ),
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Calculate available space for text
    final availableWidth =
        outerRadius - innerRadius - 20; // 20px padding from edges
    final textWidth = textPainter.width;

    // If text is too wide, try to fit it by reducing font size
    if (textWidth > availableWidth) {
      final newFontSize =
          (15.5.sp * availableWidth / textWidth).clamp(8.sp, 15.5.sp);

      final adjustedTextPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: GoogleFonts.lexend(
            textStyle: TextStyle(
              color: textColor,
              fontSize: newFontSize,
              fontWeight: FontWeight.w800,
              shadows: text == 'Bad Luck'
                  ? null
                  : [
                      const Shadow(
                        color: Color.fromRGBO(74, 13, 13, 0.9),
                        offset: Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
            ),
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      adjustedTextPainter.layout();

      // Position text with proper spacing from outer edge
      final startRadius = outerRadius - 10 - (adjustedTextPainter.width / 2);

      final startX = center.dx + math.cos(angle) * startRadius;
      final startY = center.dy + math.sin(angle) * startRadius;

      canvas.save();
      canvas.translate(startX, startY);

      // Rotate text to align from outer edge towards center
      canvas.rotate(angle + math.pi);

      adjustedTextPainter.paint(
        canvas,
        Offset(-adjustedTextPainter.width / 2, -adjustedTextPainter.height / 2),
      );

      canvas.restore();
    } else {
      // Text fits normally, position it with proper spacing
      final startRadius = outerRadius - 10 - (textWidth / 2);

      final startX = center.dx + math.cos(angle) * startRadius;
      final startY = center.dy + math.sin(angle) * startRadius;

      canvas.save();
      canvas.translate(startX, startY);

      // Rotate text to align from outer edge towards center
      canvas.rotate(angle + math.pi);

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
