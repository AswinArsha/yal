import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/custom_tabbar.dart';

class TextandTab extends StatelessWidget {
  const TextandTab({
    super.key,
    required this.myTabs,
  });

  final List<Tab> myTabs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Find People to Make Match Together",
          style: AppTextStyles.small(
            color: AppColors.baseWhite.withOpacity(0.9),
            fontWeight: FontWeight.w500,
            size: 16,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(width: 300.w, child: CustomTabBar(myTabs: myTabs)),
        const SizedBox(height: 20),
      ],
    );
  }
}
