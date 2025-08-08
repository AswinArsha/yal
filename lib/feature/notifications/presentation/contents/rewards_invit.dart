import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class RewardsInvitationScreen extends StatelessWidget {
  const RewardsInvitationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Today',
            style: AppTextStyles.small(
                size: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.baseWhite.withOpacity(0.7)),
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          ListTile(
            title: Text(
              '400 XP Received.',
              style: AppTextStyles.mediumBold(
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.baseWhite.withOpacity(0.8)),
            ),
            subtitle: Text(
              'Spend 1 hour a days.',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 10,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
            leading: Container(
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(253, 235, 86, 0.15)),
                child: Image.asset(height: 15.h, 'assets/icons/xp-icon.png')),
            trailing: Text(
              '02 : 32 pm',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 12,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          _buildNotificationCard(
            cardColor: Colors.green,
            title: '@alihaninah Invited you to join his team "Devil Hunters"',
            subtitle: 'PUBG Championship',
            time: '02 : 32 pm',
            date: '07 Jul, 2024',
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          Text(
            '07 Jul, 2024',
            style: AppTextStyles.small(
                size: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.baseWhite.withOpacity(0.7)),
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          ListTile(
            title: Text(
              'Level Upgraded!',
              style: AppTextStyles.mediumBold(
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.baseWhite.withOpacity(0.8)),
            ),
            subtitle: Text(
              'Profile level upgraded to level 4, Optimise Prime.',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 10,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
            leading: Container(
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(251, 161, 120, 0.15)),
                child:
                    Image.asset(height: 15.h, 'assets/icons/star_badge.png')),
            trailing: Text(
              '02 : 32 pm',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 12,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          _buildNotificationCard(
            cardColor: AppColors.baseWhite.withOpacity(0.3),
            title: '@alihaninah Invited you to join his team “Arab Warr...”',
            subtitle: 'Dota 2 Elite Cha...',
            time: '02 : 32 pm',
            date: '07 Jul, 2024', optionalIcon: Icons.clear, // Optional
            optionalText: 'Closed', // Optional
            optionalTextColor: const Color.fromRGBO(247, 23, 86, 1), // Optional
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          ListTile(
            title: Text(
              '10 Mystery Box Received.',
              style: AppTextStyles.mediumBold(
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.baseWhite.withOpacity(0.8)),
            ),
            subtitle: Text(
              '100k XP converted to tickets.',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 10,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
            leading: Container(
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(142, 201, 237, 0.15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/icons/gift.png'),
                )),
            trailing: Text(
              '02 : 32 pm',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 12,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          Text(
            '06 Jul, 2024',
            style: AppTextStyles.small(
                size: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.baseWhite.withOpacity(0.7)),
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          ListTile(
            title: Text(
              '400 XP Received.',
              style: AppTextStyles.mediumBold(
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.baseWhite.withOpacity(0.8)),
            ),
            subtitle: Text(
              'Spend 1 hour a days.',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 10,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
            leading: Container(
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(253, 235, 86, 0.15)),
                child: Image.asset(height: 15.h, 'assets/icons/xp-icon.png')),
            trailing: Text(
              '02 : 32 pm',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 12,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          ListTile(
            title: Text(
              '10 Mystery Box Received.',
              style: AppTextStyles.mediumBold(
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.baseWhite.withOpacity(0.8)),
            ),
            subtitle: Text(
              '100k XP converted to tickets.',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 10,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
            leading: Container(
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(142, 201, 237, 0.15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/icons/gift.png'),
                )),
            trailing: Text(
              '02 : 32 pm',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 12,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: AppColors.baseWhite.withOpacity(0.1),
          ),
          ListTile(
            title: Text(
              '10 Mystery Box Received.',
              style: AppTextStyles.mediumBold(
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.baseWhite.withOpacity(0.8)),
            ),
            subtitle: Text(
              '100k XP converted to tickets.',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 10,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
            leading: Container(
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(142, 201, 237, 0.15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/icons/gift.png'),
                )),
            trailing: Text(
              '02 : 32 pm',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 12,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String subtitle,
    required String time,
    required String date,
    required Color cardColor,
    IconData? optionalIcon, // New optional parameter
    String? optionalText, // New optional parameter
    Color? optionalTextColor, // New optional parameter
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overlapping images container
              SizedBox(
                width: 50.w,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 26.w,
                      height: 26.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/user.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15.w,
                      top: 12.h,
                      child: Container(
                        width: 26.w,
                        height: 26.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color.fromRGBO(46, 21, 54, 1),
                            width: 2,
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/user.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.small(
                        color: AppColors.baseWhite.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                        size: 14,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Optional icon and text row

                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          subtitle,
                          style: AppTextStyles.small(
                            color: const Color.fromRGBO(253, 235, 86, 1),
                            size: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (optionalIcon != null && optionalText != null) ...[
                          Icon(
                            optionalIcon,
                            size: 14,
                            color: optionalTextColor ??
                                Colors.white, // Default to white if null
                          ),
                          const SizedBox(width: 4),
                          Text(
                            optionalText,
                            style: AppTextStyles.small(
                              size: 12,
                              fontWeight: FontWeight.w400,
                              color: optionalTextColor ??
                                  Colors.white, // Default to white if null
                            ),
                          ),
                        ],
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: AppTextStyles.small(
                    fontWeight: FontWeight.w400,
                    size: 12,
                    color: AppColors.baseWhite.withOpacity(0.4),
                  ),
                ),
              const SizedBox(height: 8),
                IntrinsicWidth(
                  child: Container(
                    height: 33.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromRGBO(255, 255, 255, 0.05),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 18,
                            color: cardColor,
                          ),
                       const    SizedBox(width: 5),
                          Text(
                            'Accept Invitation',
                            style: AppTextStyles.verySmall(
                              size: 14,
                              fontWeight: FontWeight.w500,
                              color: cardColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
