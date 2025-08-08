import 'package:flutter/material.dart';

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.10;
    size = size.clamp(30.0, 40.0);

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        iconSize: size * 0.5,
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
