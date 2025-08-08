// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// import 'dart:async';

// class ComingSoonScreen extends StatefulWidget {
//   const ComingSoonScreen({super.key});

//   @override
//   State<ComingSoonScreen> createState() => _ComingSoonScreenState();
// }

// class _ComingSoonScreenState extends State<ComingSoonScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _floatingController;
//   late AnimationController _pulseController;
//   late AnimationController _particleController;
//   late AnimationController _textController;
//   late AnimationController _glowController;

//   late Animation<double> _floatingAnimation;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _particleAnimation;
//   late Animation<double> _textAnimation;
//   late Animation<double> _glowAnimation;

//   List<Particle> particles = [];
//   Timer? _particleTimer;

//   @override
//   void initState() {
//     super.initState();

//     // Floating animation
//     _floatingController = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     );
//     _floatingAnimation = Tween<double>(
//       begin: -20,
//       end: 20,
//     ).animate(CurvedAnimation(
//       parent: _floatingController,
//       curve: Curves.easeInOut,
//     ));

//     // Pulse animation
//     _pulseController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//     _pulseAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.2,
//     ).animate(CurvedAnimation(
//       parent: _pulseController,
//       curve: Curves.easeInOut,
//     ));

//     // Particle animation
//     _particleController = AnimationController(
//       duration: const Duration(seconds: 8),
//       vsync: this,
//     );
//     _particleAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(_particleController);

//     // Text animation
//     _textController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//     _textAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: Curves.elasticOut,
//     ));

//     // Glow animation
//     _glowController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//     _glowAnimation = Tween<double>(
//       begin: 0.3,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _glowController,
//       curve: Curves.easeInOut,
//     ));

//     // Start animations
//     _floatingController.repeat(reverse: true);
//     _pulseController.repeat(reverse: true);
//     _particleController.repeat();
//     _textController.forward();
//     _glowController.repeat(reverse: true);

//     // Initialize particles
//     _initializeParticles();

//     // Start particle generation
//     _particleTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       _addRandomParticle();
//     });
//   }

//   void _initializeParticles() {
//     particles.clear();
//     for (int i = 0; i < 50; i++) {
//       particles.add(Particle.random());
//     }
//   }

//   void _addRandomParticle() {
//     if (particles.length < 100) {
//       setState(() {
//         particles.add(Particle.random());
//       });
//     }

//     // Remove old particles
//     particles.removeWhere((particle) => particle.life <= 0);
//   }

//   @override
//   void dispose() {
//     _floatingController.dispose();
//     _pulseController.dispose();
//     _particleController.dispose();
//     _textController.dispose();
//     _glowController.dispose();
//     _particleTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF0F0C29),
//               Color(0xFF24243e),
//               Color(0xFF302B63),
//               Color(0xFF0F0C29),
//             ],
//             stops: [0.0, 0.25, 0.75, 1.0],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Animated particles background
//             AnimatedBuilder(
//               animation: _particleAnimation,
//               builder: (context, child) {
//                 return CustomPaint(
//                   painter: ParticlePainter(particles, _particleAnimation.value),
//                   size: Size.infinite,
//                 );
//               },
//             ),

//             // Floating geometric shapes
//             AnimatedBuilder(
//               animation: _floatingAnimation,
//               builder: (context, child) {
//                 return Positioned(
//                   top: 100 + _floatingAnimation.value,
//                   right: 50,
//                   child: Transform.rotate(
//                     angle: _particleAnimation.value * 2 * math.pi,
//                     child: Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF00D4FF), Color(0xFF5B00FF)],
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: const Color(0xFF00D4FF).withOpacity(0.5),
//                             blurRadius: 20,
//                             spreadRadius: 5,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),

//             AnimatedBuilder(
//               animation: _floatingAnimation,
//               builder: (context, child) {
//                 return Positioned(
//                   bottom: 150 - _floatingAnimation.value,
//                   left: 30,
//                   child: Transform.rotate(
//                     angle: -_particleAnimation.value * 2 * math.pi,
//                     child: Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: const Color(0xFFFF6B6B).withOpacity(0.6),
//                             blurRadius: 25,
//                             spreadRadius: 8,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),

