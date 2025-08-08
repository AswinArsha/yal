import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'dart:async';

import 'package:yalgamers/core/theme/app_colors.dart';

class TournamentComingSoonScreen extends StatefulWidget {
  const TournamentComingSoonScreen({super.key});

  @override
  State<TournamentComingSoonScreen> createState() =>
      _TournamentComingSoonScreenState();
}

class _TournamentComingSoonScreenState extends State<TournamentComingSoonScreen>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _rotateController;
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late AnimationController _particleController;

  late Animation<double> _floatAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _particleAnimation;

  List<FloatingParticle> particles = [];
  Timer? _particleTimer;

  @override
  void initState() {
    super.initState();

    // Smooth floating animation
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _floatAnimation = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));

    // Gentle rotation
    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_rotateController);

    // Pulse for glow effects
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Wave animation for background
    _waveController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _waveAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_waveController);

    // Particle system
    _particleController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    _particleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_particleController);

    // Start animations
    _floatController.repeat(reverse: true);
    _rotateController.repeat();
    _pulseController.repeat(reverse: true);
    _waveController.repeat();
    _particleController.repeat();

    // Initialize particles
    _initializeParticles();

    // Update particles
    _particleTimer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      _updateParticles();
    });
  }

  void _initializeParticles() {
    particles.clear();
    for (int i = 0; i < 25; i++) {
      particles.add(FloatingParticle.random());
    }
  }

  void _updateParticles() {
    setState(() {
      for (var particle in particles) {
        particle.update();
      }
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    _particleController.dispose();
    _particleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              Color(0xFF16213e),
              Color(0xFF0f3460),
              Color(0xFF533483),
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated wave background
            AnimatedBuilder(
              animation: _waveAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(_waveAnimation.value),
                  size: Size.infinite,
                );
              },
            ),

            // Floating particles
            AnimatedBuilder(
              animation: _particleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(particles, _particleAnimation.value),
                  size: Size.infinite,
                );
              },
            ),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Header section
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF533483).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFe94560)
                                      .withOpacity(_pulseAnimation.value),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFe94560).withOpacity(
                                        0.3 * _pulseAnimation.value),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child:  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.whatshot,
                                    color: Color(0xFFf39c12),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'EPIC MODE',
                                    style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  )),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white60,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main tournament section
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Floating tournament icon
                        AnimatedBuilder(
                          animation: Listenable.merge([
                            _floatAnimation,
                            _rotateAnimation,
                            _pulseAnimation
                          ]),
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _floatAnimation.value),
                              child: Transform.rotate(
                                angle: _rotateAnimation.value * 0.1,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        const Color(0xFFf39c12)
                                            .withOpacity(0.8),
                                        const Color(0xFFe94560)
                                            .withOpacity(0.9),
                                        const Color(0xFF533483)
                                            .withOpacity(0.7),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFe94560)
                                            .withOpacity(
                                                0.4 * _pulseAnimation.value),
                                        blurRadius: 30,
                                        spreadRadius: 10,
                                      ),
                                      BoxShadow(
                                        color: const Color(0xFFf39c12)
                                            .withOpacity(
                                                0.3 * _pulseAnimation.value),
                                        blurRadius: 50,
                                        spreadRadius: 15,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.emoji_events,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // Tournament title
                        AnimatedBuilder(
                          animation: _floatAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _floatAnimation.value * 0.3),
                              child: Column(
                                children: [
                                  ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                            colors: [
                                              Color(0xFFf39c12),
                                              Color(0xFFe94560),
                                              Color(0xFFf39c12),
                                            ],
                                          ).createShader(bounds),
                                      child: Text(
                                        'TOURNAMENT',
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          letterSpacing: 4,
                                         ) ),
                                        textAlign: TextAlign.center,
                                      )),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFe94560),
                                          Color(0xFFf39c12),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child:  Text(
                                      'COMING SOON',
                                      style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 2,
                                       ) ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 30),

                        // Description
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            'Get ready for the ultimate gaming showdown!\nCompete with players worldwide.',
                            style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              height: 1.5,
                             ) ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 50),

                        // Progress section with cool design
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                   Text(
                                    'Preparation Progress',
                                    style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),),
                                  AnimatedBuilder(
                                    animation: _waveAnimation,
                                    builder: (context, child) {
                                      final progress =
                                          (75 + _waveAnimation.value * 10)
                                              .toInt();
                                      return Text(
                                        '$progress%',
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          color: Color(0xFFf39c12),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                         ) ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: AnimatedBuilder(
                                  animation: _waveAnimation,
                                  builder: (context, child) {
                                    final progress =
                                        0.75 + _waveAnimation.value * 0.1;
                                    return FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: progress,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFf39c12),
                                              Color(0xFFe94560),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFf39c12)
                                                  .withOpacity(0.5),
                                              blurRadius: 8,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Action buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: [
                              Expanded(
                                child: AnimatedBuilder(
                                  animation: _pulseAnimation,
                                  builder: (context, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                '🔥 You\'ll be notified when the tournament begins!'),
                                            backgroundColor:
                                                const Color(0xFFe94560),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              const Color(0xFFe94560)
                                                  .withOpacity(
                                                      _pulseAnimation.value),
                                              const Color(0xFFf39c12)
                                                  .withOpacity(
                                                      _pulseAnimation.value),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFe94560)
                                                  .withOpacity(0.4 *
                                                      _pulseAnimation.value),
                                              blurRadius: 20,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child:  Text(
                                          'NOTIFY ME',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1.5,
                                            )  ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                          '📖 Tournament details coming soon!'),
                                      backgroundColor: const Color(0xFF533483),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom section
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFF27ae60),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF27ae60).withOpacity(
                                        0.6 * _pulseAnimation.value),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                         Text(
                          'System Ready • All players welcome',
                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                          ),
                            )   ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FloatingParticle {
  double x, y;
  double vx, vy;
  double life;
  double maxLife;
  Color color;
  double size;

  FloatingParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.life,
    required this.maxLife,
    required this.color,
    required this.size,
  });

  factory FloatingParticle.random() {
    final random = math.Random();
    final colors = [
      const Color(0xFFf39c12),
      const Color(0xFFe94560),
      const Color(0xFF533483),
      Colors.white,
    ];

    return FloatingParticle(
      x: random.nextDouble(),
      y: random.nextDouble(),
      vx: (random.nextDouble() - 0.5) * 0.002,
      vy: (random.nextDouble() - 0.5) * 0.002,
      life: 300.0,
      maxLife: 300.0,
      color: colors[random.nextInt(colors.length)],
      size: random.nextDouble() * 3 + 1,
    );
  }

  void update() {
    x += vx;
    y += vy;
    life -= 1;

    // Wrap around edges
    if (x < 0) x = 1;
    if (x > 1) x = 0;
    if (y < 0) y = 1;
    if (y > 1) y = 0;

    if (life <= 0) {
      life = maxLife;
      final random = math.Random();
      x = random.nextDouble();
      y = random.nextDouble();
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<FloatingParticle> particles;
  final double animationValue;

  ParticlePainter(this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      if (particle.life > 0) {
        final opacity = (particle.life / particle.maxLife) * 0.4;
        final paint = Paint()
          ..color = particle.color.withOpacity(opacity)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(
          Offset(particle.x * size.width, particle.y * size.height),
          particle.size,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    final waveHeight = 30.0;
    final waveLength = size.width / 3;

    for (int i = 0; i < 3; i++) {
      path.reset();
      final yOffset = size.height * 0.3 + i * 100;

      for (double x = 0; x <= size.width; x += 2) {
        final y = yOffset +
            math.sin(
                    (x / waveLength + animationValue * 2 * math.pi + i * 0.5)) *
                waveHeight +
            math.sin((x / (waveLength * 0.7) +
                    animationValue * 3 * math.pi +
                    i * 0.3)) *
                waveHeight *
                0.5;

        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
