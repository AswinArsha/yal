import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/solid_button.dart';

class MysteryDialogContent extends StatefulWidget {
  const MysteryDialogContent({super.key});

  @override
  MysteryDialogContentState createState() => MysteryDialogContentState();
}

class MysteryDialogContentState extends State<MysteryDialogContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late VideoPlayerController _videoController;
  final String rewardCode = "HILIO75543BF";
  bool _showText = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();

    // Initialize video controller
    _videoController =
        VideoPlayerController.asset('assets/videos/mystery_box.mp4');
    _initializeVideo();
  }

  void _initializeVideo() async {
    await _videoController.initialize();
    _videoController.play();

    // Show text after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showText = true;
        });
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: rewardCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Code copied to clipboard")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Video container
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      // Video player
                      if (_videoController.value.isInitialized)
                        SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController.value.size.width,
                              height: _videoController.value.size.height,
                              child: VideoPlayer(_videoController),
                            ),
                          ),
                        ),
// Dark overlay when _showText is true
if (_showText)
  Positioned.fill(
    child: Container(
      color: Colors.black.withOpacity(0.5), // You can tweak opacity
    ),
  ),

                      // Text overlay (appears after 2 seconds)
                      if (_showText)
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FadeInDown(
                            duration: const Duration(milliseconds: 800),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SlideInUp(
                                  duration: const Duration(milliseconds: 600),
                                  child: Text(
                                    "Congratulations! You Got",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          AppColors.baseWhite.withOpacity(0.9),
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ZoomIn(
                                  duration: const Duration(milliseconds: 800),
                                  delay: const Duration(milliseconds: 200),
                                  child: Text(
                                    "1000",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: TextStyle(
                                        fontSize: 60.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(
                                            255, 245, 158, 1),
                                        shadows: [
                                          Shadow(
                                            offset: const Offset(0, 4),
                                            blurRadius: 8,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SlideInUp(
                                  duration: const Duration(milliseconds: 600),
                                  delay: const Duration(milliseconds: 400),
                                  child: Text(
                                    "FF Diamonds",
                                    style: GoogleFonts.lilitaOne(
                                      textStyle: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(
                                            255, 245, 158, 1),
                                        shadows: [
                                          Shadow(
                                            offset: const Offset(0, 2),
                                            blurRadius: 4,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                FadeInUp(
                                  duration: const Duration(milliseconds: 600),
                                  delay: const Duration(milliseconds: 600),
                                  child: GestureDetector(
                                    onTap: _copyCode,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            67, 65, 47, 0.9),
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.3)),
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            rewardCode,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                fontSize: 18.sp,
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 0.9),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Image.asset(
                                            'assets/icons/copy.png',
                                            height: 16,
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
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Below video
            FadeIn(
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: AppColors.baseWhite.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(100)),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Available Box: ',
                        style: AppTextStyles.medium(
                          size: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.baseWhite.withOpacity(0.7),
                        ),
                      ),
                      TextSpan(
                        text: '12',
                        style: AppTextStyles.medium(
                          size: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Open again button
           ZoomIn(
  duration: const Duration(milliseconds: 500),
  child: SizedBox(
    width: double.infinity,
    child: SolidButton(
      height: 48.h, // Enough to accommodate 10dp vertical padding
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      borderRadius: 6,
      onPressed: () {},
      label: 'Open Again',
      buttonColor: AppColors.secondary,
    ),
  ),
),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
