import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class BottomNavItem extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;
  final String selectedImage;
  const BottomNavItem({
    required this.image,
    required this.label,
    this.onTap,
    required this.selectedImage,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.secondary : Colors.grey;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected ? selectedImage : image,
              height: 22.h,
              width: 22.w,
            ),
            const SizedBox(height: 4),
            // Fixed height container to prevent text movement
            SizedBox(
              height: 20.h, // Increased height to accommodate full text
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.small(
                  color: color,
                  size: 10.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ).copyWith(
                  height: 1.0, // Fixed line height to prevent baseline shifts
                ),
                maxLines:
                    2, // Allow 2 lines for longer text like "Find Players"
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
