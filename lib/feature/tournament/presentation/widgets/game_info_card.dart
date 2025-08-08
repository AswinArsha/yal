import 'package:flutter/material.dart';

class GameInfoCard extends StatelessWidget {
  final String gameName;
  final String deviceType;
  final String imagePath;

  const GameInfoCard({
    Key? key,
    required this.gameName,
    required this.deviceType,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              // Game Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // Game Name and Device Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Game Name',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    gameName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              // Game Image
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Icon(
                    Icons.phone_android_rounded,
                    color: Colors.white,
                    size: 50,
                  )),
              const SizedBox(width: 16),

              // Game Name and Device Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Mobile",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
