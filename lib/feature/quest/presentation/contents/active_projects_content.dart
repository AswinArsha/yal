import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalgamers/core/constants/common_widgets/shimmer_widget.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/quest/data/repository/project_repo.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/pages/project_screen.dart';

class ActiveProjectsContent extends StatefulWidget {
  const ActiveProjectsContent({super.key});

  @override
  State<ActiveProjectsContent> createState() => _ActiveProjectsContentState();
}

class _ActiveProjectsContentState extends State<ActiveProjectsContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _controller.forward();
    context.read<ProjectBloc>().add(LoadProjects());
    // 🔽 Call the API and print results
    ProjectService.fetchProjects().then((projects) {
      for (var project in projects) {
        print('Project title: ${project.titleEn}');
      }
    }).catchError((error) {
      print('Error fetching projects: $error');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedProjectCard(int index, Widget child) {
    final animation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.1 * index, 1.0, curve: Curves.easeOut),
    ));

    final fade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.1 * index, 1.0, curve: Curves.easeIn),
    ));

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: animation, child: child),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<ProjectBloc, ProjectState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProjectLoadingState) {
          return customShimmer();
        }
        if (state is ProjectSuccessState) {
          final now = DateTime.now();
          final activeProjects = state.projects.where((project) {
            final deadline = DateTime.parse(project.deadline);
            final isDeadlinePassed = now.isAfter(deadline);
            return project.isActive && !isDeadlinePassed && !project.isEnded;
          }).toList();

          if (activeProjects.isEmpty) {
            return const Center(
              child: Text(
                'No active projects available',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProjectBloc>().add(LoadProjects());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: activeProjects.length,
              itemBuilder: (context, index) {
                final project = activeProjects[index];
                final timeRemaining = _calculateTimeRemaining(project.deadline);

                return _buildAnimatedProjectCard(
                  index,
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProjectScreen(
                          project: project,
                        ),
                      ),
                    ),
                    child: AnimatedScale(
                      scale: 1,
                      duration: const Duration(milliseconds: 100),
                      child: Card(
                        elevation: 0,
                        color: const Color(0xFF170E1A),
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Color(0xFF231A26),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card top image + tags
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: screenHeight * 0.23,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6)),
                                  image: DecorationImage(
                                    image: NetworkImage(project.image),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    // Status and timer
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  200, 3, 20, 5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              '• Active',
                                              style: AppTextStyles.small(
                                                size: 12,
                                                color: Color(0xFF1FD031),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 4,
                                                bottom: 4,
                                                left: 4,
                                                right: 12),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF131B20),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.access_time_sharp,
                                                    color: Colors
                                                        .lightBlueAccent
                                                        .shade100,
                                                    size: 18),
                                                const SizedBox(width: 5),
                                                Text(
                                                  timeRemaining,
                                                  style: AppTextStyles.small(
                                                    size: 12,
                                                    color: Colors
                                                        .lightBlueAccent
                                                        .shade100,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2A0D32),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 14,
                                                  width: 40,
                                                  child: Image.asset(
                                                    'assets/icons/xp-icon.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                Text('|',
                                                    style: AppTextStyles.small(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 96, 80, 59),
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                const SizedBox(width: 6),
                                                Text(
                                                    // Calculate total XP from tasks
                                                    project.tasks
                                                        .fold(
                                                            0,
                                                            (sum, task) =>
                                                                sum +
                                                                task.taskXp)
                                                        .toString(),
                                                    style: AppTextStyles.small(
                                                      color: AppColors.xpColor,
                                                      size: 12,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const Spacer(),

                                    // Quests row with progress indicators
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, bottom: 8),
                                      child: Container(
                                        height: 35,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF19181B),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Quests',
                                              style: AppTextStyles.small(
                                                  size: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${project.tasks.where((task) => task.state == 'COMPLETED').length}/${project.tasks.length}',
                                              style: AppTextStyles.small(
                                                  size: 12,
                                                  color: Color(0xFF68566E),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Spacer(),
                                            ...List.generate(
                                                project.tasks.length > 5
                                                    ? 5
                                                    : project.tasks.length,
                                                (i) {
                                              final completed = i <
                                                  project.tasks
                                                      .where((task) =>
                                                          task.state ==
                                                          'COMPLETED')
                                                      .length;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: completed
                                                    ? Image.asset(
                                                        'assets/icons/checkmark-circle-projectquest.png', // ✅ Your completed icon image
                                                        width: 14,
                                                        height: 14,
                                                      )
                                                    : Image.asset(
                                                        'assets/icons/checkmark-circle-projectquest-disabled.png', // ✅ Your uncompleted icon image
                                                        width: 14,
                                                        height: 14,
                                                      ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Card content
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Text(
                                project.titleEn,
                                style: AppTextStyles.medium(
                                  color: Colors.white,
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                project.subTextEn,
                                style: AppTextStyles.small(
                                  color: const Color(0xFF7E6E83),
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
