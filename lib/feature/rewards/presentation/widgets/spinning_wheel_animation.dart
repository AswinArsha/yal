import 'package:flutter/material.dart';

// Animation for Spinning Game Card
class SpinningWheelAnimation extends StatefulWidget {
  const SpinningWheelAnimation({super.key});

  @override
  State<SpinningWheelAnimation> createState() => _SpinningWheelAnimationState();
}

class _SpinningWheelAnimationState extends State<SpinningWheelAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _spinController;
  late Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    _spinAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _spinController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _spinAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              child: Transform.rotate(
                angle: _spinAnimation.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg/full_wheel.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
