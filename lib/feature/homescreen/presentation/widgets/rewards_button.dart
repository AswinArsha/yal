import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/homescreen/presentation/widgets/rewards_dialog.dart';

class RewardsCard extends StatelessWidget {
  const RewardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => const RewardsDialog(),
        );
      },
      child: Image.asset(
        'assets/icons/rewards_tile.png',
        width: 111.w,
        height: 36.sp
        ,
        fit: BoxFit.cover,
      ),
    );
  }
}
