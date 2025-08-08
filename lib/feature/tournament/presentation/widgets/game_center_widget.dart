import 'package:flutter/material.dart';

class GameCenterWidget extends StatelessWidget {
  final String? centerName;
  final String? address;
  final List<String>? imagePaths; // Changed to list for multiple images
  final Color? backgroundColor;
  final Color? textColor;
  final Color? subtitleColor;

  const GameCenterWidget({
    Key? key,
    this.centerName,
    this.address,
    this.imagePaths, // Now accepts a list of image paths
    this.backgroundColor,
    this.textColor,
    this.subtitleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontally scrollable images
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  imagePaths?.length ?? 2, // Default to 2 if no images provided
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width *
                      0.7, // 70% of screen width
                  margin: EdgeInsets.only(
                    right: index < (imagePaths?.length ?? 2) - 1 ? 12 : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade800,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imagePaths != null && index < imagePaths!.length
                        ? Image.asset(
                            imagePaths![index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholderImage(),
                          )
                        : _buildPlaceholderImage(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Location Information
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: subtitleColor ?? Colors.grey.shade400,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      centerName ?? 'Riyadh Game Center',
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address ?? '60/63, West Road, Riyadh.',
                      style: TextStyle(
                        color: subtitleColor ?? Colors.grey.shade400,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.gamepad,
            color: Colors.grey.shade600,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            'Game Center',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Example
