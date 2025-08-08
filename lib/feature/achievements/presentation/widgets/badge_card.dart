import 'package:flutter/material.dart';

class BadgeCard extends StatelessWidget {
  final String image;
  final String status;
  final String title;
  final String subtitle;
  final bool isClaimed;
  final String? buttonLabel;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final IconData? icon;
  final VoidCallback? onPressed;

  const BadgeCard({
    super.key,
    required this.image,
    required this.status,
    required this.title,
    required this.subtitle,
    required this.isClaimed,
    this.buttonLabel,
    this.buttonColor,
    this.buttonTextColor,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF241927),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFF3D3226),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF1C131F),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                // Background glow
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF6D079E),
                        Colors.transparent,
                      ],
                      radius: 1,
                      center: Alignment.center,
                    ),
                  ),
                ),
                // Image
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: isClaimed
                        ? const Color(0xFF1FD031)
                        : const Color(0xFFFDEB56),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8E898F),
                    ),
                  ),
                ],
                if (buttonLabel != null) ...[
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: onPressed,
                    icon: Icon(icon),
                    label: Text(
                      buttonLabel!,
                      style: TextStyle(
                        fontSize: 14,
                        color: buttonTextColor ?? const Color(0xFF1D2A33),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor ?? const Color(0xFFEAD950),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
