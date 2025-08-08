import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/quest/presentation/pages/task_screen.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';

class TaskTile extends StatelessWidget {
  final String cardlabel1;
  final String cardlabel2;
  final IconData? card2Icon;
  final Color card1Color;
  final Color card2Color;final String taskTitle;
  const TaskTile({
    super.key,
    required this.cardlabel1,
    required this.cardlabel2,
    this.card2Icon,
    required this.card1Color,
    required this.card2Color,required this.taskTitle
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey.withOpacity(0.1),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      LuminousCard(
                        luminousColor: card1Color,
                        label: cardlabel1,
                        // labelColor: Colors.purpleAccent,
                      ),
                      const SizedBox(width: 10),
                      LuminousCard(
                        prefixIcon: card2Icon,
                        luminousColor: card2Color,
                        label: cardlabel2,
                        //  labelColor: Colors.lightBlue),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    taskTitle,
                    style: AppTextStyles.mediumBold(
                        size: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
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
              )
            ],
          ),
        ));
  }
}
