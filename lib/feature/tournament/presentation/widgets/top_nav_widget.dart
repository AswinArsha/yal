import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/bottom_navigation.dart';

class TopNavWidget extends StatelessWidget {
  const TopNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(238, 176, 254, 1),
            Color.fromRGBO(99, 47, 113, 1)
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
            decoration: const BoxDecoration(
              color: AppColors.baseWhite,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: Text(
              'Switch to play and engage',
              style: AppTextStyles.mediumBold(
                color: const Color.fromRGBO(71, 49, 77, 1),
                size: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: true,
            onChanged: (val) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                  return const BottomNavigationScreen();
                }),
              );
            },
            activeColor: Colors.white,
            activeTrackColor: const Color.fromRGBO(142, 201, 237, 1),
          ),
        ],
      ),
    );
  }
}