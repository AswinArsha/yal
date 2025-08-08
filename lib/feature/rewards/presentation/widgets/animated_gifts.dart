import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingGiftStack extends StatefulWidget {
  const FloatingGiftStack({super.key});

  @override
  State<FloatingGiftStack> createState() => _FloatingGiftStackState();
}

class _FloatingGiftStackState extends State<FloatingGiftStack>
    with TickerProviderStateMixin {
  late final List<AnimationController> _slideControllers;
  late final List<AnimationController> _floatControllers;
  late final List<Animation<double>> _slideAnimations;
  late final List<Animation<double>> _floatAnimations;
  late final List<Animation<double>> _scaleAnimations;

  final List<_GiftData> gifts = [
    // Bottom row - 2 gifts (raised up)
    _GiftData('assets/images/bg/gift1.png', 
        finalX: 20, finalY: 40, size: 110, delay: 0),
    _GiftData('assets/images/bg/gift2.png', 
        finalX: 90, finalY: 40, size: 110, delay: 500),
    // Top gift - pyramid peak (raised up)
    _GiftData('assets/images/bg/gift3.png', 
        finalX: 55, finalY: -10, size: 115, delay: 1000),
  ];

  @override
  void initState() {
    super.initState();
    
    // Slide-in controllers (run once)
    _slideControllers = List.generate(gifts.length, (i) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      );
    });

    // Float controllers (loop continuously)
    _floatControllers = List.generate(gifts.length, (i) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + (i * 300)),
      );
    });

    // Slide in from left animation (runs once per gift)
    _slideAnimations = _slideControllers.asMap().entries.map((entry) {
      int i = entry.key;
      AnimationController controller = entry.value;
      final gift = gifts[i];
      
      return Tween<double>(
        begin: -120.0,
        end: gift.finalX,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ));
    }).toList();

    // Scale bounce animation (runs once per gift)
    _scaleAnimations = _slideControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ));
    }).toList();

    // Gentle floating animation (loops continuously)
    _floatAnimations = _floatControllers.asMap().entries.map((entry) {
      int i = entry.key;
      AnimationController controller = entry.value;
      
      return Tween<double>(
        begin: 0,
        end: 12 + (i * 3), // Different float ranges for variety
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutSine,
      ));
    }).toList();

    // Start animations with delays
    _startAnimations();
  }

  void _startAnimations() async {
    for (int i = 0; i < gifts.length; i++) {
      // Wait for delay, then start slide-in
      await Future.delayed(Duration(milliseconds: gifts[i].delay));
      
      if (mounted) {
        _slideControllers[i].forward();
        
        // Start floating after slide-in completes
        _slideControllers[i].addStatusListener((status) {
          if (status == AnimationStatus.completed && mounted) {
            _floatControllers[i].repeat(reverse: true);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _slideControllers) {
      controller.dispose();
    }
    for (final controller in _floatControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(gifts.length, (i) {
          final gift = gifts[i];
          return AnimatedBuilder(
            animation: Listenable.merge([
              _slideControllers[i],
              _floatControllers[i],
            ]),
            builder: (context, child) {
              return Positioned(
                left: _slideAnimations[i].value.w,
                top: (gift.finalY - _floatAnimations[i].value).h,
                child: Transform.scale(
                  scale: _scaleAnimations[i].value,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      gift.asset,
                      width: gift.size.w,
                      height: gift.size.h,
                      errorBuilder: (context, error, stackTrace) {
                        final colors = [
                          [const Color(0xFFFF6B9D), const Color(0xFFFF8E9B)],
                          [const Color(0xFF4ECDC4), const Color(0xFF44A08D)],
                          [const Color(0xFFFFD93D), const Color(0xFFFF6B35)],
                        ];
                        return Container(
                          width: gift.size.w,
                          height: gift.size.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: colors[i % colors.length],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.card_giftcard_rounded,
                            color: Colors.white,
                            size: (gift.size * 0.5).w,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class _GiftData {
  final String asset;
  final double finalX;
  final double finalY;
  final double size;
  final int delay;

  _GiftData(
    this.asset, {
    required this.finalX,
    required this.finalY,
    required this.size,
    required this.delay,
  });
}