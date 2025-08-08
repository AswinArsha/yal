import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class RecommendedGamesView extends StatelessWidget {
  final String title;
  final int itemCount;
  final Widget Function() gameCardBuilder;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  const RecommendedGamesView({
    super.key,
    this.title = "Choose Recommended Games",
    this.itemCount = 5,
    required this.gameCardBuilder,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? const Color(0xFF212835),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.mediumBold(
                      size: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.baseWhite.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: gameCardBuilder(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