//             // Main content
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Animated logo/icon
//                   AnimatedBuilder(
//                     animation:
//                         Listenable.merge([_pulseAnimation, _glowAnimation]),
//                     builder: (context, child) {
//                       return Transform.scale(
//                         scale: _pulseAnimation.value,
//                         child: Container(
//                           width: 120,
//                           height: 120,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: const LinearGradient(
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                               colors: [
//                                 Color(0xFF667eea),
//                                 Color(0xFF764ba2),
//                                 Color(0xFFf093fb),
//                                 Color(0xFFf5576c),
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: const Color(0xFF667eea)
//                                     .withOpacity(_glowAnimation.value * 0.8),
//                                 blurRadius: 30 * _glowAnimation.value,
//                                 spreadRadius: 10 * _glowAnimation.value,
//                               ),
//                             ],
//                           ),
//                           child: const Icon(
//                             Icons.rocket_launch,
//                             color: Colors.white,
//                             size: 60,
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 40),

//                   // Animated "Coming Soon" text
//                   AnimatedBuilder(
//                     animation: _textAnimation,
//                     builder: (context, child) {
//                       return Transform.scale(
//                         scale: _textAnimation.value,
//                         child: Opacity(
//                           opacity: _textAnimation.value,
//                           child: ShaderMask(
//                             shaderCallback: (bounds) => const LinearGradient(
//                               colors: [
//                                 Color(0xFF667eea),
//                                 Color(0xFFf093fb),
//                                 Color(0xFFf5576c),
//                                 Color(0xFFffd89b),
//                               ],
//                             ).createShader(bounds),
//                             child: const Text(
//                               'COMING SOON',
//                               style: TextStyle(
//                                 fontSize: 48,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 4,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 20),

//                   // Subtitle with typewriter effect
//                   AnimatedBuilder(
//                     animation: _textAnimation,
//                     builder: (context, child) {
//                       return Opacity(
//                         opacity: _textAnimation.value,
//                         child: const Text(
//                           'Something amazing is on the way...',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white70,
//                             letterSpacing: 1.5,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 60),

//                   // Progress indicator
//                   AnimatedBuilder(
//                     animation: _textAnimation,
//                     builder: (context, child) {
//                       return Transform.translate(
//                         offset: Offset(0, 50 * (1 - _textAnimation.value)),
//                         child: Opacity(
//                           opacity: _textAnimation.value,
//                           child: Column(
//                             children: [
//                               const Text(
//                                 'Loading Progress',
//                                 style: TextStyle(
//                                   color: Colors.white60,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//                               Container(
//                                 width: 200,
//                                 height: 6,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(3),
//                                 ),
//                                 child: AnimatedBuilder(
//                                   animation: _particleAnimation,
//                                   builder: (context, child) {
//                                     return Container(
//                                       width: 200 *
//                                           (_particleAnimation.value * 0.8 +
//                                               0.2),
//                                       height: 6,
//                                       decoration: BoxDecoration(
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color(0xFF667eea),
//                                             Color(0xFFf093fb),
//                                             Color(0xFFffd89b),
//                                           ],
//                                         ),
//                                         borderRadius: BorderRadius.circular(3),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: const Color(0xFF667eea)
//                                                 .withOpacity(0.5),
//                                             blurRadius: 10,
//                                             spreadRadius: 2,
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               AnimatedBuilder(
//                                 animation: _particleAnimation,
//                                 builder: (context, child) {
//                                   final progress =
//                                       (_particleAnimation.value * 80 + 20)
//                                           .toInt();
//                                   return Text(
//                                     '$progress%',
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 80),

