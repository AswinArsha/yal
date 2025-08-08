import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class XpTabbar extends StatelessWidget {
  const XpTabbar({
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
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.tabbarColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          dividerColor: Colors.transparent,
          tabs: myTabs,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
            padding: const EdgeInsets.all(8),
            indicatorRadius: 4,
            indicatorHeight: 32.h,
            indicatorColor: AppColors.baseWhite.withOpacity(0.1),
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
    );
  }
}
