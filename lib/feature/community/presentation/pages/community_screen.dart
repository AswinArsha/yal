import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/community/presentation/widgets/create_post_dialog.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFF100613),
            appBar: AppBar(
              backgroundColor: AppColors.buttonBackground,
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomArrowBack(),
              ),
              title: Text(
                'Community',
                style: AppTextStyles.medium(
                  fontWeight: FontWeight.w400,
                  size: 12,
                  color: AppColors.baseWhite.withOpacity(0.4),
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromRGBO(253, 235, 86, 0.1))),
                    color: Color.fromRGBO(253, 235, 86, 0.1),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Manage My Subscriptions',
                        style: AppTextStyles.medium(
                          fontWeight: FontWeight.w500,
                          size: 12,
                          color: AppColors.xpColor,
                        ),
                      ),
                      Text(
                        '12',
                        style: AppTextStyles.small(
                          fontWeight: FontWeight.w400,
                          size: 10,
                          color: AppColors.xpColor.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Explore',
                              style: AppTextStyles.mediumBold(
                                fontWeight: FontWeight.w600,
                                size: 16,
                                color: AppColors.baseWhite,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.buttonText.withOpacity(0.1),
                                ),
                                color: AppColors.buttonBackground,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/filter_white.png',
                                      height: 16.h,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Filter',
                                      style: AppTextStyles.medium(
                                        fontWeight: FontWeight.w400,
                                        size: 12,
                                        color: AppColors.baseWhite,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.baseWhite.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 16,
                                          backgroundImage:
                                              AssetImage('assets/beast.png'),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Mr. Beast',
                                                    style:
                                                        AppTextStyles.smallBold(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      size: 14,
                                                      color: AppColors.baseWhite
                                                          .withOpacity(0.9),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Icon(
                                                    Icons.verified,
                                                    color: AppColors.xpColor,
                                                    size: 14,
                                                  )
                                                ],
                                              ),
                                              Text(
                                                'Today at 02:32 pm',
                                                style: AppTextStyles.small(
                                                  fontWeight: FontWeight.w400,
                                                  size: 10,
                                                  color: const Color.fromRGBO(
                                                      126, 110, 131, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.more_vert,
                                            color: Colors.white54, size: 20),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'A cryptocurrency (colloquially crypto) is a digital currency designed to work through a computer network that is not reliant on any central authority, such as a government or See more...',
                                      style: AppTextStyles.medium(
                                        color: AppColors.baseWhite
                                            .withOpacity(0.9),
                                        fontWeight: FontWeight.w400,
                                        size: 12,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.asset(
                                        'assets/images/logos/crypto.png',
                                        width: double.infinity,
                                        height: 140.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Divider(
                                      color:
                                          AppColors.baseWhite.withOpacity(0.05),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Cards(
                                          cardColor:
                                              Color.fromRGBO(31, 208, 49, 1),
                                          prefixIcon:
                                              Icons.keyboard_arrow_up_outlined,
                                          label: '41',
                                        ),
                                        const SizedBox(width: 8),
                                        const Cards(
                                          cardColor:
                                              Color.fromRGBO(233, 230, 234, 1),
                                          prefixIcon: Icons
                                              .keyboard_arrow_down_outlined,
                                          label: '40',
                                        ),
                                        const SizedBox(width: 6),
                                        Cards(
                                          cardColor: AppColors.baseWhite
                                              .withOpacity(0.8),
                                          prefixIcon:
                                              Icons.screen_share_outlined,
                                          label: 'comment 12',
                                        ),
                                        const SizedBox(width: 8),
                                        const Cards(
                                          cardColor: Color.fromRGBO(
                                              142, 201, 237, 0.9),
                                          prefixIcon:
                                              Icons.screen_share_outlined,
                                          label: 'Share',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Divider(
                                      color:
                                          AppColors.baseWhite.withOpacity(0.05),
                                      height: 1,
                                    ),
                                    const SizedBox(height: 8),
                                    Card(
                                      color:
                                          AppColors.baseWhite.withOpacity(0.05),
                                      child: ListTile(
                                        leading: const CircleAvatar(
                                          radius: 16,
                                          backgroundImage:
                                              AssetImage('assets/user.png'),
                                        ),
                                        subtitle: Text(
                                          'That’s Really Nice, Loved It!',
                                          style: AppTextStyles.small(
                                            fontWeight: FontWeight.w400,
                                            size: 10,
                                            color: AppColors.baseWhite
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                        title: Text(
                                          'Kane Williams',
                                          style: AppTextStyles.smallBold(
                                            fontWeight: FontWeight.w400,
                                            size: 12,
                                            color: AppColors.baseWhite
                                                .withOpacity(0.9),
                                          ),
                                        ),
                                        trailing: Text(
                                          'Today at 02:32 pm',
                                          style: AppTextStyles.small(
                                            fontWeight: FontWeight.w400,
                                            size: 10,
                                            color: AppColors.baseWhite
                                                .withOpacity(0.4),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'View All Comments',
                                      style: AppTextStyles.medium(
                                        fontWeight: FontWeight.w500,
                                        size: 12,
                                        color: AppColors.baseWhite
                                            .withOpacity(0.3),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom fixed buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PrimaryButton(
                        label: 'Become an Influencer',
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        fontSize: 14,
                        backgroundColor: const Color.fromRGBO(142, 201, 237, 1),
                        textColor: const Color.fromRGBO(32, 47, 56, 1),
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        label: 'Explore More Memberships',
                        trailingIcon: Icons.arrow_forward_ios,
                        iconSize: 12,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        fontSize: 14,
                        backgroundColor:
                            const Color.fromRGBO(141, 153, 255, 0.15),
                        textColor: const Color.fromRGBO(141, 153, 255, 1),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(
                  bottom: 110.h, right: 16), // Ensure right padding too
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton.small(
                    heroTag: 'fab1',
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (context) => const ProfileDialog(),
                      // );
                    },
                    backgroundColor: AppColors.xpColor,
                    shape: const CircleBorder(), // Ensures circular shape
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/fab_person.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  FloatingActionButton.small(
                    heroTag: 'fab2',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const CreatePostDialog(),
                      );
                    },
                    backgroundColor: const Color.fromRGBO(142, 201, 237, 1),
                    shape: const CircleBorder(), // Ensures circular shape
                    child: ClipOval(
                      child: Image.asset(
                        'assets/icons/fab_pen.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}

// Same as before
class Cards extends StatelessWidget {
  final Color cardColor;
  final IconData prefixIcon;
  final String label;
  const Cards({
    super.key,
    required this.cardColor,
    required this.prefixIcon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(prefixIcon, color: cardColor, size: 14),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.medium(
                fontWeight: FontWeight.w400,
                size: 12,
                color: cardColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
