import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yalgamers/core/constants/common_widgets/custom_app_bar.dart';
import 'package:yalgamers/core/constants/common_widgets/success_dialog.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/quest/data/model/task_model.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_event.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_state.dart';

class WatchVideoWidget extends StatefulWidget {
  const WatchVideoWidget({
    super.key,
    required this.task,
    required this.taskStatus,
    this.videoUrl, // Add optional video URL parameter
  });

  final TaskModel task;
  final String taskStatus;
  final String? videoUrl;

  @override
  State<WatchVideoWidget> createState() => _WatchVideoWidgetState();
}

class _WatchVideoWidgetState extends State<WatchVideoWidget> {
  YoutubePlayerController? _youtubeController;
  @override
  void initState() {
    super.initState();

    // Dummy YouTube video URL
    final url =
        widget.videoUrl ?? "https://www.youtube.com/watch?v=KJr4fQ9v4i0";

    final videoId = YoutubePlayer.convertUrlToId(url);
    print('videoId: $videoId');

    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          controlsVisibleAtStart: true,
          disableDragSeek: false,
          enableCaption: false,
          hideThumbnail: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          capitalizeFirstLetter(widget.task.titleEn),
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          capitalizeFirstLetter(widget.task.descriptionEn),
          style: AppTextStyles.medium(
            color: AppColors.baseWhite.withOpacity(0.6),
            size: 14.sp,
          ),
        ),
        const SizedBox(height: 24),
        if (_youtubeController != null)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.r),
              color: Colors.black,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: YoutubePlayer(
                controller: _youtubeController!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: AppColors.xpColor,
                progressColors: ProgressBarColors(
                  playedColor: AppColors.xpColor,
                  handleColor: AppColors.xpColor,
                ),
              ),
            ),
          ),
        if (_youtubeController != null) const SizedBox(height: 24),
        Row(
          children: [
            Text('Reward',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.baseWhite.withOpacity(0.4)),
                )),
            const SizedBox(width: 8),
            Container(
              width: 2,
              height: 12.h,
              color: AppColors.baseWhite.withOpacity(0.1), // Customize color
            ),
            const SizedBox(width: 8),
            Text(widget.task.xp.toString(),
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.xpColor),
                )),
            const SizedBox(width: 8),
            Image.asset('assets/icons/xp-icon.png'),
          ],
        ),
        const SizedBox(height: 15),
        Divider(thickness: 0.2, color: const Color.fromARGB(255, 255, 46, 238)),
        const SizedBox(height: 16),
        const Spacer(),
        BlocListener<SaveTaskBloc, SaveTaskState>(
          listener: (context, state) async {
            if (state is SaveTaskSuccess) {
              showSuccessDialog(
                  context,
                  'Congratulations',
                  'You completed a task of today, you got 100 XP as reward.',
                  widget.task.xp.toString());
            } else if (state is SaveTaskFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          child: PrimaryButton(
            textColor:
                widget.taskStatus == 'Completed' ? Colors.white : Colors.black,
            label: widget.taskStatus == 'Completed' ? 'Completed' : 'Done',
            gradient:
                widget.taskStatus == 'Completed' ? null : buttonGradience(),
            onPressed: widget.taskStatus == 'Completed'
                ? () {}
                : () {
                    context.read<SaveTaskBloc>().add(
                          SaveTaskRequested(
                            taskId: widget.task.id,
                          ),
                        );
                  },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
