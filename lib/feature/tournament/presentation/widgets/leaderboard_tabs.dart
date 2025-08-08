import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class LeaderboardTabs extends StatefulWidget {
  const LeaderboardTabs({super.key});

  @override
  State<LeaderboardTabs> createState() => _LeaderboardTabsState();
}

class _LeaderboardTabsState extends State<LeaderboardTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),

        // Season Filter Row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Text(
                'Season Leaderboard',
                style: AppTextStyles.medium(
                  color: Colors.white,
                  size: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1532),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Text(
                      'This Season',
                      style: AppTextStyles.medium(
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Table Headers
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              SizedBox(width: 40.w, child: Text('#', style: _headerStyle())),
              SizedBox(width: 12.w),
              Expanded(
                child: Text('Team Name', style: _headerStyle()),
              ),
              SizedBox(width: 100.w, child: Text('Total Tournament', style: _headerStyle())),
            ],
          ),
        ),
        SizedBox(height: 8.h),

        // Table Content - showing Team list by default
        Expanded(
          child: _buildTeamList(),
        ),
      ],
    );
  }

  TextStyle _headerStyle() {
    return AppTextStyles.medium(
      color: Colors.white.withOpacity(0.5),
      size: 14,
    );
  }

  Widget _buildTeamList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1532),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40.w,
                child: Text(
                  '${index + 1}',
                  style: AppTextStyles.medium(color: Colors.white, size: 14),
                ),
              ),
              SizedBox(width: 12.w),
              // Add team avatar
              CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.grey[700],
                child: Icon(
                  Icons.group,
                  color: Colors.white,
                  size: 16.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Team Alpha ${index + 1}',
                  style: AppTextStyles.medium(color: Colors.white, size: 14),
                ),
              ),
              SizedBox(
                width: 100.w,
                child: Text(
                  '${(10 - index) * 5}',
                  style: AppTextStyles.medium(color: Colors.white, size: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}