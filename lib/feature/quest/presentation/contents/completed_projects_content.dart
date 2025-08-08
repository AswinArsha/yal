// import 'package:flutter/material.dart';
// import 'package:yalgamers/core/theme/app_colors.dart';
// import 'package:yalgamers/core/theme/text_style.dart';
// import 'package:yalgamers/feature/quest/presentation/pages/project_screen.dart';

// class CompletedProjectsContent extends StatelessWidget {
//   const CompletedProjectsContent({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return FlipAnimatedListItem(
//           index: index,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                 return const ProjectScreen(
//                   status: 'Ended',
//                   statusColor: Colors.white,
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
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/bg/project_bg.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black38,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Text(
//                                   'Ended',
//                                   style: AppTextStyles.small(
//                                       size: 12,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: const Color.fromARGB(200, 9, 31, 12),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     const Icon(
//                                       Icons.check_circle,
//                                       size: 12,
//                                       color: Colors.green,
//                                     ),
//                                     const SizedBox(width: 5),
//                                     Text(
//                                       'Completed',
//                                       style: AppTextStyles.small(
//                                           size: 12,
//                                           color: Colors.green,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xFF2A0D32),
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         height: 14,
//                                         width: 40,
//                                         color: Colors.transparent,
//                                         child: Image.asset(
//                                           'assets/icons/xp-icon.png',
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                       Text(
//                                         '|',
//                                         style: AppTextStyles.small(
//                                             color: const Color.fromARGB(255, 96, 80, 59),
//                                             size: 12,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       const SizedBox(width: 6),
//                                       Text(
//                                         '100',
//                                         style: AppTextStyles.small(
//                                           color: AppColors.xpColor,
//                                           size: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             ],
//                           ),
//                         ),
//                         const Spacer(),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
//                     child: Text(
//                       'In todays world crypto is much...',
//                       style: AppTextStyles.small(
//                           color: const Color.fromRGBO(189, 189, 189, 1),
//                           size: 12,
//                           fontWeight: FontWeight.w400),
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

// class FlipAnimatedListItem extends StatefulWidget {
//   final Widget child;
//   final int index;

//   const FlipAnimatedListItem({
//     super.key,
//     required this.child,
//     required this.index,
//   });

//   @override
//   State<FlipAnimatedListItem> createState() => _FlipAnimatedListItemState();
// }

// class _FlipAnimatedListItemState extends State<FlipAnimatedListItem>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(milliseconds: 600 + widget.index * 100),
//       vsync: this,
//     );

//     _animation = Tween<double>(
//       begin: 1.0,  // starts flipped away (180 degrees)
//       end: 0.0,    // ends facing front (0 degrees)
//     ).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
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
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         // rotationY goes from pi (180°) to 0 radians
//         double rotationY = _animation.value * 3.14159;

//         // To fix the mirrored text, flip when past halfway
//         final isUnder = rotationY > 3.14159 / 2;

//         return Transform(
//           alignment: Alignment.center,
//           transform: Matrix4.identity()
//             ..setEntry(3, 2, 0.001) // perspective
//             ..rotateY(rotationY),
//           child: isUnder
//               ? Transform(
//                   alignment: Alignment.center,
//                   transform: Matrix4.identity()..rotateY(3.14159),
//                   child: child,
//                 )
//               : child,
//         );
//       },
//       child: widget.child,
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

class CompletedProjectsContent extends StatefulWidget {
  const CompletedProjectsContent({super.key});

  @override
  State<CompletedProjectsContent> createState() =>
      _CompletedProjectsContentState();
}

class _CompletedProjectsContentState extends State<CompletedProjectsContent>
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

  String _formatCompletedDate(String deadlineStr) {
    try {
      final deadline = DateTime.parse(deadlineStr);
      return 'Completed ${deadline.day}/${deadline.month}/${deadline.year}';
    } catch (e) {
      return 'Completed';
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
          final now = DateTime.now();

          // Filter projects where deadline has passed but they were active
          final completedProjects = state.projects.where((project) {
            final deadline = DateTime.parse(project.deadline);
            final isDeadlinePassed = now.isAfter(deadline);
            // Projects that had active status but deadline passed = completed
            return isDeadlinePassed && project.isActive && !project.isEnded;
          }).toList();

          if (completedProjects.isEmpty) {
            return const Center(
              child: Text(
                'No completed projects available',
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
              itemCount: completedProjects.length,
              itemBuilder: (context, index) {
                final project = completedProjects[index];
                final completedDate = _formatCompletedDate(project.deadline);

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
                                            color: Colors.blue.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            '• Completed',
                                            style: AppTextStyles.small(
                                              size: 12,
                                              color: Colors.blue,
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
                                              Icon(Icons.check_circle,
                                                  color: Colors.blue, size: 12),
                                              const SizedBox(width: 5),
                                              Text(
                                                completedDate,
                                                style: AppTextStyles.small(
                                                  size: 12,
                                                  color: Colors.blue,
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
