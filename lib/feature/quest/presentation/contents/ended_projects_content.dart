// import 'package:flutter/material.dart';
// import 'package:yalgamers/core/theme/app_colors.dart';
// import 'package:yalgamers/core/theme/text_style.dart';
// import 'package:yalgamers/feature/quest/presentation/pages/project_screen.dart';

// class EndedProjectsContent extends StatelessWidget {
//   final String status;
//   final Color statusColor;
//   const EndedProjectsContent({
//     super.key,
//     required this.status,
//     required this.statusColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 5, // Change to your data length
//       itemBuilder: (context, index) {
//         return AnimatedListItem(
//           index: index,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                 return ProjectScreen(
//                   status: 'Ended',
//                   statusColor: AppColors.baseWhite.withOpacity(1),
//                 );
//               }));
//             },
//             child: Card(
//               color: Colors.grey[900],
//               margin: const EdgeInsets.only(bottom: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: screenHeight * 0.23,
//                     width: double.infinity,
//                     decoration: const BoxDecoration(
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(6)),
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/bg/project_bg.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding:
//                               const EdgeInsets.only(top: 8, left: 8, right: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black38,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Text(
//                                   status,
//                                   style: AppTextStyles.small(
//                                     size: 12,
//                                     color: statusColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF2A0D32),
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 14,
//                                       width: 40,
//                                       color: Colors.transparent,
//                                       child: Image.asset(
//                                         'assets/icons/xp-icon.png',
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                     Text(
//                                       '|',
//                                       style: AppTextStyles.small(
//                                         color: const Color.fromARGB(
//                                             255, 96, 80, 59),
//                                         size: 12,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 6),
//                                     Text(
//                                       '100',
//                                       style: AppTextStyles.small(
//                                         color: AppColors.xpColor,
//                                         size: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     child: Text(
//                       'ADEALZ- Connecting People With Web3',
//                       style: AppTextStyles.medium(
//                         color: Colors.white,
//                         size: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
//                     child: Text(
//                       'In todays world crypto is much...',
//                       style: AppTextStyles.small(
//                         color: const Color.fromRGBO(189, 189, 189, 1),
//                         size: 12,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class AnimatedListItem extends StatefulWidget {
//   final Widget child;
//   final int index;
//   const AnimatedListItem({super.key, required this.child, required this.index});

//   @override
//   State<AnimatedListItem> createState() => _AnimatedListItemState();
// }

// class _AnimatedListItemState extends State<AnimatedListItem>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _offsetAnimation;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(milliseconds: 500 + widget.index * 100),
//       vsync: this,
//     );

//     _offsetAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.2),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: _opacityAnimation,
//       child: SlideTransition(
//         position: _offsetAnimation,
//         child: widget.child,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalgamers/core/constants/common_widgets/shimmer_widget.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/pages/project_screen.dart';

class EndedProjectsContent extends StatefulWidget {
  final String status;
  final Color statusColor;

  const EndedProjectsContent({
    super.key,
    required this.status,
    required this.statusColor,
  });

  @override
  State<EndedProjectsContent> createState() => _EndedProjectsContentState();
}

class _EndedProjectsContentState extends State<EndedProjectsContent>
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

  String _formatEndedDate(String deadlineStr) {
    try {
      final deadline = DateTime.parse(deadlineStr);
      return 'Ended ${deadline.day}/${deadline.month}/${deadline.year}';
    } catch (e) {
      return 'Ended';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        if (state is ProjectLoadingState) {
          return customShimmer();
        }

        if (state is ProjectSuccessState) {
          // Filter projects that are ended or inactive
          final endedProjects = state.projects.where((project) {
            return !project.isActive || project.isEnded;
          }).toList();

          if (endedProjects.isEmpty) {
            return const Center(
              child: Text(
                'No ended projects available',
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
              itemCount: endedProjects.length,
              itemBuilder: (context, index) {
                final project = endedProjects[index];
                final endedDate = _formatEndedDate(project.deadline);

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
                        color: const Color.fromRGBO(28, 18, 31, 1),
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card top image + tags
                            Container(
                              height: screenHeight * 0.23,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(6)),
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
                                            color: Colors.grey.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            '• Ended',
                                            style: AppTextStyles.small(
                                              size: 12,
                                              color: widget.statusColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF131B20),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.timer,
                                                  color: Colors.grey, size: 12),
                                              const SizedBox(width: 5),
                                              Text(
                                                endedDate,
                                                style: AppTextStyles.small(
                                                  size: 12,
                                                  color: Colors.grey,
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
                                                BorderRadius.circular(6),
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
                                                    color: const Color.fromARGB(
                                                        255, 96, 80, 59),
                                                    size: 12,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              const SizedBox(width: 6),
                                              Text(
                                                project.tasks
                                                    .fold(
                                                        0,
                                                        (sum, task) =>
                                                            sum + task.taskXp)
                                                    .toString(),
                                                style: AppTextStyles.small(
                                                  color: AppColors.xpColor,
                                                  size: 12,
                                                ),
                                              ),
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
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF19181B),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Quests ${project.tasks.where((task) => task.state == 'COMPLETED').length}/${project.tasks.length}',
                                            style: AppTextStyles.small(
                                                size: 12,
                                                color: Colors.white,
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
                                                    left: 6),
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: completed
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  size: 12,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                                  color: const Color.fromRGBO(189, 189, 189, 1),
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
