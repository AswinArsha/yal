import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/xp_mystery/presentation/pages/xp_mystery.dart';

class RewardsDialog extends StatelessWidget {
  const RewardsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Stack(
        clipBehavior: Clip.none, // Allows elements to extend outside dialog
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(28, 21, 30, 1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            padding: EdgeInsets.all(12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'My Rewards',
                  style: AppTextStyles.largeBold(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 14.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return XPMysteryScreen();
                        }));
                      },
                      child: buildRewardItem(
                        tileColor: const Color.fromRGBO(253, 235, 86, 0.08),
                        context,
                        title: 'XP',
                        value: '345',
                        imagePath: 'assets/icons/reward_xp.png',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () {},
                      child: buildRewardItem(
                        tileColor: const Color(0xFF25232F),
                        context,
                        title: 'Mystery Box',
                        value: '12',
                        imagePath: 'assets/icons/reward_gift.png',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Close button positioned partially outside
          Positioned(
            top: -10.h, // Positioned above the dialog
            right: -10.h, // Positioned outside to the right
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.all(3.h),
                decoration: BoxDecoration(
                  color: Colors.white
                      .withOpacity(0.25), // Match your app background
                  shape: BoxShape.circle,
                  // border: Border.all(
                  //   color: Colors.white.withOpacity(0.1),
                  //   width: 1,
                  // ),
                ),
                child: Icon(
                  Icons.close,
                  size: 14.h,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) => const RewardsDialog(),
    );
  }
}

Widget buildRewardItem(
  BuildContext context, {
  required String title,
  required String value,
  required String imagePath,
  required Color tileColor,
}) {
  return Container(
    decoration: BoxDecoration(
      color: tileColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 44.h,
            height: 44.h,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  size: 14,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppTextStyles.largeBold(
                  color: Colors.white,
                  size: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
