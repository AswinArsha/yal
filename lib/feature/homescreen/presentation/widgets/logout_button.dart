import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class LogoutButton extends StatelessWidget {
  final IconData? prefixIcon;
  final Color luminousColor;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final double iconSize;
  final double radius;
  final EdgeInsetsGeometry padding;

  //final Color labelColor;
  // final Color? IconColor;
  const LogoutButton({
    this.radius = 12,
    this.iconSize = 12,
    this.fontWeight = FontWeight.w400,
    super.key,
    this.fontSize = 10,
    this.prefixIcon,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    //   this.IconColor,
    required this.luminousColor,
    required this.label,
    //  required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: luminousColor.withValues(alpha: 0.2)),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            const SizedBox(width: 12),
            if (prefixIcon != null) ...[
              Icon(
                prefixIcon,
                size: iconSize,
                color: luminousColor,
              ),
              const SizedBox(width: 12),
            ],
            Text(label,
                style: AppTextStyles.verySmall(
                    size: fontSize,
                    fontWeight: fontWeight,
                    color: luminousColor)),
          ],
        ),
      ),
    );
  }
}
