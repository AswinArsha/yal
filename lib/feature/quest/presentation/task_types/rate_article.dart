// This file replaces the content of RateArticleWidget

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalgamers/core/constants/common_widgets/success_dialog.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/quest/data/model/task_model.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_event.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_state.dart';

class RateArticleWidget extends StatefulWidget {
  final TaskModel task;
  final String taskStatus;

  const RateArticleWidget({
    super.key,
    required this.task,
    required this.taskStatus,
  });

  @override
  State<RateArticleWidget> createState() => _RateArticleWidgetState();
}

class _RateArticleWidgetState extends State<RateArticleWidget> {
  final TextEditingController textController = TextEditingController();
  int overallRating = 0;
  final List<int> emojiRatings = [0, 0, 0];

  final List<String> questions = [
    'How do you like the graphics and design quality?',
    'Is the gameplay enjoyable?',
    'How do you find the game\'s optimization?'
  ];

  final List<String> emojis = [
    '😞', // Very sad
    '😕', // Sad
    '😐', // Neutral
    '😊', // Happy
    '😍' // Very happy
  ];

  bool get isFormFilled =>
      overallRating > 0 && emojiRatings.every((e) => e > 0);

  LinearGradient buttonGradient() {
    return const LinearGradient(
      colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text('Rate this article',
            style: AppTextStyles.mediumBold(size: 16.sp, color: Colors.white)),
        SizedBox(height: 20.h),
        Text('Overall Rating',
            style: AppTextStyles.medium(size: 14.sp, color: Colors.white)),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => overallRating = index + 1),
              child: Icon(
                Icons.star,
                size: 32.sp,
                color: index < overallRating ? Colors.amber : Colors.grey,
              ),
            );
          }),
        ),
        SizedBox(height: 30.h),
        for (int i = 0; i < questions.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(questions[i],
                    style:
                        AppTextStyles.medium(size: 14.sp, color: Colors.white)),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(emojis.length, (index) {
                    bool isSelected = emojiRatings[i] == index + 1;
                    return GestureDetector(
                      onTap: () => setState(() => emojiRatings[i] = index + 1),
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: AppColors.baseWhite.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8.r),
                          border: isSelected
                              ? Border.all(color: Colors.amber, width: 2)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            emojis[index],
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: isSelected
                                  ? null
                                  : Colors.white.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        Text('Write your opinion',
            style: AppTextStyles.medium(size: 14.sp, color: Colors.white)),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.baseWhite.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: textController,
            maxLines: 4,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: 'Type here...',
              hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.7), fontSize: 14.sp),
              filled: false,
              contentPadding: EdgeInsets.all(16.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const Spacer(),
        BlocListener<SaveTaskBloc, SaveTaskState>(
          listener: (context, state) {
            if (state is SaveTaskSuccess) {
              showSuccessDialog(context, 'Success',
                  'Thank you for your review!', widget.task.xp.toString());
            } else if (state is SaveTaskFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          child: PrimaryButton(
            label: 'Send to Approve',
            onPressed: isFormFilled
                ? () {
                    context.read<SaveTaskBloc>().add(
                          SaveTaskRequested(
                            taskId: widget.task.id,
                            username: textController.text.trim(),
                          ),
                        );
                  }
                : () {},
            gradient: isFormFilled ? buttonGradient() : null,
            textColor: isFormFilled ? Colors.black : Colors.white,
          ),
        ),
      ],
    );
  }
}
