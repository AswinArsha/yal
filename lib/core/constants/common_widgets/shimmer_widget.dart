import 'package:flutter/material.dart';

class ProjectCardShimmer extends StatefulWidget {
  final int itemCount;

  const ProjectCardShimmer({
    super.key,
    this.itemCount = 3,
  });

  @override
  State<ProjectCardShimmer> createState() => _ProjectCardShimmerState();
}

class _ProjectCardShimmerState extends State<ProjectCardShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildShimmerBox(double width, double height,
      {BorderRadius? borderRadius}) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(4),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
              colors: const [
                Color.fromRGBO(40, 25, 43, 1),
                Color.fromRGBO(65, 50, 68, 1),
                Color.fromRGBO(40, 25, 43, 1),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerCard() {
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: const Color.fromRGBO(28, 18, 31, 1),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          _buildShimmerBox(
            double.infinity,
            screenHeight * 0.23,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerBox(double.infinity * 0.8, 18),
                const SizedBox(height: 8),
                _buildShimmerBox(double.infinity, 14),
                const SizedBox(height: 4),
                _buildShimmerBox(double.infinity * 0.6, 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }
}

// Simple usage function
Widget customShimmer() {
  return const ProjectCardShimmer(itemCount: 3);
}
