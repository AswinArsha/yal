import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalgamers/core/constants/common_widgets/custom_app_bar.dart';
import 'package:yalgamers/core/constants/common_widgets/success_dialog.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_form_field.dart';
import 'package:yalgamers/feature/quest/data/model/task_model.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_event.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_state.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/task_bloc/task_event.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/task_bloc/task_state.dart';
import 'package:yalgamers/feature/quest/presentation/task_types/demo_task_screen.dart';
import 'package:yalgamers/feature/quest/presentation/task_types/account_following_task.dart';
import 'package:yalgamers/feature/quest/presentation/task_types/rate_article.dart';
import 'package:yalgamers/feature/quest/presentation/task_types/subscribe_youtube.dart';
import 'package:yalgamers/feature/quest/presentation/task_types/telegram_join.dart';
import 'package:yalgamers/feature/quest/presentation/task_types/visit_website.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/shimmer_effect.dart';

class TaskScreen extends StatefulWidget {
  final taskId;
  final String title;
  final String taskStatus;
  final Color statusColor;
  final String buttonText;
  final Color buttonTextColor;
  const TaskScreen(
      {super.key,
      this.taskId,
      required this.title,
      required this.taskStatus,
      required this.statusColor,
      required this.buttonText,
      required this.buttonTextColor});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController textController = TextEditingController();
  bool _isFormFilled = false;

  @override
  void initState() {
    super.initState();

    context.read<TaskBloc>().add(
          LoadTask(taskId: widget.taskId),
        );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _checkFormFilled() {
    setState(() {
      _isFormFilled = textController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    // log('taskstatus ${widget.taskStatus}');
    // Define the button gradient based on the task status
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(28, 18, 31, 1),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomArrowBack(),
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400)),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
        if (state is TaskLoading) {
          return const TaskShimmerPlaceholder();
        } else if (state is TaskLoaded) {
          final TaskModel task = state.task;
          return Padding(
            padding: const EdgeInsets.all(12),
            child: _buildTaskWidget(task),
          );
        } else if (state is TaskError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  Widget _buildTaskWidget(TaskModel task) {
    switch (task.type) {
      case 'twitter_follow':
          return AccountFollowingTaskWidget(
            task: task,
            taskStatus: widget.taskStatus,
          );
        case 'twitter_retweet':
          return AccountFollowingTaskWidget(
            task: task,
            taskStatus: widget.taskStatus,
          );
        case 'telegram_join':
          return TelegramJoinWidget(
            task: task,
            taskStatus: widget.taskStatus,
          );
        case 'website_visit':
          return VisitWebsiteWidget(
            task: task,
            taskStatus: widget.taskStatus,
          );
        case 'discord_join':
        return WatchVideoWidget(
          taskStatus: widget.taskStatus,
          task: task,
        );
      case 'steam_link':
        return WatchVideoWidget(
          taskStatus: widget.taskStatus,
          task: task,
        );
      case 'article_read':
        return WatchVideoWidget(
          taskStatus: widget.taskStatus,
          task: task,
        );
      case 'article_review':
        return RateArticleWidget(
          task: task,
          taskStatus: widget.taskStatus,
        );
      case 'tutorial_watch':
        return WatchVideoWidget(
          taskStatus: widget.taskStatus,
          task: task,
        );
      case 'tutorial_review':
        return WatchVideoWidget(
          taskStatus: widget.taskStatus,
          task: task,
        );
      case 'youtube_subscribe':
        return SubscribeYoutubeWidget(
          task: task,
          taskStatus: widget.taskStatus,
        );
      case 'nft_claim':
        return WatchVideoWidget(
          taskStatus: widget.taskStatus,
          task: task,
        );
      default:
        return WatchVideoWidget(
          task: task,
          taskStatus: widget.taskStatus,
        );
    }
  }
}