//                   // Interactive button
//                   AnimatedBuilder(
//                     animation: _textAnimation,
//                     builder: (context, child) {
//                       return Transform.scale(
//                         scale: _textAnimation.value,
//                         child: Opacity(
//                           opacity: _textAnimation.value,
//                           child: GestureDetector(
//                             onTap: () {
//                               // Add haptic feedback or navigation
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                       'You\'ll be notified when we launch!'),
//                                   backgroundColor: Color(0xFF667eea),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 40,
//                                 vertical: 15,
//                               ),
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color(0xFF667eea),
//                                     Color(0xFF764ba2),
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(30),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: const Color(0xFF667eea)
//                                         .withOpacity(0.4),
//                                     blurRadius: 15,
//                                     spreadRadius: 3,
//                                   ),
//                                 ],
//                               ),
//                               child: const Text(
//                                 'Notify Me',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   letterSpacing: 1,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // Interactive sparkles on tap
//             GestureDetector(
//               onTapDown: (details) {
//                 _createTapSparkles(details.localPosition);
//               },
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: Colors.transparent,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _createTapSparkles(Offset position) {
//     for (int i = 0; i < 10; i++) {
//       particles.add(Particle.sparkle(position));
//     }
//     setState(() {});
//   }
// }

// class Particle {
//   double x, y;
//   double vx, vy;
//   double life;
//   double maxLife;
//   Color color;
//   double size;
//   bool isSparkle;

//   Particle({
//     required this.x,
//     required this.y,
//     required this.vx,
//     required this.vy,
//     required this.life,
//     required this.maxLife,
//     required this.color,
//     required this.size,
//     this.isSparkle = false,
//   });

//   factory Particle.random() {
//     final random = math.Random();
//     return Particle(
//       x: random.nextDouble() * 400,
//       y: random.nextDouble() * 800,
//       vx: (random.nextDouble() - 0.5) * 2,
//       vy: (random.nextDouble() - 0.5) * 2,
//       life: 100.0,
//       maxLife: 100.0,
//       color: Color.lerp(
//         const Color(0xFF667eea),
//         const Color(0xFFf093fb),
//         random.nextDouble(),
//       )!,
//       size: random.nextDouble() * 3 + 1,
//     );
//   }

//   factory Particle.sparkle(Offset position) {
//     final random = math.Random();
//     return Particle(
//       x: position.dx,
//       y: position.dy,
//       vx: (random.nextDouble() - 0.5) * 8,
//       vy: (random.nextDouble() - 0.5) * 8,
//       life: 60.0,
//       maxLife: 60.0,
//       color: const Color(0xFFffd89b),
//       size: random.nextDouble() * 4 + 2,
//       isSparkle: true,
//     );
//   }

//   void update() {
//     x += vx;
//     y += vy;
//     life -= 1;

//     if (isSparkle) {
//       vx *= 0.95;
//       vy *= 0.95;
//     }
//   }
// }

// class ParticlePainter extends CustomPainter {
//   final List<Particle> particles;
//   final double animationValue;

//   ParticlePainter(this.particles, this.animationValue);

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (final particle in particles) {
//       particle.update();

//       if (particle.life > 0) {
//         final opacity = particle.life / particle.maxLife;
//         final paint = Paint()
//           ..color = particle.color.withOpacity(opacity)
//           ..style = PaintingStyle.fill;

//         if (particle.isSparkle) {
//           // Draw sparkle as a star
//           _drawStar(
//               canvas, Offset(particle.x, particle.y), particle.size, paint);
//         } else {
//           // Draw regular particle as circle
//           canvas.drawCircle(
//             Offset(particle.x, particle.y),
//             particle.size,
//             paint,
//           );
//         }
//       }
//     }
//   }

//   void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
//     final path = Path();
//     final outerRadius = size;
//     final innerRadius = size * 0.5;

//     for (int i = 0; i < 10; i++) {
//       final angle = (i * math.pi) / 5;
//       final radius = i.isEven ? outerRadius : innerRadius;
//       final x = center.dx + radius * math.cos(angle);
//       final y = center.dy + radius * math.sin(angle);

//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }
//     path.close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
