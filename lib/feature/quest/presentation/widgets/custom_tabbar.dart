import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.myTabs,
  });

  final List<Tab> myTabs;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        dividerColor: Colors.transparent, // <-- removes bottom underline
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(border: Border.all(color: AppColors.baseWhite.withOpacity(0.04)),
            color: AppColors.tabbarColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TabBar(
            dividerColor: Colors.transparent,
            tabs: myTabs,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
              indicatorHeight: 32.h,
              indicatorColor:  AppColors.  baseWhite.withOpacity( 0.1),
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            labelStyle: AppTextStyles.small(
                color: Colors.white, fontWeight: FontWeight.w400, size: 14),
            unselectedLabelStyle: const TextStyle(
              decoration: TextDecoration.none,
            ),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
      ),
    );
  }
}
