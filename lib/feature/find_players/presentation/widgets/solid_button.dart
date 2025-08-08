import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';

class SolidButton extends StatelessWidget {
  final String label;
  final Color buttonColor;
  final String? prefixImage; // Made optional
  final void Function()? onPressed;
  final double fontSize;
  final double borderRadius;
  final double height;
  final double width;
  final FontWeight fontWeight;
  const SolidButton({
    super.key,
    this.height = 30,
    this.width = 150,
    this.fontSize = 10,
    this.fontWeight = FontWeight.w500,
    required this.onPressed,
    required this.label,
    required this.buttonColor,
    this.borderRadius = 8,
    this.prefixImage, // Optional constructor parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixImage != null) ...[
              Image.asset(
                prefixImage!,
                height: 14.h,
                width: 14.w,
              ),
              SizedBox(width: 6.w), // space between icon and label
            ],
            Text(
              label,
              style: AppTextStyles.small(
                fontWeight: fontWeight,
                size: fontSize,
                color: const Color.fromRGBO(44, 23, 50, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
