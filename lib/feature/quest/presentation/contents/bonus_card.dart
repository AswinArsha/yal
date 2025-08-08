import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class BonusCard extends StatelessWidget {
  const BonusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Left colored container
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                    ),
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.09,
                    // Customize this color
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                      size: 55,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Text content (you can replace this with a Column if needed)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 50,
                              color: Colors
                                  .transparent, // Optional: make background transparent
                              child: Image.asset(
                                'assets/icons/xp-icon.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              '|',
                              style: AppTextStyles.small(
                                  color: const Color.fromARGB(255, 39, 39, 37),
                                  size: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '100',
                              style: AppTextStyles.small(
                                color: AppColors.xpColor,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Weekly Task Completion Bonus',
                          style: AppTextStyles.small(
                              size: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.deepPurple.withValues(alpha: 0.8)),
                        ),
                        Text(
                          'Finish all weekly tasks to earn the bonus.\nMissing one task means no bonus',
                          style: AppTextStyles.verySmall(
                              size: 10,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(97, 97, 97, 1)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
