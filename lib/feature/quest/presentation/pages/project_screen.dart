import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/quest/presentation/contents/task_tile.dart';
import 'package:yalgamers/feature/quest/presentation/pages/task_screen.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';
import 'package:yalgamers/feature/quest/data/model/project_model.dart'; // Import your Project model

class ProjectScreen extends StatelessWidget {
  final Project
      project; // Pass the entire project object instead of individual fields

  const ProjectScreen({
    super.key,
    required this.project,
  });

  String _calculateTimeRemaining(String deadlineStr) {
    try {
      final deadline = DateTime.parse(deadlineStr);
      final now = DateTime.now();
      final difference = deadline.difference(now);

      if (difference.isNegative) {
        return 'Expired';
      }

      final days = difference.inDays;
      final hours = difference.inHours.remainder(24);

      if (days > 0) {
        return 'Ending in ${days}d ${hours}h';
      } else if (hours > 0) {
        return 'Ending in ${hours}h';
      } else {
        final minutes = difference.inMinutes;
        return 'Ending in ${minutes}m';
      }
    } catch (e) {
      return 'Invalid date';
    }
  }

  Color _getStatusColor() {
    if (project.isEnded) {
      return Colors.red;
    } else if (project.isActive) {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }

  String _getStatusText() {
    if (project.isEnded) {
      return 'Ended';
    } else if (project.isActive) {
      return 'Active';
    } else {
      return 'Inactive';
    }
  }

  Color _getTaskStatusColor(String taskState) {
    switch (taskState.toUpperCase()) {
      case 'COMPLETED':
        return Colors.green;
      case 'IN_PROGRESS':
        return Colors.orange;
      case 'NOT_STARTED':
      default:
        return Colors.grey;
    }
  }

  String _getTaskStatusLabel(String taskState) {
    switch (taskState.toUpperCase()) {
      case 'COMPLETED':
        return 'Completed';
      case 'IN_PROGRESS':
        return 'In Progress';
      case 'NOT_STARTED':
      default:
        return 'Not Started';
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedTasks =
        project.tasks.where((task) => task.state == 'COMPLETED').length;
    final totalTasks = project.tasks.length;
    final timeRemaining = _calculateTimeRemaining(project.deadline);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          project.titleEn,
          style: AppTextStyles.small(color: Colors.grey, size: 12),
        ),
        backgroundColor: Color.fromRGBO(28, 18, 31, 1),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomArrowBack(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: NetworkImage(project.bannerImg ?? project.image),
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: Colors.black.withOpacity(0.7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicWidth(
                          child: LuminousCard(
                            luminousColor: _getStatusColor(),
                            label: _getStatusText(),
                          ),
                        ),
                        const Spacer(),
                        IntrinsicWidth(
                          child: LuminousCard(
                            luminousColor: Colors.blue,
                            prefixIcon: Icons.access_time_rounded,
                            label: timeRemaining,
                          ),
                        ),
                        Text(
                          project.titleEn,
                          style: AppTextStyles.small(
                            color: Colors.white,
                            size: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          project.subTextEn,
                          style: AppTextStyles.small(
                            color: Colors.grey,
                            size: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Tasks",
                style: AppTextStyles.small(
                  color: Colors.white,
                  size: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              // Progress indicator
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Quests $completedTasks/$totalTasks',
                        style: AppTextStyles.small(
                          size: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      // Show progress indicators (max 5 circles)
                      ...List.generate(
                        totalTasks > 5 ? 5 : totalTasks,
                        (index) {
                          final isCompleted = index < completedTasks;
                          return Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.check_circle,
                              color: isCompleted ? Colors.green : Colors.grey,
                              size: 12,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Tasks list
              project.tasks.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          'No tasks available for this project',
                          style: AppTextStyles.small(
                            color: Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: project.tasks.length,
                      itemBuilder: (context, index) {
                        final task = project.tasks[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: InkWell(
                            onTap: () {
                              // task.state == 'COMPLETED'
                              //     ? null // Disable tap if task is completed
                              //     :

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TaskScreen(
                                  taskId: task.taskId,
                                  title: 'Task ${index + 1}',
                                  statusColor: _getTaskStatusColor(task.state),
                                  taskStatus: _getTaskStatusLabel(task.state),
                                  buttonText: 'Complete Now',
                                  buttonTextColor: Colors.black,
                                ),
                              ));
                            },
                            child: TaskTile(
                              taskTitle: task.taskTitleEn,
                              cardlabel1: 'Task ${index + 1}',
                              cardlabel2: _getTaskStatusLabel(task.state),
                              card1Color: AppColors.purple,
                              card2Color: _getTaskStatusColor(task.state),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
