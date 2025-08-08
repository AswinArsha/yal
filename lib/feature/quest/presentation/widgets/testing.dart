// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:yalgamers/core/constants/common_widgets/video_card_widget.dart';
// import 'package:yalgamers/core/theme/app_colors.dart';
// import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
// import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
// import 'package:yalgamers/feature/quest/data/model/task_model.dart';
// import 'package:yalgamers/feature/quest/presentation/bloc/task_bloc/task_bloc.dart';
// import 'package:yalgamers/feature/quest/presentation/bloc/task_bloc/task_event.dart';
// import 'package:yalgamers/feature/quest/presentation/bloc/task_bloc/task_state.dart';
// import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';
// import 'package:yalgamers/feature/quest/presentation/widgets/shimmer_effect.dart';

// class TaskScreen extends StatefulWidget {
//   final taskId;
//   final String title;
//   final String taskStatus;
//   final Color statusColor;
//   final String buttonText;
//   final Color buttonTextColor;
//   const TaskScreen(
//       {super.key,
//       this.taskId,
//       required this.title,
//       required this.taskStatus,
//       required this.statusColor,
//       required this.buttonText,
//       required this.buttonTextColor});

//   @override
//   State<TaskScreen> createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<TaskBloc>().add(
//           LoadTask(taskId: widget.taskId),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
// return Scaffold(
//   backgroundColor: AppColors.background,
//   appBar: AppBar(
//     backgroundColor: const Color.fromRGBO(28, 18, 31, 1),
//     leading: const Padding(
//       padding: EdgeInsets.all(8.0),
//       child: CustomArrowBack(),
//     ),
//     title: Text(
//       widget.title,
//       style: GoogleFonts.poppins(
//           textStyle: TextStyle(
//               color: Colors.grey,
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w400)),
//     ),
//     centerTitle: true,
//   ),
//       body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
//         if (state is TaskLoading) {
//           return const TaskShimmerPlaceholder();
//         } else if (state is TaskLoaded) {
//           final TaskModel task = state.task;
//           return Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 32),
//                   const Center(child: VideoCardWidget()),
//                   const SizedBox(height: 32),
//                   IntrinsicWidth(
//                     child: LuminousCard(
//                       luminousColor: widget.statusColor,
//                       label: widget.taskStatus,
//                       // labelColor: Colors.amber,
//                       prefixIcon: Icons.check_circle,
//                       // IconColor: Colors.red,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     task.titleEn,
//                     style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     task.descriptionEn,
//                     style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w400),
//                   ),
// const SizedBox(height: 15),
// const Divider(thickness: 0.3),
// const SizedBox(height: 15),
//                   Row(
//                     children: [
//                       Image.asset('assets/icons/xp-icon.png'),
//                       const SizedBox(width: 8),
//                       Container(
//                         width: 2,
//                         height: 12.h,
//                         color: AppColors.baseWhite
//                             .withOpacity(0.1), // Customize color
//                       ),
//                       const SizedBox(width: 8),
//                       Text(task.xp.toString(),
//                           style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14.sp,
//                                 color: AppColors.xpColor),
//                           ))
//                     ],
//                   ),
//                   const Spacer(),
//                   PrimaryButton(
//                     label: widget.buttonText,
//                     gradient: buttonGradience(),
//                     onPressed: () {
//                       showSuccessDialog(
//                           context,
//                           'Congratulations',
//                           'You completed a task of today, you got 100 XP as reward.',
//                           task.xp.toString());
//                     },
//                     textColor: widget.buttonTextColor,
//                   )
//                 ],
//               ));
//         } else if (state is TaskError) {
//           return Center(
//             child: Text(
//               state.message,
//               style: const TextStyle(color: Colors.red),
//             ),
//           );
//         } else {
//           return const SizedBox();
//         }
//       }),
//     );
//   }
// }

// void showSuccessDialog(context, String title, String subtitle, String xp) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) => Dialog(
//       backgroundColor: const Color(0xFF1C121F),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 image: const DecorationImage(
//                     image: AssetImage('assets/icons/check_mark.png')),
//                 color: Colors.green.withOpacity(0.2),
//                 shape: BoxShape.circle,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               subtitle,
//               style: const TextStyle(color: Colors.white70, fontSize: 14),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Reward',
//                     style: GoogleFonts.poppins(
//                       textStyle: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 12.sp,
//                           color: AppColors.baseWhite.withOpacity(0.4)),
//                     )),
//                 const SizedBox(width: 8),
//                 Image.asset('assets/icons/xp-icon.png'),
//                 const SizedBox(width: 8),
//                 Container(
//                   width: 2,
//                   height: 12.h,
//                   color:
//                       AppColors.baseWhite.withOpacity(0.1), // Customize color
//                 ),
//                 const SizedBox(width: 8),
//                 Text(xp,
//                     style: GoogleFonts.poppins(
//                       textStyle: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14.sp,
//                           color: AppColors.xpColor),
//                     ))
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );

//   Future.delayed(const Duration(seconds: 2), () {
//     Navigator.of(context).pop();
//     Navigator.of(context).pop();
//   });
// }