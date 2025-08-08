import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/community/presentation/pages/community_screen.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';

Container communityCard() {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.buttonBackground,
        borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.group,
                  color: Color.fromRGBO(142, 201, 237, 1), size: 18),
              const SizedBox(width: 6),
              Text('Community',
                  style: AppTextStyles.small(
                      color: const Color.fromRGBO(142, 201, 237, 1),
                      fontWeight: FontWeight.w500,
                      size: 14)),
            ],
          ),

          const SizedBox(height: 8),
          Text('Get news and updates from exclusive influencers!',
              style: AppTextStyles.large(
                  color: AppColors.baseWhite.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  size: 20)),
          const SizedBox(height: 6),
          Text(
            'See various kinds of informative posts from different influencers over the world',
            style: AppTextStyles.large(
                color: AppColors.baseWhite.withOpacity(0.6),
                fontWeight: FontWeight.w400,
                size: 14),
          ),
          const SizedBox(height: 12),

          // Horizontal Influencer Cards
          SizedBox(
            height: 282.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return const CommunityItem();
              },
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(253, 235, 86, 1), // Yellow
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), // Border radius 6
              ),
            ),
            onPressed: () {},
            child: Text(
              'View all Posts',
              style: AppTextStyles.medium(
                fontWeight: FontWeight.w500,
                size: 14,
                color: const Color.fromRGBO(47, 44, 16, 1),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class CommunityItem extends StatelessWidget {
  final double? width;

  const CommunityItem({
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveWidth =
        width ?? MediaQuery.of(context).size.width * 0.8;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const CommunityScreen();
        }));
      },
      child: Container(
        width: effectiveWidth,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.baseWhite.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage('assets/beast.png'),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Mr. Beast',
                              style: AppTextStyles.smallBold(
                                  fontWeight: FontWeight.w400,
                                  size: 10.2,
                                  color: const Color.fromRGBO(
                                      255, 255, 255, 0.9))),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified,
                            color: AppColors.xpColor,
                            size: 11,
                          )
                        ],
                      ),
                      Text('Today at 02:32 pm',
                          style: AppTextStyles.small(
                              fontWeight: FontWeight.w400,
                              size: 8,
                              color: const Color.fromRGBO(126, 110, 131, 1))),
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(Icons.more_vert, color: Colors.white54, size: 14),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'A cryptocurrency (colloquially crypto) is a digital currency designed to work through a computer network that is not reliant on any central authority, such as a government or See more...',
              style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                  size: 8.75),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/logos/crypto.png',
                width: double.infinity,
                height: 125.h,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 4),
            Divider(color: AppColors.baseWhite.withOpacity(0.05)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LuminousCard(
                  luminousColor: Color.fromRGBO(31, 208, 49, 1),
                  label: '41',
                  prefixIcon: Icons.keyboard_arrow_up_outlined,
                ),
                const SizedBox(width: 6),
                const LuminousCard(
                  luminousColor: Color.fromRGBO(233, 230, 234, 1),
                  label: '40',
                  prefixIcon: Icons.keyboard_arrow_down_outlined,
                ),
                const SizedBox(width: 6),
                LuminousCard(
                  luminousColor: AppColors.baseWhite.withOpacity(0.8),
                  label: 'comment 12',
                  prefixIcon: Icons.screen_share_outlined,
                ),
                const SizedBox(width: 6),
                const LuminousCard(
                  luminousColor: Color.fromRGBO(142, 201, 237, 0.9),
                  label: 'Share',
                  prefixIcon: Icons.screen_share_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
