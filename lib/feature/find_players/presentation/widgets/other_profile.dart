import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/pages/view_profile.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/percent_circle.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/solid_button.dart';

class OtherProfileCard extends StatelessWidget {
  const OtherProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
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
                        'Ali Haninah',
                        style: AppTextStyles.mediumBold(
                          fontWeight: FontWeight.w600,
                          size: 16,
                          color: AppColors.baseWhite.withOpacity(0.9),
                        ),
                      ),
                      Text(
                        '@haninah778',
                        style: AppTextStyles.small(
                          fontWeight: FontWeight.w400,
                          size: 12,
                          color: AppColors.baseWhite.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const PercentageCircle(percent: 92),
                ],
              ),
              const SizedBox(height: 20),
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
                    onPressed: () {},
                    label: 'Start Chatting',
                    buttonColor: const Color.fromRGBO(142, 201, 237, 1),
                    prefixImage: 'assets/icons/chat.png',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
