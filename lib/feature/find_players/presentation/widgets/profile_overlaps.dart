
import 'package:flutter/material.dart';

Widget buildOverlappingAvatars() {
  const double avatarRadius = 15;
  const double overlap = 15;

  return SizedBox(
    height: avatarRadius * 2,
    width: avatarRadius * 2 + (3 - 1) * overlap + 10,
    child: Stack(
      children: List.generate(3, (index) {
        return Positioned(
          left: index * overlap,
          child: Container(
            width: avatarRadius * 2,
            height: avatarRadius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const CircleAvatar(
              radius: avatarRadius,
              backgroundImage: AssetImage('assets/user.png'),
            ),
          ),
        );
      }),
    ),
  );
}
