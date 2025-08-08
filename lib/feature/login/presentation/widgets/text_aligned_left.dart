import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class LeftAlignedLabelText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;

  const LeftAlignedLabelText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppTextStyles.superLarge(
          size: fontSize,
          color: color ?? AppColors.textSecondary,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
