import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateClanScreen extends StatefulWidget {
  const CreateClanScreen({super.key});

  @override
  State<CreateClanScreen> createState() => _CreateClanScreenState();
}

class _CreateClanScreenState extends State<CreateClanScreen> {
  final TextEditingController _clanNameController = TextEditingController();
  final TextEditingController _clanTagController = TextEditingController();
  final TextEditingController _clanOverviewController = TextEditingController();
  String? _selectedClanType;
  bool _isFormValid = false;

  final List<String> _clanTypes = [
    'Competitive',
    'Casual',
    'Professional',
    'Community',
    'Training',
  ];

  @override
  void initState() {
    super.initState();
    _clanNameController.addListener(_validateForm);
    _clanTagController.addListener(_validateForm);
    _clanOverviewController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _clanNameController.text.isNotEmpty ||
                    _clanTagController.text.isNotEmpty ||
                    _clanOverviewController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _clanNameController.dispose();
    _clanTagController.dispose();
    _clanOverviewController.dispose();
    super.dispose();
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    String? maxInfo,
    String? iconUrl,
    bool isDropdown = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Container(
          margin: EdgeInsets.only(bottom: 8.h),
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: 10.sp,
            ),
          ),
        ),
        
        // Input Field with original styling from first code
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0x12FFFFFF),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6.r),
            color: const Color(0x26100613),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 8.h),
          width: double.infinity,
          child: isDropdown ? 
            // Dropdown styling
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (iconUrl != null)
                      Container(
                        margin: EdgeInsets.only(right: 8.w),
                        width: 16.w,
                        height: 16.w,
                        child: SvgPicture.asset(
                          iconUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    Text(
                      hintText ?? '',
                      style: TextStyle(
                        color: const Color(0x4DFFFFFF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  width: 14.w,
                  height: 14.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                   child: SvgPicture.asset(
  "assets/images/tournament/clans/arrow-down.svg",
  fit: BoxFit.fill,
),

                  ),
                ),
              ],
            ) :
            maxLines > 1 ? 
              // Multi-line input (Clan Overview)
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (iconUrl != null)
                              Container(
                                margin: EdgeInsets.only(right: 8.w, bottom: 30.h),
                                width: 16.w,
                                height: 16.w,
                                child: SvgPicture.asset(
                                  iconUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            Expanded(
                              child: TextFormField(
                                controller: controller,
                                maxLines: null,
                                minLines: 3,
                                style: TextStyle(
                                  color: Color(0x4DFFFFFF)
,
                                  fontSize: 12.sp,
                                ),
                                decoration: InputDecoration(
                                  hintText: hintText,
                                  hintStyle: TextStyle(
                                    color: Color(0x4DFFFFFF)
,
                                    fontSize: 12.sp,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (maxInfo != null)
                        Text(
                          maxInfo,
                          style: TextStyle(
                            color: const Color(0x80FFFFFF),
                            fontSize: 12.sp,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 46.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        margin: EdgeInsets.only(right: 3.w),
                        width: 12.w,
                        height: 12.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                        child: SvgPicture.asset(
  "assets/images/tournament/clans/square-arrow-expand.svg",
  fit: BoxFit.fill,
),

                        ),
                      ),
                    ],
                  ),
                ],
              ) :
              // Single line input
              Row(
                mainAxisAlignment: maxInfo != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (iconUrl != null)
                          Container(
                            margin: EdgeInsets.only(right: 8.w),
                            width: 16.w,
                            height: 16.w,
                            child: SvgPicture.asset(
                              iconUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        Expanded(
                          child: TextFormField(
  controller: controller,
  style: TextStyle(
    color: const Color(0x4DFFFFFF),
    fontSize: 12.sp,
  ),
  decoration: InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: const Color(0x4DFFFFFF),
      fontSize: 12.sp,
    ),
    border: InputBorder.none,
   
    isDense: true,
  ),
),
                        ),
                      ],
                    ),
                  ),
                  if (maxInfo != null)
                    Text(
                      maxInfo,
                      style: TextStyle(
                        color: const Color(0x80FFFFFF),
                        fontSize: 12.sp,
                      ),
                    ),
                ],
              ),
        ),
      ],
    );
  }

  Widget _buildUploadSection({
    required String title,
    required String subtitle,
    required String iconUrl,
    required VoidCallback onTap,
    bool isBanner = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Upload Icon
            Container(
  margin: EdgeInsets.only(right: 16.w),
  width: 80.w,
  height: 80.w,
  decoration: BoxDecoration(
    border: DashedBorder.fromBorderSide(
      dashLength: 5, // Increased dash size
      side: BorderSide(
        color: Color(0xFF8CF9FF), // 8CF9FF color for dashed border
        width: 1,
      ),
    ),
    borderRadius: BorderRadius.circular(40.r), // Half of width/height for circular
    color: Color(0x1A8CF9FF), // 8CF9FF with 10% opacity background
  ),
  child: Center(
    child: SvgPicture.asset(
      iconUrl,
      width: 24.w, // Set icon size to 24x24
      height: 24.h,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(
        Color(0xFF8CF9FF), // Color the SVG icon
        BlendMode.srcIn,
      ),
    ),
  ),
),
            
            // Text Content and Upload Button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: const Color(0x80FFFFFF)
,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Upload Button
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0x661FD031),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6.r),
                        color: const Color(0x0D1FD031),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            margin: EdgeInsets.only(right: 6.w),
                            width: 14.w,
                            height: 14.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: SvgPicture.asset(
  "assets/images/tournament/clans/upload.svg",
  fit: BoxFit.fill,
),

                            ),
                          ),
                          Text(
                            "Upload",
                            style: TextStyle(
                              color: const Color(0xFF1FD030),
                              fontSize: 12.sp,
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
        
        if (isBanner) ...[
          SizedBox(height: 24.h),
          // Dashed border upload area for banner
          InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: DashedBorder.fromBorderSide(
                  dashLength: 15,
                  side: const BorderSide(
                    color: Color(0x807EFFEC),
                    width: 1,
                  ),
                ),
                borderRadius: BorderRadius.circular(6.r),
              ),
              padding: EdgeInsets.all(5.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: const Color(0x0D7EFFEB),
                ),
                width: 70.w,
                height: 70.w,
                child: const SizedBox(),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showSuccessModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: InkWell(
            onTap: () {
              print('Pressed');
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: const Color(0xFF1C121F),
              ),
              padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 70.h),
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 32.h),
                    width: 110.w,
                    height: 110.w,
                  child: Image.asset(
  "assets/images/tournament/clans/clan_created_success.png", 
    fit: BoxFit.fill,
),

                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Clan Created\nSuccessfully!",
                      style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C121F),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFFFFFF),
          child: Container(
            width: double.infinity,
            height: double.infinity,
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with back button and title
                        Container(
                          margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                          width: double.infinity,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    color: const Color(0x12FFFFFF),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                                  margin: EdgeInsets.only(right: 165.w),
                                  child: Container(
                                    width: 15.w,
                                    height: 12.w,
                                  child: SvgPicture.asset(
  "assets/images/tournament/clans/Arrow-Left.svg",
  fit: BoxFit.fill,
),

                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Creating My Clan",
                                  style: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Details Section
                        Container(
                          margin: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 12.h),
                                child: Text(
                                  "Details",
                                  style: TextStyle(
                                    color: const Color(0xFFFFFFFF),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                              // Clan Name
                              Container(
                                margin: EdgeInsets.only(bottom: 12.h),
                                child: _buildInputField(
                                  label: 'Clan Name',
                                  controller: _clanNameController,
                                  hintText: 'Enter Clan Name',
                                  iconUrl: "assets/images/tournament/clans/castle-02.svg",
                                
                                ),
                              ),
                              
                              // Clan Tag
                              Container(
                                margin: EdgeInsets.only(bottom: 12.h),
                                child: _buildInputField(
                                  label: 'Clan Tag',
                                  controller: _clanTagController,
                                  hintText: 'Enter Clan Tag',
                                  maxInfo: 'Max 5 Words',
                                  iconUrl: "assets/images/tournament/clans/all-bookmark.svg",
                                ),
                              ),
                              
                              // Clan Overview
                              Container(
                                margin: EdgeInsets.only(bottom: 12.h),
                                child: _buildInputField(
                                  label: 'Clan Overview',
                                  controller: _clanOverviewController,
                                  hintText: 'Enter Clan Overview',
                                  maxInfo: 'Max 200 Words',
                                  maxLines: 4,
                                  iconUrl: "assets/images/tournament/clans/text-align-justify-left.svg",
                                ),
                              ),
                              
                              // Clan Type
                              _buildInputField(
                                label: 'Clan Type',
                                controller: TextEditingController(),
                                hintText: 'Select Clan Type',
                                iconUrl: "assets/images/tournament/clans/settings-05.svg",
                                isDropdown: true,
                              ),
                            ],
                          ),
                        ),

                        // Images Section
                        Container(
                          margin: EdgeInsets.only(bottom: 20.h, left: 16.w),
                          child: Text(
                            "Images",
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Upload Clan Logo
                        Container(
                          margin: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
                          child: _buildUploadSection(
                            title: 'Upload Clan Logo',
                            subtitle: 'Max 5MB/ 400x400 px',
                            iconUrl: "assets/images/tournament/clans/image-upload-01.svg",
                            onTap: () {
                              print('Upload clan logo tapped');
                            },
                          ),
                        ),

                        // Upload Clan Banner with exact reference styling
                        Container(
                          margin: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
                          child: Row(
                            children: [
                              // Dashed border upload area with inner icon
                             InkWell(
  onTap: () {
    print('Upload clan banner tapped');
  },
  child: Container(
    decoration: BoxDecoration(
      border: DashedBorder.fromBorderSide(
        dashLength: 5, 
        side: const BorderSide(
          color: Color(0x807EFFEC),
          width: 1,
        ),
      ),
      borderRadius: BorderRadius.circular(6.r),
    ),
    padding: EdgeInsets.all(5.w),
    margin: EdgeInsets.only(right: 16.w),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: const Color(0x0D7EFFEB),
      ),
      padding: EdgeInsets.all(23.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
        ),
        width: 24.w,
        height: 24.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
         child: SvgPicture.asset(
  "assets/images/tournament/clans/image-02.svg",
  fit: BoxFit.fill,
),

        ),
      ),
    ),
  ),
),
                              // Text Content and Upload Button
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      child: Text(
                                        "Upload Clan Banner",
                                        style: TextStyle(
                                          color: const Color(0xFFFFFFFF),
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 12.h),
                                      child: Text(
                                        "Max 8MB/ 1760x180 px",
                                        style: TextStyle(
                                          color: const Color(0x80FFFFFF),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    // Upload Button
                                    InkWell(
                                      onTap: () {
                                        print('Upload clan banner tapped');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0x661FD031),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(6.r),
                                          color: const Color(0x0D1FD031),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6.r),
                                              ),
                                              margin: EdgeInsets.only(right: 6.w),
                                              width: 14.w,
                                              height: 14.w,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(6.r),
                                               child: SvgPicture.asset(
  "assets/images/tournament/clans/upload.svg",
  fit: BoxFit.fill,
),

                                              ),
                                            ),
                                            Text(
                                              "Upload",
                                              style: TextStyle(
                                                color: const Color(0xFF1FD030),
                                                fontSize: 12.sp,
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

                        // Bottom gradient section with buttons
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(1, -1),
                              end: Alignment(1, 1),
                              colors: [
                                Color(0x00100613),
                                Color(0xFF100613),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.only(top: 65.h),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bottom Buttons
                              Container(
                                margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Cancel Button
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => Navigator.of(context).pop(),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.r),
                                            color: const Color(0x12FFFFFF),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 11.h),
                                          margin: EdgeInsets.only(right: 14.w),
                                          width: double.infinity,
                                          child: Text(
                                            "Cancel",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: const Color(0xFFFFFFFF),
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                    // Next Button with active/inactive states
                                    Expanded(
                                      child: InkWell(
                                        onTap: _isFormValid ? () {
                                          _showSuccessModal(context);
                                        } : null,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.r),
                                            border: _isFormValid ? Border.all(
                                              color: const Color(0x26FFFFFF),
                                              width: 1,
                                            ) : null,
                                            gradient: _isFormValid ? const LinearGradient(
                                              begin: Alignment(1, -1),
                                              end: Alignment(1, 1),
                                              colors: [
                                                Color(0xFFFDEB56),
                                                Color(0xFFAA9E39),
                                              ],
                                            ) : null,
                                            color: _isFormValid ? null : const Color(0x05FFFFFF),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 11.h),
                                          width: double.infinity,
                                          child: Text(
                                            "Next",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: _isFormValid ? const Color(0xFF24210A) : const Color(0xFFFFFFFF),
                                              fontSize: 14.sp,
                                             fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Bottom indicator
                            
                            ],
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
    );
  }
}