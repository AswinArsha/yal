import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/pages/game_recommendation_screen.dart';
import 'package:yalgamers/feature/find_players/presentation/pages/view_profile.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/percent_circle.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/solid_button.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';

class DetailProfileCard extends StatefulWidget {
  const DetailProfileCard({
    super.key,
    required this.items,
  });

  final List<Map<String, String>> items;

  @override
  State<DetailProfileCard> createState() => _DetailProfileCardState();
}

class _DetailProfileCardState extends State<DetailProfileCard> {String? name;
  String? userName;
  
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  
   Future<void> _loadUser() async {
    final user = await TokenService.getUser();
    setState(() {
      name = user?['name'] ?? 'Guest';
      userName=user?['username']??'guest_user';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromRGBO(142, 201, 237, 0.3), Colors.transparent],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // ✅ Important to shrink wrap
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 21,
                  backgroundImage: AssetImage('assets/user.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? 'Guest User',
                      style: AppTextStyles.mediumBold(
                        fontWeight: FontWeight.w600,
                        size: 16,
                        color: AppColors.baseWhite.withOpacity(0.9),
                      ),
                    ),
                    Text(
                      userName ?? 'guest_user',
                      style: AppTextStyles.small(
                        fontWeight: FontWeight.w400,
                        size: 12,
                        color: AppColors.baseWhite.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const LuminousCard(
                  radius: 100,
                  fontSize: 12,
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  luminousColor: Color.fromRGBO(142, 201, 237, 1),
                  label: 'Best Match',
                ),
                const SizedBox(width: 5),
                const PercentageCircle(percent: 99),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              itemCount: widget.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2,
              ),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                  decoration: BoxDecoration(
                    color: AppColors.baseWhite.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item['title']!,
                        style: AppTextStyles.verySmall(
                          color: AppColors.baseWhite.withOpacity(0.4),
                          fontWeight: FontWeight.w400,
                          size: 10.sp,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle']!,
                        style: AppTextStyles.medium(
                          fontWeight: FontWeight.w500,
                          color: AppColors.baseWhite.withOpacity(0.9),
                          size: 12.sp,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SolidButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ViewProfileScreen();
                    }));
                  },
                  label: 'View Profile',
                  buttonColor: const Color.fromRGBO(188, 90, 215, 1),
                  prefixImage: 'assets/icons/list.png',
                ),
                SolidButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const GameRecommendationScreen();
                      }));
                    },
                    label: 'Start Chatting',
                    buttonColor: const Color.fromRGBO(142, 201, 237, 1),
                    prefixImage: 'assets/icons/chat.png')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
