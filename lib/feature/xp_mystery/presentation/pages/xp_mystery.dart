import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/custom_tabbar.dart';
import 'package:yalgamers/feature/xp_mystery/presentation/widgets/tabbar.dart';

class XPMysteryScreen extends StatelessWidget {
  XPMysteryScreen({super.key});
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Rewards'),
    const Tab(text: 'General Rewards'),
    const Tab(text: 'Earning History'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.all(12),
              child: CustomArrowBack(),
            ),
            backgroundColor: const Color.fromRGBO(28, 18, 31, 1),
            title: Text(
              'XP and Mystery Box',
              style: AppTextStyles.small(
                  fontWeight: FontWeight.w400,
                  size: 12,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
            centerTitle: true,
          ),
          backgroundColor: AppColors.background,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w), // Consistent side padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                // XP Container
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(253, 235, 86, 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color.fromRGBO(253, 235, 86, 0.1),
                            border: Border.all(
                              color: const Color.fromRGBO(253, 235, 86, 0.15),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/xp-icon.png',
                              height: 30.h,
                              width: 30.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My XP",
                              style: AppTextStyles.medium(
                                fontWeight: FontWeight.w500,
                                size: 12,
                                color: const Color.fromRGBO(227, 223, 183, 1),
                              ),
                            ),
                            Text(
                              "12440",
                              style: AppTextStyles.medium(
                                fontWeight: FontWeight.w400,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Mystery Box Container
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(142, 201, 237, 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color.fromRGBO(142, 201, 237, 0.2),
                            border: Border.all(
                              color: const Color.fromRGBO(142, 201, 237, 0.25),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/gift.png',
                              height: 30.h,
                              width: 30.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Available Mystery Boxes",
                              style: AppTextStyles.medium(
                                fontWeight: FontWeight.w400,
                                size: 12.sp,
                                color: AppColors.baseWhite.withOpacity(0.5),
                              ),
                            ),
                            Text(
                              "03",
                              style: AppTextStyles.small(
                                fontWeight: FontWeight.w400,
                                size: 18,
                                color: const Color.fromRGBO(233, 230, 234, 1),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8EC9ED),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Open Now',
                            style: AppTextStyles.small(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              size: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Divider(color: Colors.white.withOpacity(0.2)),
                SizedBox(height: 12.h),

                // Tab Bar Section
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.buttonBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        XpTabbar(myTabs: myTabs),
                        SizedBox(height: 24.h),
                        Text(
                          'Yalgamers Exclusive Rewards',
                          style: AppTextStyles.mediumBold(
                            color: const Color.fromRGBO(233, 230, 234, 1),
                            size: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),

                // Table Section
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.buttonBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Table Header
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 6.w),
                            decoration: BoxDecoration(
                              color: AppColors.baseWhite.withOpacity(0.08),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30.w,
                                  child: Text('#', style: _tableHeaderStyle()),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child:
                                      Text('Name', style: _tableHeaderStyle()),
                                ),
                                Text('Rewards', style: _tableHeaderStyle()),
                              ],
                            ),
                          ),
                          // Table Rows
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 12,
                            separatorBuilder: (context, index) =>
                                _buildDashedDivider(),
                            itemBuilder: (context, index) {
                              return Container(
                                color: AppColors.baseWhite.withOpacity(0.05),
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.h, horizontal: 6.w),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30.w,
                                      child: Text(
                                        '${index + 1}'.padLeft(2, '0'),
                                        style: _tableCellStyle(),
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Text(
                                        'Sign Up',
                                        style: _tableCellStyle(
                                          color: const Color.fromRGBO(
                                              233, 230, 234, 1),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '50 XP',
                                      style: _tableCellStyle(
                                        color: const Color(0xFFFDEB56),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashedDivider() {
    return Container(
      color: AppColors.baseWhite.withOpacity(0.05),
      height: 1,
      child: Row(
        children: List.generate(
          50, // Number of dashes
          (index) => Expanded(
            child: Container(
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              color: index % 2 == 0
                  ? Colors.white.withOpacity(0.1)
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _tableHeaderStyle() {
    return AppTextStyles.small(
      color: Colors.white.withOpacity(0.7),
      size: 12,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle _tableCellStyle({Color color = Colors.white}) {
    return AppTextStyles.small(
      color: color,
      size: 12,
      fontWeight: FontWeight.w400,
    );
  }
}
