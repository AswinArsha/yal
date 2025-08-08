import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

// Add these classes here, before your CreateTournamentScreen class
class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  const DashedBorderContainer({
    Key? key,
    required this.child,
    required this.borderColor,
    this.strokeWidth = 1.0,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        borderColor: borderColor,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  DashedBorderPainter({
    required this.borderColor,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = borderColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      ));

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const double dashWidth = 4.0;
    const double dashSpace = 4.0;
    double distance = 0.0;

    for (ui.PathMetric pathMetric in path.computeMetrics()) {  // Changed this line
      while (distance < pathMetric.length) {
        Path dashPath = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(dashPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class CreateTournamentScreen extends StatefulWidget {
  const CreateTournamentScreen({super.key});

  @override
  State<CreateTournamentScreen> createState() => _CreateTournamentScreenState();
}

class _CreateTournamentScreenState extends State<CreateTournamentScreen> {
  String textField1 = '';
  String textField2 = '';
  String textField3 = '';
  int currentStep = 1; // Track current step (1, 2, 3, 4, or 5)
  bool isOnlineSelected = true;  // Add this line
bool isLocalSelected = false; // Add this line
  bool isSoloSelected = false;
  bool isSquadSelected = true;
  bool isFreeSelected = false;
  bool isPaidSelected = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFF1C121F),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/tournament/tournament_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       
// Header
IntrinsicHeight(
  child: Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xFF271E2A),
          width: 1,
        ),
      ),
      color: Color(0xFF1C121F),
    ),
    padding: const EdgeInsets.only(top: 9, bottom: 9, left: 20, right: 20),
    margin: const EdgeInsets.only(bottom: 16),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: IntrinsicWidth(
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0x12FFFFFF),
                ),
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                     child: SvgPicture.asset(
  "assets/images/tournament/clans/Arrow-Left.svg",
  fit: BoxFit.fill,
),  
  

                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Text(
          "Creating a New Tournament",
          style: TextStyle(
            color: Color(0x66FFFFFF),
            fontSize: 12,
          ),
        ),
        Container(
          width: 36,
          height: 36,
          child: const SizedBox(),
        ),
      ],
    ),
  ),
),

                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               
                                // Content based on current step
                                currentStep == 1 
                                    ? _buildStep1Content() 
                                    : currentStep == 2 
                                        ? _buildStep2Content()
                                        : currentStep == 3
                                            ? _buildStep3Content()
                                            : currentStep == 4
                ? _buildStep4Content()
                : currentStep == 5
                    ? _buildStep5Content()
                    : _buildStep6Content()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Section
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0x12FFFFFF),
                      width: 1,
                    ),
                  ),
                  color: Color(0x26100613),
                ),
                padding: const EdgeInsets.only(top: 12),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 3),
                            margin: const EdgeInsets.only(right: 8),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  width: 12,
                                  height: 12,
                                  child: SvgPicture.asset(
  "assets/images/tournament/tournament/Check.svg",
  fit: BoxFit.fill,
), 
                                ),
                                const Text(
                                  "Completed",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 2),
                            child: Row(
                              children: [
                                Container(
  margin: const EdgeInsets.only(right: 5),
  child: Text(
    "${currentStep.toString().padLeft(2, '0')}",
    style: const TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 12,
    ),
  ),
),
                                const Text(
                                  "/06",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0x12FFFFFF),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 11),
                                margin: const EdgeInsets.only(right: 15),
                                width: double.infinity,
                                child: const Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                             onTap: () {
  if (currentStep == 1) {
    setState(() {
      currentStep = 2;
    });
  } else if (currentStep == 2) {
    setState(() {
      currentStep = 3;
    });
  } else if (currentStep == 3) {
    setState(() {
      currentStep = 4;
    });
  } else if (currentStep == 4) {
    setState(() {
      currentStep = 5;
    });
  } else if (currentStep == 5) {
    setState(() {
      currentStep = 6;
    });
  } else if (currentStep == 6) {
    // Show success modal after step 6
    _showSuccessModal(context);
  } else {
    print('Final Submit Pressed');
  }
},
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0x26FFFFFF),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    begin: Alignment(1, -1),
                                    end: Alignment(1, 1),
                                    colors: [
                                      Color(0xFFFDEB56),
                                      Color(0xFFAA9E39),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 11),
                                width: double.infinity,
                                child: const Center(
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                      color: Color(0xFF24210A),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1Content() {
    return Container(
      margin: const EdgeInsets.only(bottom: 208, left: 16, right: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // General Section
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "General",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tournament Title
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: const Text(
                                    "Tournament Title",
                                    style: TextStyle(
                                      color: Color(0xCCFFFFFF),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0x12FFFFFF),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0x26100613),
                                  ),
                                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 24),
                                  width: double.infinity,
                                  child: TextField(
                                    style: const TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 12,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        textField1 = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: "Enter Title",
                                      hintStyle: TextStyle(
                                        color: Color(0x4DFFFFFF)
,
                                        fontSize: 12,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tournament Overview
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: const Text(
                                  "Tournament Overview",
                                  style: TextStyle(
                                     color: Color(0xCCFFFFFF),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0x12FFFFFF),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0x26100613),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 46, left: 12),
                                      child: const Text(
                                        "Enter Overview",
                                        style: TextStyle(
                                          color: Color(0x4DFFFFFF),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            margin: const EdgeInsets.only(right: 3),
                                            width: 12,
                                            height: 12,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(6),
                                            child: SvgPicture.asset(
  "assets/images/tournament/clans/square-arrow-expand.svg",
  fit: BoxFit.fill,
), 
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Tournament Type Selection
                  Container(
  width: double.infinity,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isOnlineSelected = true;
              isLocalSelected = false;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            width: double.infinity,
            child: Row(
              children: [
              Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: const Color(0x1AFFFFFF),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(100),
    color: const Color(0x03FFFFFF),
  ),
  margin: const EdgeInsets.only(right: 8),
  width: 20,
  height: 20,
  child: isOnlineSelected
      ? Container(
          margin: const EdgeInsets.all(2.7), // Adjust for 16px container
          decoration: BoxDecoration(
            color: const Color(0xFF149520),
            border: Border.all(
              color: const Color(0xFF1FD031),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        )
      : const SizedBox(),
),
                const Expanded(
                  child: Text(
                    "Online Tournament",
                    style: TextStyle(
                      color: Color(0xE6FFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isOnlineSelected = false;
              isLocalSelected = true;
            });
          },
          child: Container(
            width: double.infinity,
            child: Row(
              children: [
                Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: const Color(0x1AFFFFFF),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(100),
    color: const Color(0x03FFFFFF),
  ),
  margin: const EdgeInsets.only(right: 8),
  width: 20,
  height: 20,
  child: isLocalSelected
      ? Container(
          margin: const EdgeInsets.all(2.7), // Adjust for 16px container
          decoration: BoxDecoration(
            color: const Color(0xFF149520),
            border: Border.all(
              color: const Color(0xFF1FD031),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        )
      : const SizedBox(),
),
                const Expanded(
                  child: Text(
                    "Local Tournament",
                    style: TextStyle(
                      color: Color(0xE6FFFFFF),
                      fontSize: 14,
                       fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
),
                  ],
                ),
              ],
            ),
          ),
          // Game Details Section
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "Game Details",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const Text(
                        "Select Game",
                        style: TextStyle(
                          color: Color(0xCCFFFFFF),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('Select Game Pressed');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0x1CFFFFFF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0x26100613),
                        ),
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Select Game",
                                style: TextStyle(
                                  color: Color(0xB3FFFFFF),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                             child: SvgPicture.asset(
  "assets/images/tournament/clans/arrow-down.svg",
  fit: BoxFit.fill,
), 
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2Content() {
    return Container(
      margin: const EdgeInsets.only( bottom: 216, left: 13, right: 13),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tournament Type Section
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "Tournament Type",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Solo/Squad Selection
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSoloSelected = true;
                                isSquadSelected = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(right: 2),
                              margin: const EdgeInsets.only(right: 24),
                              child: Row(
                                children: [
Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: const Color(0x1AFFFFFF),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(100),
    color: const Color(0x03FFFFFF),
  ),
  margin: const EdgeInsets.only(right: 12),
  width: 20,
  height: 20,
  child: isSoloSelected // or isSquadSelected, isFreeSelected, isPaidSelected
      ? Container(
          margin: const EdgeInsets.all(3.2),
          decoration: BoxDecoration(
            color: const Color(0xFF149520),
            border: Border.all(
              color: const Color(0xFF1FD031),
              width: 2.4,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        )
      : const SizedBox(),
),
                                  const Text(
                                    "Solo",
                                    style: TextStyle(
                                      color: Color(0xE6FFFFFF),
                                      fontSize: 14,
                                       fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSoloSelected = false;
                                  isSquadSelected = true;
                                });
                              },
                              child: Row(
                                children: [
Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: const Color(0x1AFFFFFF),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(100),
    color: const Color(0x03FFFFFF),
  ),
  margin: const EdgeInsets.only(right: 12),
  width: 20,
  height: 20,
  child: isSquadSelected // or isSquadSelected, isFreeSelected, isPaidSelected
      ? Container(
          margin: const EdgeInsets.all(3.2),
          decoration: BoxDecoration(
            color: const Color(0xFF149520),
            border: Border.all(
              color: const Color(0xFF1FD031),
              width: 2.4,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        )
      : const SizedBox(),
),
                                  const Text(
                                    "Squad",
                                    style: TextStyle(
                                          color: Color(0xE6FFFFFF),
                                      fontSize: 14,
                                       fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Total Teams
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: const Text(
                              "Total Teams",
                              style: TextStyle(
                                color: Color(0xCCFFFFFF),
                                fontSize: 10,
                                 fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0x12FFFFFF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0x26100613),
                            ),
                            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 14, right: 3),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  width: 16,
                                  height: 16,
                                child: SvgPicture.asset(
  "assets/images/tournament/clans/user-group.svg",
  fit: BoxFit.fill,
   color: Color(0xFF7EFFEC),
),  

                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: TextField(
                                      style: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 14,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          textField2 = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Enter Total Number of Team",
                                        hintStyle: TextStyle(
                                          color: Color(0x4DFFFFFF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Members Per Team
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: const Text(
                              "Member Per Team",
                              style: TextStyle(
                                 color: Color(0xCCFFFFFF),
                                fontSize: 10,
                                 fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0x12FFFFFF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0x26100613),
                            ),
                            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 14, right: 14),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  width: 16,
                                  height: 16,
                                 child: SvgPicture.asset(
  "assets/images/tournament/clans/user-group.svg",
  fit: BoxFit.fill,
   color: Color(0xFF7EFFEC),
),  
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: TextField(
                                      style: const TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 14,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          textField3 = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        hintText: "Enter Number of Members Per Team",
                                        hintStyle: TextStyle(
                                          color: Color(0x4DFFFFFF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tournament Format Section
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "Tournament Format",
                    style: TextStyle(
                    color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: const Text(
                        "Select Format",
                        style: TextStyle(
                            color: Color(0xCCFFFFFF),
                                fontSize: 10,
                                 fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('Select Format Pressed');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0x1CFFFFFF),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0x26100613),
                        ),
                        padding: const EdgeInsets.only(top: 11, bottom: 11, left: 14, right: 14),
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Select Game",
                                style: TextStyle(
                                  color: Color(0xB3FFFFFF),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                             child: SvgPicture.asset(
  "assets/images/tournament/clans/arrow-down.svg",
  fit: BoxFit.fill,
),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Entry Fees Section
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: const Text(
                          "Entry Fees",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFreeSelected = true;
                                isPaidSelected = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(right: 3),
                              margin: const EdgeInsets.only(right: 24),
                              child: Row(
                                children: [
Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: const Color(0x1AFFFFFF),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(100),
    color: const Color(0x03FFFFFF),
  ),
  margin: const EdgeInsets.only(right: 12),
  width: 20,
  height: 20,
  child: isFreeSelected // or isSquadSelected, isFreeSelected, isPaidSelected
      ? Container(
          margin: const EdgeInsets.all(3.2),
          decoration: BoxDecoration(
            color: const Color(0xFF149520),
            border: Border.all(
              color: const Color(0xFF1FD031),
              width: 2.4,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        )
      : const SizedBox(),
),
                                  const Text(
                                    "Free",
                                    style: TextStyle(
                                      color: Color(0xE6FFFFFF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFreeSelected = false;
                                  isPaidSelected = true;
                                });
                              },
                              child: Row(
                                children: [
Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: const Color(0x1AFFFFFF),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(100),
    color: const Color(0x03FFFFFF),
  ),
  margin: const EdgeInsets.only(right: 12),
  width: 20,
  height: 20,
  child: isPaidSelected // or isSquadSelected, isFreeSelected, isPaidSelected
      ? Container(
          margin: const EdgeInsets.all(3.2),
          decoration: BoxDecoration(
            color: const Color(0xFF149520),
            border: Border.all(
              color: const Color(0xFF1FD031),
              width: 2.4,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        )
      : const SizedBox(),
),
                                  const Text(
                                    "Paid",
                                    style: TextStyle(
                                      color: Color(0xE6FFFFFF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Info Message
                Row(
                  children: [
                  GestureDetector(
  onTap: () {
    setState(() {
      isChecked = !isChecked; // Toggle the state
    });
  },
  child: Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: isChecked 
          ? const Color(0xFF4EDC5C) // Green when checked
          : Colors.transparent,     // Transparent when unchecked
      border: Border.all(
        color: const Color(0x40FFFFFF),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(4),
    ),
    margin: const EdgeInsets.only(right: 12),
    child: isChecked
        ? Center(
            child: Icon(
              Icons.check,
              size: 12,
              color: const Color(0xFF141B34),
              weight: 2.0,
            ),
          )
        : null, // No icon when unchecked
  ),
),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked; // Toggle the state
                          });
                        },
                        child: const Text(
                          "Every team members needs to pay entry fee",
                          style: TextStyle(
                            color: Color(0xCCFFFFFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
               
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildStep3Content() {
  return Container(
    margin: const EdgeInsets.only(bottom: 196, left: 16, right: 16),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thumbnail Section
        Container(
          margin: const EdgeInsets.only(bottom: 42),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "Thumbnail",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      print('Thumbnail Upload Pressed');
                    },
                    child: DashedBorderContainer(
                      borderColor: const Color(0x807EFFEC),
                      borderRadius: BorderRadius.circular(4),
                      dashWidth: 4.0,
                      dashSpace: 4.0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color(0x0D7EFFEB),
                          ),
                          padding: const EdgeInsets.only(top: 28, bottom: 28, left: 18, right: 18),
                          child: Container(
                            width: 16,
                            height: 16,
                          child: SvgPicture.asset(
  "assets/images/tournament/clans/image-02.svg",
  fit: BoxFit.fill,
),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                child: const Text(
                                  "Upload Thumbnail",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Text(
                                "*Recommended Size 180px X 240px",
                                style: TextStyle(
                                  color: Color(0x80FFFFFF),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('Upload Thumbnail Pressed');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0x661FD031),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0x0D1FD031),
                            ),
                            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  width: 16,
                                  height: 16,
                                  child: SvgPicture.asset(
  "assets/images/tournament/clans/upload.svg",
  fit: BoxFit.fill,
),  

                                ),
                                const Text(
                                  "Upload",
                                  style: TextStyle(
                                    color: Color(0xFF1FD030),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Cover Image Section
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text(
                  "Cover Image",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      print('Cover Image Upload Pressed');
                    },
                    child: DashedBorderContainer(
                      borderColor: const Color(0x807EFFEC),
                      borderRadius: BorderRadius.circular(4),
                      dashWidth: 4.0,
                      dashSpace: 4.0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color(0x0D7EFFEB),
                          ),
                          padding: const EdgeInsets.only(top: 28, bottom: 28, left: 66, right: 66),
                          child: Container(
                            width: 16,
                            height: 16,
                           child: SvgPicture.asset(
  "assets/images/tournament/tournament/upload-02.svg",
  fit: BoxFit.fill,
),  

                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                child: const Text(
                                  "Upload Cover Image",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Text(
                                "*Recommended Size 624px X 320px",
                                style: TextStyle(
                                  color: Color(0x80FFFFFF),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('Upload Cover Image Pressed');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0x661FD031),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0x0D1FD031),
                            ),
                            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  width: 16,
                                  height: 16,
                                  child: SvgPicture.asset(
  "assets/images/tournament/tournament/upload.svg",
  fit: BoxFit.fill,
),  
                                ),
                                const Text(
                                  "Upload",
                                  style: TextStyle(
                                    color: Color(0xFF1FD030),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildStep4Content() {
    return Container(
      margin: const EdgeInsets.only( bottom: 257, left: 16, right: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: const Text(
              "Rewards",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Winning Team
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    "Winning Team",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: const Text(
                                "Cash Reward",
                                style: TextStyle(
                                  color: Color(0xCCFFFFFF),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x12FFFFFF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x26100613),
                              ),
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 3),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 16,
                                    height: 16,
                                    child: SvgPicture.asset(
  "assets/images/tournament/tournament/dollar-circle.svg",
  fit: BoxFit.fill,
)
                                  ),
                                  const Text(
                                    "Enter Reward",
                                    style: TextStyle(
                                      color: Color(0x4DFFFFFF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: const Text(
                                "XP",
                                style: TextStyle(
                                  color: Color(0xCCFFFFFF),

                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x12FFFFFF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x26100613),
                              ),
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 2),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
  "assets/images/tournament/tournament/XP.svg",
  fit: BoxFit.fill,
),  
  margin: const EdgeInsets.only(right: 8),
                                    width: 16,
                                    height: 10,
                                 
                                  ),
                                  const Text(
                                    "Enter Reward",
                                    style: TextStyle(
                                      color: Color(0x4DFFFFFF),

                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Runner Up Team
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    "Runner Up Team",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: const Text(
                                "Cash Reward",
                                style: TextStyle(
                                  color: Color(0xCCFFFFFF),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x12FFFFFF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x26100613),
                              ),
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 3),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 16,
                                    height: 16,
                                    child: SvgPicture.asset(
  "assets/images/tournament/tournament/dollar-circle.svg",
  fit: BoxFit.fill,
),
                                  ),
                                  const Text(
                                    "Enter Reward",
                                    style: TextStyle(
                                      color: Color(0x4DFFFFFF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: const Text(
                                "XP",
                                style: TextStyle(
                                  color: Color(0xCCFFFFFF),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x12FFFFFF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x26100613),
                              ),
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 2),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                     child: SvgPicture.asset(
  "assets/images/tournament/tournament/XP.svg",
  fit: BoxFit.fill,
),  
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 16,
                                    height: 10,
                                  ),
                                  const Text(
                                    "Enter Reward",
                                    style: TextStyle(
                                      color: Color(0x4DFFFFFF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 3rd Team
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    "3rd Team",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: const Text(
                                "Cash Reward",
                                style: TextStyle(
                                  color: Color(0xCCFFFFFF),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x12FFFFFF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x26100613),
                              ),
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 3),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 16,
                                    height: 16,
                                   child: SvgPicture.asset(
  "assets/images/tournament/tournament/dollar-circle.svg",
  fit: BoxFit.fill,
)
                                  ),
                                  const Text(
                                    "Enter Reward",
                                    style: TextStyle(
                                      color: Color(0x4DFFFFFF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: const Text(
                                "XP",
                                style: TextStyle(
                                  color: Color(0xCCFFFFFF),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x12FFFFFF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x26100613),
                              ),
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 2),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                     child: SvgPicture.asset(
  "assets/images/tournament/tournament/XP.svg",
  fit: BoxFit.fill,
),  
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 16,
                                    height: 10,
                                  ),
                                  const Text(
                                    "Enter Reward",
                                    style: TextStyle(
                                      color: Color(0x4DFFFFFF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Other Participating Teams
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    "Other Participating Teams",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: const Text(
                                "Cash Reward",
                                style: TextStyle(
                                  color: Color(0xCCFFFFFF),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x12FFFFFF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x26100613),
                              ),
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 3),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 16,
                                    height: 16,
                                   child: SvgPicture.asset(
  "assets/images/tournament/tournament/dollar-circle.svg",
  fit: BoxFit.fill,
)
                                  ),
                                  const Text(
                                    "Enter Reward",
                                    style: TextStyle(
                                      color: Color(0x4DFFFFFF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: const Text(
                                "XP",
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x12FFFFFF),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x26100613),
                              ),
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 2),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    child: SvgPicture.asset(
  "assets/images/tournament/tournament/XP.svg",
  fit: BoxFit.fill,
),  
                                    margin: const EdgeInsets.only(right: 8),
                                    width: 16,
                                    height: 10,
                                  ),
                                  const Text(
                                    "Enter Reward",
                                    style: TextStyle(
                                      color: Color(0x4DFFFFFF),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep5Content() {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Diamond Sponsor Section
            Container(
              margin: const EdgeInsets.only( bottom: 12, left: 13),
              child: const Text(
                "Diamond Sponsor",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 32, left: 13),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      print('Diamond Sponsor Upload Pressed');
                    },
                    child:
                   DashedBorderContainer(
  borderColor: const Color(0x807EFFEC),
  strokeWidth: 1.0,
  dashWidth: 4.0,
  dashSpace: 5.0,
  borderRadius: BorderRadius.circular(6),
  child: Container(
    padding: const EdgeInsets.all(5),
    
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0x0D7EFFEB),
      ),
      padding: const EdgeInsets.all(23),
      child: Container(
        width: 24,
        height: 24,
        child: SvgPicture.asset(
          "assets/images/tournament/clans/image-02.svg",
          fit: BoxFit.fill,
        )
      ),
    ),
  ),
),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        
                    margin: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "Upload Sponsors Logo",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15 , bottom: 12),
                        child: const Text(
                          "*Recommended Size 100px X 100px",
                          style: TextStyle(
                            color: Color(0x80FFFFFF),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print('Upload Diamond Sponsor Pressed');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0x661FD031),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0x0D1FD031),
                          ),
                          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 6),
                                width: 14,
                                height: 14,
                                child: SvgPicture.asset(
  "assets/images/tournament/clans/upload.svg",
  fit: BoxFit.fill,
),
                              ),
                              const Text(
                                "Upload",
                                style: TextStyle(
                                  color: Color(0xFF1FD030),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Other Participating Sponsors Section
            Container(
              margin: const EdgeInsets.only(bottom: 380, left: 13, right: 13),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               Container(
  margin: const EdgeInsets.only(bottom: 20),
  width: double.infinity,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: const Text(
          "Other Participating Sponsors",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // First Row of Sponsors
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        print('Sponsor 1 Upload Pressed');
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 6),
                        child: DashedBorderContainer(
                          borderColor: const Color(0x337EFFEC),
                          strokeWidth: 1.0,
                          dashWidth: 5.0,
                          dashSpace: 5.0,
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: const Color(0x0D7EFFEB),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                width: 14,
                                height: 14,
                                child: SvgPicture.asset(
                                  "assets/images/tournament/clans/image-02.svg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 11),
                            child: const Text(
                              "Sponsor 1",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print('Upload Sponsor 1 Pressed');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x661FD031),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x0D1FD031),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: 16,
                                height: 16,
                                child: SvgPicture.asset(
                                  "assets/images/tournament/clans/upload.svg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sponsor 2
            InkWell(
              onTap: () {
                print('Sponsor 2 Upload Pressed');
              },
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                child: DashedBorderContainer(
                  borderColor: const Color(0x337EFFEC),
                  strokeWidth: 1.0,
                  dashWidth: 5.0,
                  dashSpace: 5.0,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color(0x0D7EFFEB),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: 14,
                        height: 14,
                        child: SvgPicture.asset(
                          "assets/images/tournament/clans/image-02.svg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Text(
                "Sponsor 2",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 14,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('Upload Sponsor 2 Pressed');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0x661FD031),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0x0D1FD031),
                ),
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 16,
                  height: 16,
                  child: SvgPicture.asset(
                    "assets/images/tournament/clans/upload.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Second Row of Sponsors
      Container(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        print('Sponsor 3 Upload Pressed');
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 6),
                        child: DashedBorderContainer(
                          borderColor: const Color(0x337EFFEC),
                          strokeWidth: 1.0,
                          dashWidth: 5.0,
                          dashSpace: 5.0,
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: const Color(0x0D7EFFEB),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                width: 14,
                                height: 14,
                                child: SvgPicture.asset(
                                  "assets/images/tournament/clans/image-02.svg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 11),
                            child: const Text(
                              "Sponsor 3",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print('Upload Sponsor 3 Pressed');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x661FD031),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0x0D1FD031),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                width: 16,
                                height: 16,
                                child: SvgPicture.asset(
                                  "assets/images/tournament/clans/upload.svg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sponsor 4
            InkWell(
              onTap: () {
                print('Sponsor 4 Upload Pressed');
              },
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                child: DashedBorderContainer(
                  borderColor: const Color(0x337EFFEC),
                  strokeWidth: 1.0,
                  dashWidth: 5.0,
                  dashSpace: 5.0,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color(0x0D7EFFEB),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: 14,
                        height: 14,
                        child: SvgPicture.asset(
                          "assets/images/tournament/clans/image-02.svg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Text(
                "Sponsor 4",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 14,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print('Upload Sponsor 4 Pressed');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0x661FD031),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0x0D1FD031),
                ),
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 16,
                  height: 16,
                  child: SvgPicture.asset(
                    "assets/images/tournament/clans/upload.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
                 
                  InkWell(
                    onTap: () {
                      print('Add 1 More Sponsor Pressed');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0x338EC9ED),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(1000),
                        color: const Color(0x268EC9ED),
                      ),
                      padding: const EdgeInsets.all(7),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 7),
                            width: 16,
                            height: 16,
                           child: SvgPicture.asset(
  "assets/images/tournament/tournament/add-circle.svg",
  fit: BoxFit.fill,
),
                          ),
                          const Text(
                            "Add 1 More",
                            style: TextStyle(
                              color: Color.fromARGB(255, 142, 200, 237),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}

Widget _buildStep6Content() {
  return Container(
    margin: const EdgeInsets.only( bottom: 198, left: 16, right: 16),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Registration Time Section
          Container(
          margin: const EdgeInsets.only(bottom: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: const Text(
                  "Registration Time",
                  style: TextStyle(
                    color: Color(0xFFB1FFAD),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Registration Starts On
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Starts On",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date Field
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        "Date",
                                        style: TextStyle(
                                          color: Color(0xCCFFFFFF),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0x12FFFFFF),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0x26100613),
                                      ),
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 14, right: 14),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 10),
                                            width: 16,
                                            height: 16,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/calendar-03.svg",
  fit: BoxFit.fill,
), 
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 2),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "DD",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "/",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 5),
                                                  child: const Text(
                                                    "MM",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "/",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                const Text(
                                                  "YYYY",
                                                  style: TextStyle(
                                                    color: Color(0x80FFFFFF)
,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Time Field
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        "Time",
                                        style: TextStyle(
                                          color: Color(0xCCFFFFFF),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0x12FFFFFF),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0x26100613),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 15),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 9),
                                                  width: 16,
                                                  height: 16,
                                                  child: SvgPicture.asset(
  "assets/images/tournament/tournament/clock-01.svg",
  fit: BoxFit.fill,
), 
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(right: 2),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 5),
                                                        child: const Text(
                                                          "HH",
                                                          style: TextStyle(
                                                            color: Color(0x80FFFFFF),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 4),
                                                        child: const Text(
                                                          "/",
                                                          style: TextStyle(
                                                            color: Color(0x80FFFFFF)
,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "MM",
                                                        style: TextStyle(
                                                          color: Color(0x80FFFFFF)
,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 2),
                                            width: 14,
                                            height: 14,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/arrow-left-01.svg",
  fit: BoxFit.fill,
),  

                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 5),
                                            child: const Text(
                                              "PM",
                                              style: TextStyle(
                                                color: Color(0x80FFFFFF)
,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 14,
                                            height: 14,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/arrow-right-01.svg",
  fit: BoxFit.fill,
),  

                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Registration Ends On
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Ends On",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date Field
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        "Date",
                                        style: TextStyle(
                                          color: Color(0xCCFFFFFF)
,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0x12FFFFFF),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0x26100613),
                                      ),
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 14, right: 14),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 10),
                                            width: 16,
                                            height: 16,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/calendar-03.svg",
  fit: BoxFit.fill,
), 
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 2),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "DD",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "/",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 5),
                                                  child: const Text(
                                                    "MM",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "/",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                const Text(
                                                  "YYYY",
                                                  style: TextStyle(
                                                    color: Color(0x80FFFFFF)
,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Time Field
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        "Time",
                                        style: TextStyle(
                                          color: Color(0xCCFFFFFF)
,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0x12FFFFFF),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0x26100613),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 15),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 9),
                                                  width: 16,
                                                  height: 16,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/clock-01.svg",
  fit: BoxFit.fill,
), 
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(right: 2),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 5),
                                                        child: const Text(
                                                          "HH",
                                                          style: TextStyle(
                                                            color: Color(0x80FFFFFF)
,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 4),
                                                        child: const Text(
                                                          "/",
                                                          style: TextStyle(
                                                            color: Color(0x80FFFFFF)
,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "MM",
                                                        style: TextStyle(
                                                          color: Color(0x80FFFFFF)
,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 2),
                                            width: 14,
                                            height: 14,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/arrow-left-01.svg",
  fit: BoxFit.fill,
),  
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 5),
                                            child: const Text(
                                              "PM",
                                              style: TextStyle(
                                                color: Color(0x80FFFFFF)
,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 14,
                                            height: 14,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/arrow-right-01.svg",
  fit: BoxFit.fill,
),  
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Tournament Time Section
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: const Text(
                  "Tournament Time",
                  style: TextStyle(
                    color: Color(0xFFB1FFAD),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Registration Starts On
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Starts On",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date Field
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        "Date",
                                        style: TextStyle(
                                          color: Color(0xCCFFFFFF),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0x12FFFFFF),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0x26100613),
                                      ),
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 14, right: 14),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 10),
                                            width: 16,
                                            height: 16,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/calendar-03.svg",
  fit: BoxFit.fill,
), 
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 2),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "DD",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "/",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 5),
                                                  child: const Text(
                                                    "MM",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "/",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                const Text(
                                                  "YYYY",
                                                  style: TextStyle(
                                                    color: Color(0x80FFFFFF)
,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Time Field
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        "Time",
                                        style: TextStyle(
                                          color: Color(0xCCFFFFFF),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0x12FFFFFF),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0x26100613),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 15),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 9),
                                                  width: 16,
                                                  height: 16,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/clock-01.svg",
  fit: BoxFit.fill,
), 
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(right: 2),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 5),
                                                        child: const Text(
                                                          "HH",
                                                          style: TextStyle(
                                                            color: Color(0x80FFFFFF)
,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 4),
                                                        child: const Text(
                                                          "/",
                                                          style: TextStyle(
                                                            color: Color(0x80FFFFFF)
,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "MM",
                                                        style: TextStyle(
                                                          color: Color(0x80FFFFFF)
,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 2),
                                            width: 14,
                                            height: 14,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/arrow-left-01.svg",
  fit: BoxFit.fill,
), 
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 5),
                                            child: const Text(
                                              "PM",
                                              style: TextStyle(
                                                color: Color(0x80FFFFFF)
,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 14,
                                            height: 14,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/arrow-right-01.svg",
  fit: BoxFit.fill,
), 
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Registration Ends On
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: const Text(
                            "Ends On",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date Field
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        "Date",
                                        style: TextStyle(
                                          color: Color(0xCCFFFFFF),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0x12FFFFFF),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0x26100613),
                                      ),
                                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 14, right: 14),
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 10),
                                            width: 16,
                                            height: 16,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/calendar-03.svg",
  fit: BoxFit.fill,
), 
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 2),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "DD",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "/",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 5),
                                                  child: const Text(
                                                    "MM",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 4),
                                                  child: const Text(
                                                    "/",
                                                    style: TextStyle(
                                                      color: Color(0x80FFFFFF)
,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                const Text(
                                                  "YYYY",
                                                  style: TextStyle(
                                                    color: Color(0x80FFFFFF)
,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Time Field
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: const Text(
                                        "Time",
                                        style: TextStyle(
                                          color: Color(0xCCFFFFFF),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0x12FFFFFF),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0x26100613),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 15),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(right: 9),
                                                  width: 16,
                                                  height: 16,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/clock-01.svg",
  fit: BoxFit.fill,
), 
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(right: 2),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 5),
                                                        child: const Text(
                                                          "HH",
                                                          style: TextStyle(
                                                            color: Color(0x80FFFFFF)
,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 4),
                                                        child: const Text(
                                                          "/",
                                                          style: TextStyle(
                                                            color: Color(0x80FFFFFF)
,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      const Text(
                                                        "MM",
                                                        style: TextStyle(
                                                          color: Color(0x80FFFFFF)
,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 2),
                                            width: 14,
                                            height: 14,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/arrow-left-01.svg",
  fit: BoxFit.fill,
),  

                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(right: 5),
                                            child: const Text(
                                              "PM",
                                              style: TextStyle(
                                                color: Color(0x80FFFFFF)
,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 14,
                                            height: 14,
                                          child: SvgPicture.asset(
  "assets/images/tournament/tournament/arrow-right-01.svg",
  fit: BoxFit.fill,
),  
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

void _showSuccessModal(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents dismissing by tapping outside
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF1C121F),
          ),
          padding: const EdgeInsets.only(top: 70, bottom: 70, left: 21, right: 21),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                width: 110,
                height: 110,
               child: Image.asset(                                                     
  "assets/images/tournament/clans/clan_created_success.png",
	fit: BoxFit.fill,
),

              ),
              Container(
                margin: const EdgeInsets.only(bottom: 1),
                width: double.infinity,
                child: const Text(
                  "Tournament Created\nSuccessfully!",
                  style: TextStyle(
                    color: Color(0xE6FFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}