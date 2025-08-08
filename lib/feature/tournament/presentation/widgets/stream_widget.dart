import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class StreamWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? playButtonColor;
  final VoidCallback? onPlayPressed;
  final bool isLive;

  const StreamWidget({
    Key? key,
    this.title,
    this.subtitle,
    this.backgroundColor,
    this.textColor,
    this.playButtonColor,
    this.onPlayPressed,
    this.isLive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stream',
            style: AppTextStyles.small(
              color: textColor ?? Colors.white,
              size: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Stream Player Container
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: backgroundColor ?? const Color(0xFF100613),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Play Button
                      GestureDetector(
                        onTap: onPlayPressed,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: playButtonColor ?? const Color(0xFFFF4081),
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (playButtonColor ?? const Color(0xFFFF4081))
                                        .withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Stream Status Text
                      Text(
                        title ?? 'Stream link will be published',
                        style: AppTextStyles.small(
                          color: textColor ?? Colors.white,
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        subtitle ?? 'while it\'s streaming.',
                        style: AppTextStyles.small(
                          color: (textColor ?? Colors.white),
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Live indicator (only shown when isLive is true)
                if (isLive)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'LIVE',
                            style: AppTextStyles.small(
                              color: Colors.white,
                              size: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage for your TournamentScreen _buildTabContent() method:
/*
case 5: // Stream
  return StreamWidget(
    title: 'Stream link will be published',
    subtitle: 'while it\'s streaming.',
    isLive: true, // Set to true when streaming is live
    onPlayPressed: () {
      // Handle play button press
      print('Play button pressed');
      // You can navigate to video player or start stream here
    },
  );
*/
