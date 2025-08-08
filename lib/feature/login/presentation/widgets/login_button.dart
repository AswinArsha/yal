import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final IconData? trailingIcon; // Optional trailing icon
  final double iconSize;
  final Color? iconColor;
  final IconData? prefixIcon;
  final Color? borderColor;
  const PrimaryButton({
    super.key,
    required this.label,
    this.borderColor = Colors.transparent,
    this.prefixIcon,
    required this.onPressed,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w500,
    this.backgroundColor = const Color(0xFF241A26),
    this.textColor = AppColors.buttonText,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.gradient,
    this.trailingIcon,
    this.iconSize = 20,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          gradient: gradient,
          color: gradient == null ? backgroundColor : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null) ...[
                Icon(
                  prefixIcon,
                  size: 20,
                  color: iconColor,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: AppTextStyles.medium(
                  size: fontSize,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  trailingIcon,
                  size: iconSize,
                  color: iconColor ?? textColor,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
