import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class PlayersWidget extends StatelessWidget {
  final String? message;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;
  final TextStyle? textStyle;

  const PlayersWidget({
    Key? key,
    this.message,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.iconSize,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: const Color(0xFF100613),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: 80,
              color: Color(0xFF403842),
            ),
            const SizedBox(height: 20),
            Text(
              'No Players Joined Yet.',
              style: AppTextStyles.small(
                color: Color(0xFF706A71),
                size: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
