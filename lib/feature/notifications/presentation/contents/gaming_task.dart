import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class GamingTaskScreen extends StatelessWidget {
  const GamingTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: AppTextStyles.small(
                  size: 12,
                  fontWeight: FontWeight.w500,
                  color:  AppColors.baseWhite.withOpacity( 0.7)),
            ),
             Divider(
              thickness: 0.5,
              color: AppColors.baseWhite.withOpacity( 0.1),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.asset(height: 18, 'assets/icons/white_sword.png'),
                const SizedBox(width: 8),
                Text(
                  'Local Tournament',
                  style: AppTextStyles.small(
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color:  AppColors.baseWhite.withOpacity( 0.4)),
                ),
                const Spacer(),
                 Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'New!',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(142, 201, 237, 1),
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: ' 5 mins ago',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.baseWhite.withOpacity( 0.4),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Tournament on your city!',
                        style: AppTextStyles.small(
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color:  AppColors.baseWhite.withOpacity( 0.8)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'PUBG Summer Championship.',
                        style: AppTextStyles.small(
                            size: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(253, 235, 86, 1)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Image with curved border
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12), // Adjust curvature here
                  child: Container(
                    width: 80, // Adjust width as needed
                    height: 80, // Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/images/task.png',
                      fit: BoxFit.cover, // Ensures image fills the container
                    ),
                  ),
                ),
              ],
            ),
             Divider(
              thickness: 0.5,
              color: AppColors.baseWhite.withOpacity( 0.1),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Image.asset(height: 18, 'assets/icons/white_sword.png'),
                const SizedBox(width: 8),
                Text(
                  'Daily Task',
                  style: AppTextStyles.small(
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color:  AppColors.baseWhite.withOpacity( 0.4)),
                ),
                const Spacer(),
                 Text(
                  '02:32 pm',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.baseWhite.withOpacity( 0.4),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Watch 2 Tutorials today.',
                        style: AppTextStyles.small(
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color:  AppColors.baseWhite.withOpacity( 0.8)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'XP 500',
                        style: AppTextStyles.small(
                            size: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(253, 235, 86, 1)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Image with curved border
                IntrinsicWidth(
                  child: Container(
                    height: 33.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.green.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Text(
                        'Complete Now',
                        style: AppTextStyles.verySmall(
                          size: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
             Divider(
              thickness: 0.5,
              color: AppColors.baseWhite.withOpacity( 0.1),
            ),
            const SizedBox(height: 4),
            Text(
              '07 Jul, 2024',
              style: AppTextStyles.small(
                  size: 12,
                  fontWeight: FontWeight.w500,
                  color:  AppColors.baseWhite.withOpacity( 0.7)),
            ),
            const SizedBox(height: 4),
             Divider(
              thickness: 0.5,
              color: AppColors.baseWhite.withOpacity( 0.1),
            ),
            Row(
              children: [
                Image.asset(height: 18, 'assets/icons/white_sword.png'),
                const SizedBox(width: 8),
                Text(
                  'Have Fun',
                  style: AppTextStyles.small(
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color:  AppColors.baseWhite.withOpacity( 0.4)),
                ),
                const Spacer(),
                 Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ' 5 mins ago',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.baseWhite.withOpacity( 0.4),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Game launched!',
                        style: AppTextStyles.small(
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color:  AppColors.baseWhite.withOpacity( 0.8)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'The Maze.',
                        style: AppTextStyles.small(
                            size: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(253, 235, 86, 1)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Image with curved border
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12), // Adjust curvature here
                  child: Container(
                    width: 80, // Adjust width as needed
                    height: 80, // Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/images/task.png',
                      fit: BoxFit.cover, // Ensures image fills the container
                    ),
                  ),
                ),
              ],
            ),
             Divider(
              thickness: 0.5,
              color: AppColors.baseWhite.withOpacity( 0.1),
            ),
            Row(
              children: [
                Image.asset(height: 18, 'assets/icons/white_sword.png'),
                const SizedBox(width: 8),
                Text(
                  'Local Tournament',
                  style: AppTextStyles.small(
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color:  AppColors.baseWhite.withOpacity( 0.4)),
                ),
                const Spacer(),
                 Text(
                  '02:32 pm',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.baseWhite.withOpacity( 0.4),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Tournament on your city!',
                        style: AppTextStyles.small(
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color:  AppColors.baseWhite.withOpacity( 0.8)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'PUBG Summer Championship.',
                        style: AppTextStyles.small(
                            size: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(253, 235, 86, 1)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Image with curved border
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12), // Adjust curvature here
                  child: Container(
                    width: 80, // Adjust width as needed
                    height: 80, // Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/images/task.png',
                      fit: BoxFit.cover, // Ensures image fills the container
                    ),
                  ),
                ),
              ],
            ),
             Divider(
              thickness: 0.5,
              color: AppColors.baseWhite.withOpacity( 0.1),
            ),
            Row(
              children: [
                Image.asset(height: 18, 'assets/icons/white_sword.png'),
                const SizedBox(width: 8),
                Text(
                  'Have Fun',
                  style: AppTextStyles.small(
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color:  AppColors.baseWhite.withOpacity( 0.4)),
                ),
                const Spacer(),
                 Text(
                  '02:32 pm',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.baseWhite.withOpacity( 0.4),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Game launched!',
                        style: AppTextStyles.small(
                            size: 16,
                            fontWeight: FontWeight.w600,
                            color:  AppColors.baseWhite.withOpacity( 0.8)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'The Maze.',
                        style: AppTextStyles.small(
                            size: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(253, 235, 86, 1)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Image with curved border
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12), // Adjust curvature here
                  child: Container(
                    width: 80, // Adjust width as needed
                    height: 80, // Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/images/task.png',
                      fit: BoxFit.cover, // Ensures image fills the container
                    ),
                  ),
                ),
              ],
            ),
             Divider(
              thickness: 0.5,
              color: AppColors.baseWhite.withOpacity( 0.1),
            ),
          ],
        ),
      ),
    );
  }
}
