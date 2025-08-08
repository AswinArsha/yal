// import 'package:flutter/material.dart';
// import 'package:yalgamers/core/theme/text_style.dart';
// import 'package:yalgamers/feature/quest/presentation/contents/active_projects_content.dart';
// import 'package:yalgamers/feature/quest/presentation/contents/completed_projects_content.dart';
// import 'package:yalgamers/feature/quest/presentation/contents/ended_projects_content.dart';

// class ProjectQuestTabContent extends StatefulWidget {
//   const ProjectQuestTabContent({
//     super.key,
//   });

//   @override
//   State<ProjectQuestTabContent> createState() => _ProjectQuestTabContentState();
// }

// class _ProjectQuestTabContentState extends State<ProjectQuestTabContent> {
//   final tabs = ['Active (07)', 'Ended Projects', 'Completed Projects'];
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 15,top: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: List.generate(tabs.length, (index) {
//               final isSelected = selectedIndex == index;
//               return InkWell(
//                 onTap: () => setState(() => selectedIndex = index),
//                 borderRadius: BorderRadius.circular(8),
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: isSelected ? Colors.blue.withOpacity(0.2) : null,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     tabs[index],
//                     style: AppTextStyles.small(
//                         fontWeight: FontWeight.w400,
//                         color: isSelected
//                             ? Colors.lightBlue.shade100
//                             : Colors.grey,
//                         size: 12),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//         const SizedBox(height: 15),
//         Expanded(
//             child: selectedIndex == 0
//                 ? const ActiveProjectsContent()
//                 : selectedIndex == 1
//                     ? const EndedProjectsContent(
//                         status: 'Ended',
//                         statusColor: Colors.white,
//                       )
//                     : const CompletedProjectsContent()),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/contents/active_projects_content.dart';
import 'package:yalgamers/feature/quest/presentation/contents/completed_projects_content.dart';
import 'package:yalgamers/feature/quest/presentation/contents/ended_projects_content.dart';

class ProjectQuestTabContent extends StatefulWidget {
  const ProjectQuestTabContent({
    super.key,
  });

  @override
  State<ProjectQuestTabContent> createState() => _ProjectQuestTabContentState();
}

class _ProjectQuestTabContentState extends State<ProjectQuestTabContent> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        int activeCount = 0;
        int endedCount = 0;
        int completedCount = 0;

        if (state is ProjectSuccessState) {
          final now = DateTime.now();

          for (var project in state.projects) {
            final deadline = DateTime.parse(project.deadline);
            final isDeadlinePassed = now.isAfter(deadline);

            if (project.isActive && !isDeadlinePassed) {
              activeCount++;
            } else if (!project.isActive || project.isEnded) {
              endedCount++;
            } else if (isDeadlinePassed) {
              completedCount++;
            }
          }
        }

        final tabs = [
          'Active ($activeCount)',
          'Ended ($endedCount)',
          'Completed ($completedCount)'
        ];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(tabs.length, (index) {
                  final isSelected = selectedIndex == index;
                  return InkWell(
                    onTap: () => setState(() => selectedIndex = index),
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFF232334) : null,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tabs[index],
                        style: AppTextStyles.small(
                          fontWeight: FontWeight.w400,
                          color: isSelected
                              ? Colors.lightBlue.shade100
                              : Colors.grey,
                          size: 12,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: selectedIndex == 0
                  ? const ActiveProjectsContent()
                  : selectedIndex == 1
                      ? const EndedProjectsContent(
                          status: 'Ended',
                          statusColor: Colors.white,
                        )
                      : const CompletedProjectsContent(),
            ),
          ],
        );
      },
    );
  }
}
