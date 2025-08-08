import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';
import 'package:yalgamers/feature/support_ticket/presentation/pages/create_ticket.dart';
import 'package:yalgamers/feature/support_ticket/presentation/pages/ticket_details.dart';

class SupportTicketScreen extends StatelessWidget {
  const SupportTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.buttonBackground,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomArrowBack(),
        ),
        title: Text(
          'Support',
          style: AppTextStyles.medium(
            fontWeight: FontWeight.w400,
            size: 12.sp,
            color: AppColors.baseWhite.withOpacity(0.4),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(142, 201, 237, 0.10),
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Facing issues on Yalgamers?',
                    style: AppTextStyles.mediumBold(
                        size: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.baseWhite.withOpacity(0.9)),
                  ),
                  Text(
                    'By creating a ticket you can let us know about the issue you are having.',
                    style: AppTextStyles.mediumBold(
                        size: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.baseWhite.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const CreateTicketScreen();
                    })),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromRGBO(253, 235, 86, 0.15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(height: 14.h, 'assets/icons/add_box.png'),
                          const SizedBox(width: 10),
                          Text(
                            'Create New Ticket',
                            style: AppTextStyles.large(
                                fontWeight: FontWeight.w500,
                                size: 14.sp,
                                color: AppColors.xpColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 0.1),
            const SizedBox(height: 10),
            Text('My Tickets',
                style: AppTextStyles.mediumBold(
                    size: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.baseWhite.withOpacity(0.9))),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return const TicketDetailsScreen();
              })),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.03),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Better for multiline text
                  children: [
                    Image.asset('assets/images/bg/ticket.png'),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Have Fun Minin Games Doesn't appear to me.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.mediumBold(
                              fontWeight: FontWeight.w500,
                              size: 14.sp,
                              color: AppColors.baseWhite.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Created on 01 January, 2024",
                            style: AppTextStyles.mediumBold(
                              fontWeight: FontWeight.w400,
                              size: 12.sp,
                              color: AppColors.baseWhite.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('#4394839',
                                  style: AppTextStyles.mediumBold(
                                    fontWeight: FontWeight.w400,
                                    size: 10.sp,
                                    color: AppColors.baseWhite.withOpacity(0.5),
                                  )),
                              Text('. New Update',
                                  style: AppTextStyles.mediumBold(
                                    fontWeight: FontWeight.w400,
                                    size: 10.sp,
                                    color: Colors.green,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const LuminousCard(
                        luminousColor: Colors.green, label: 'Active')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
