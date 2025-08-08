import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/rewards/presentation/pages/spinwheel.dart';
import 'package:yalgamers/feature/rewards/presentation/widgets/animated_gifts.dart';
import 'package:yalgamers/feature/rewards/presentation/widgets/mystery_dialog.dart';
import 'package:yalgamers/feature/rewards/presentation/widgets/reward_box.dart';
import 'package:yalgamers/feature/rewards/presentation/widgets/reward_poster_card.dart';
import 'package:yalgamers/feature/rewards/presentation/widgets/spinning_wheel_animation.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.buttonBackground,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomArrowBack(),
        ),
        title: Text(
          'Rewards',
          style: AppTextStyles.medium(
            fontWeight: FontWeight.w400,
            size: 12.sp,
            color: AppColors.baseWhite.withOpacity(0.4),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Rewards',
              style: AppTextStyles.largeBold(
                  fontWeight: FontWeight.w600,
                  size: 16,
                  color: AppColors.baseWhite.withOpacity(0.9)),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RewardBox(
                    tileColor: const Color.fromRGBO(253, 235, 86, 0.08),
                    context,
                    title: 'XP',
                    value: '345',
                    icon: Icons.star,
                    color: const Color(0xFFFDEB56),
                  ),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: RewardBox(
                    tileColor: const Color.fromRGBO(142, 201, 237, 0.08),
                    context,
                    title: 'Mystery Box',
                    value: '12',
                    icon: Icons.card_giftcard,
                    color: const Color.fromRGBO(142, 201, 237, 1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(
              color: AppColors.baseWhite.withOpacity(0.05),
            ),
            SizedBox(height: 16.h),
            // Usage in your widget:
            rewardPosterCard(
                'Mystery Box is Here! 😍',
                'Discover Hidden Treasures in Every Mystery Box!',
                'Available Box: ',
                '12',
                AppColors.xpColor,
                'Open Now', () {
              _showMysteryDialog(context);
            }, const FloatingGiftStack(), 'assets/images/bg/ray.png'),
            SizedBox(height: 16.h),
            rewardPosterCard(
                'All New Spinning Game',
                'Spin and win daily rewards! Try your luck now!',
                'Available Spins:',
                '12',
                const Color.fromRGBO(142, 201, 237, 1),
                'Spin Now', () {
              showDialog(
                context: context,
                builder: (context) => const DailySpinDialog(),
              );
            }, const SpinningWheelAnimation(),
                'assets/images/bg/card_spin.png'),
          ],
        ),
      ),
    );
  }

  void _showMysteryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Color.fromRGBO(52, 49, 17, 1), width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const MysteryDialogContent(),
        );
      },
    );
  }
}
