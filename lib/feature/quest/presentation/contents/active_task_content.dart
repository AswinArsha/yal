import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/quest/presentation/contents/bonus_card.dart';
import 'package:yalgamers/feature/quest/presentation/contents/task_tile.dart';
import 'package:yalgamers/feature/quest/presentation/pages/task_screen.dart';

class ActiveTasksContent extends StatefulWidget {
  const ActiveTasksContent({super.key});

  @override
  State<ActiveTasksContent> createState() => _ActiveTasksContentState();
}

class _ActiveTasksContentState extends State<ActiveTasksContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
            begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedTaskTile(Widget child, int index) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 0.2 + (index * 0.05)),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(0.2 + (index * 0.05), 1.0, curve: Curves.easeOut),
        )),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                60, // 👈 Tune this value
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Today's Tasks",
                      style: AppTextStyles.largeBold(
                          size: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  Text("16 July 2024",
                      style: AppTextStyles.small(
                          color: Colors.grey,
                          size: 12,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(height: 15),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildAnimatedTaskTile(
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TaskScreen(
                                title: 'Task 1',
                                statusColor: AppColors.secondary,
                                taskStatus: 'Pending',
                                buttonText: 'Complete Now',
                                buttonTextColor: Colors.black,
                              ))),
                      child: const TaskTile(
                        taskTitle: 'Watch a Tutorial',
                        card1Color: AppColors.purple,
                        card2Color: AppColors.blue,
                        cardlabel1: 'Task 1',
                        cardlabel2: 'New!',
                      ),
                    ),
                    index,
                  );
                },
              ),
              const SizedBox(height: 15),
              Text("Uncompleted Tasks",
                  style: AppTextStyles.largeBold(
                      size: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              const SizedBox(height: 15),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return _buildAnimatedTaskTile(
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TaskScreen(
                                      title: 'Task 1',
                                      statusColor: AppColors.red,
                                      taskStatus: 'Not completed',
                                      buttonText: 'Complete Now',
                                      buttonTextColor: Colors.black,
                                    ))),
                        child: const TaskTile(
                          taskTitle: 'Watch a Tutorial',
                          cardlabel1: 'Task 1',
                          cardlabel2: 'Not Completed',
                          card1Color: AppColors.purple,
                          card2Color: AppColors.red,
                          card2Icon: Icons.check_circle,
                        ),
                      ),
                      index + 5, // offset index
                    );
                  }),
              const SizedBox(height: 15),
              Text('Extra Bonuses',
                  style: AppTextStyles.largeBold(
                      size: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              const SizedBox(height: 10),
              ScaleTransition(
                scale: CurvedAnimation(
                    parent: _controller, curve: Curves.easeInOut),
                child: const BonusCard(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
