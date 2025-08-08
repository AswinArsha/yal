import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/quest/presentation/contents/active_task_content.dart';
import 'package:yalgamers/feature/quest/presentation/contents/completed_task_content.dart';

class DailyQuestTabContent extends StatefulWidget {
  const DailyQuestTabContent({super.key});

  @override
  State<DailyQuestTabContent> createState() => _DailyQuestTabContentState();
}

class _DailyQuestTabContentState extends State<DailyQuestTabContent> {
  int selectedIndex = 0;
  final tabs = ['Active Tasks', 'Completed Tasks'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(tabs.length, (index) {
                final isSelected = selectedIndex == index;
                return InkWell(
                  onTap: () => setState(() => selectedIndex = index),
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF232334) : null,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(tabs[index],
                        style: AppTextStyles.small(
                            color: isSelected
                                ? Colors.lightBlue.shade100
                                : Colors.grey,
                            size: 12,
                            fontWeight: FontWeight.w400)),
                  ),
                );
              }),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: selectedIndex == 0
                  ? const ActiveTasksContent()
                  : const CompletedTasksContent(),
            ),
          ],
        ),
      ),
    );
  }
}
