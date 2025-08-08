import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

Container recentGamesCard() {
  return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1C2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  height: 160.h,
                  width: double.infinity,
                  'assets/images/logos/recent_games.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(7, 40, 10, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Most Playing Game Now',
                    style: AppTextStyles.small(
                        color: const Color.fromRGBO(31, 208, 49, 1),
                        size: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('The Maze',
                        style: AppTextStyles.small(
                            fontWeight: FontWeight.w600,
                            size: 12,
                            color: const Color.fromRGBO(233, 230, 234, 1))),
                    const Spacer(),
                    const Text('2k+ Played',
                        style: TextStyle(
                            color: Color.fromRGBO(142, 201, 237, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.background,
                      backgroundImage:
                          AssetImage('assets/images/logos/logo_with_name.png'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Owned by',
                            style: AppTextStyles.small(
                                color: Colors.white38,
                                size: 10,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(height: 6),
                        Text('Yalgamers',
                            style: AppTextStyles.smallBold(
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                                size: 12)),
                      ],
                    ),
                    const Spacer(),
                    Text('Launched on 12 Jul',
                        style: AppTextStyles.smallBold(
                            color: Colors.white38,
                            fontWeight: FontWeight.w400,
                            size: 10))
                  ],
                ),
              ],
            ),
          ),
        ],
      ));
}
