import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class InputBar extends StatelessWidget {
  final VoidCallback onTap;

  const InputBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset('assets/icons/gallery.png', height: 45.h),
          const SizedBox(width: 10),
          Image.asset('assets/icons/smile.png', height: 45.h),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onTap: onTap,
              style: AppTextStyles.small(
                color: Colors.white,
                size: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: "Type here...",
                filled: true,
                hintStyle: AppTextStyles.small(
                  color: AppColors.baseWhite.withOpacity(0.6),
                  size: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                fillColor: AppColors.baseWhite.withOpacity(0.05),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.36),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
