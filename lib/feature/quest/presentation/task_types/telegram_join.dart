import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalgamers/core/constants/common_widgets/custom_app_bar.dart';
import 'package:yalgamers/core/constants/common_widgets/success_dialog.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_form_field.dart';
import 'package:yalgamers/feature/quest/data/model/task_model.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_event.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_state.dart';

class TelegramJoinWidget extends StatefulWidget {
  final TaskModel task;
  final String taskStatus;

  const TelegramJoinWidget({
    super.key,
    required this.task,
    required this.taskStatus,
  });

  @override
  State<TelegramJoinWidget> createState() => _TelegramJoinWidgetState();
}

class _TelegramJoinWidgetState extends State<TelegramJoinWidget> {
  final TextEditingController textController = TextEditingController();
  bool _isFormFilled = false;

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

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  LinearGradient buttonGradience() {
    return const LinearGradient(
      colors: [
        Color(0xFFFFD700), // Gold
        Color(0xFFFFA500), // Orange
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'To complete this task :',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: AppColors.baseWhite.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Follow on Twitter Row
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(6),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.xpColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'assets/icons/add_box.png',
                  height: 8.h,
                )),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                capitalizeFirstLetter(widget.task.titleEn),
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Spacer(),
            GradientFollowButton(
              label: 'Follow',
              onPressed: () async {
                final url = Uri.parse(widget.task.link ?? "");

                // Try opening externally first
                try {
                  bool launched = await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );

                  // If external launch failed, try in-app browser
                  if (!launched) {
                    await launchUrl(url, mode: LaunchMode.inAppWebView);
                  }
                } catch (e) {
                  // fallback if launch fails completely
                  await launchUrl(url, mode: LaunchMode.inAppWebView);
                }
              },
            )
          ],
        ),

        const SizedBox(height: 24),
        AppTextFormField(
          borderColor: const Color.fromARGB(57, 255, 46, 238),
          hintText: 'Enter your Telegram username',
          controller: textController,
          onChanged: (_) => _checkFormFilled(),
        ),
        const SizedBox(height: 16),
        Row(children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.baseWhite.withOpacity(0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Make sure you click on 'Done' once you joined the Telegram channel",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColors.baseWhite.withOpacity(0.6),
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ]),
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
            textColor: widget.taskStatus == 'Completed' || !_isFormFilled
                ? Colors.white
                : Colors.black,
            label: widget.taskStatus == 'Completed' ? 'Completed' : 'Done',
            gradient: widget.taskStatus == 'Completed' || !_isFormFilled
                ? null
                : buttonGradience(),
            onPressed: widget.taskStatus == 'Completed'
                ? () {}
                : () {
                    print('Form filled: $_isFormFilled');
                    context.read<SaveTaskBloc>().add(
                          SaveTaskRequested(
                            taskId: widget.task.id,
                            username: textController.text.trim(),
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
