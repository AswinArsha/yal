import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/constants/common_widgets/success_dialog.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/support_ticket/presentation/pages/support_chat_screen.dart';
import 'package:yalgamers/feature/support_ticket/presentation/widgets/submit_success_dialogue.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  CreateTicketScreenState createState() => CreateTicketScreenState();
}

class CreateTicketScreenState extends State<CreateTicketScreen> {
  final _formKey = GlobalKey<FormState>();

  String subject = '';
  String description = '';
  String fromWhen = '';
  int howManyTimes = 0;

  PlatformFile? selectedFile;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  Future<dynamic> ticketDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: AppColors.baseWhite.withOpacity(0.06), // dark background
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(28, 19, 31, 1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              // ✅ Add a visible border
              color: AppColors.baseWhite.withOpacity(0.1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            "Review Details",
            overflow: TextOverflow.visible,
            style: AppTextStyles.largeBold(
              size: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.baseWhite.withOpacity(0.9),
            ),
          ),
          content: SingleChildScrollView(
            // Add scroll for content overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // ✅ Prevent extra spacing
              children: [
                Text(
                  'Subject',
                  overflow: TextOverflow.visible,
                  style: AppTextStyles.medium(
                    size: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.baseWhite.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'My XP points are not adding.',
                  overflow: TextOverflow.visible,
                  style: AppTextStyles.medium(
                    size: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.baseWhite.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Description',
                  overflow: TextOverflow.visible,
                  style: AppTextStyles.medium(
                    size: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.baseWhite.withOpacity(0.3),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lorem ipsum dolor sit amet consectetur. Sed volutpat aliquam fusce sit id feugiat eget. Erat proin iaculis scelerisque diam aenean cursus integer at euismod. Auctor tempus adipiscing sociis erat tellus habitasse suscipit ut fames. Vehicula pulvinar mattis See more...',
                  overflow: TextOverflow.visible,
                  style: AppTextStyles.medium(
                    size: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.baseWhite.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 16), // ✅ Reduce from 20 to 16
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/icons/info.png'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'By submitting your issue, you can chat directly with our agents.',
                        style: AppTextStyles.small(
                          size: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.baseWhite.withOpacity(0.4),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20), // ✅ Controls gap before buttons
                PrimaryButton(
                  label: 'Submit',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SubmitSuccessDialog(
                        onGoToChat: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return SupportChatScreen();
                            },
                          ));
                        },
                        onBackToHome: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  gradient: buttonGradience(),
                  textColor: Colors.black,
                ),
                SizedBox(height: 12.h),
                PrimaryButton(
                  label: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
          'Creating a New Ticket',
          style: AppTextStyles.medium(
            fontWeight: FontWeight.w400,
            size: 12.sp,
            color: AppColors.baseWhite.withOpacity(0.4),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Create a New Ticket',
                  style: AppTextStyles.largeBold(
                    size: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.baseWhite.withOpacity(0.9),
                  ),
                ),
              ),
            ),
            Expanded(child: _buildCreateTicketForm()),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateTicketForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildInputField(label: 'Subject', onSaved: (v) => subject = v!),
          SizedBox(height: 12.h),
          _buildInputField(
              label: 'Description',
              maxLines: 6,
              onSaved: (v) => description = v!),
          SizedBox(height: 12.h),
          _buildInputField(label: 'From When', onSaved: (v) => fromWhen = v!),
          SizedBox(height: 12.h),
          _buildCounter(),
          const SizedBox(height: 10),
          const Divider(thickness: 0.1),
          const SizedBox(height: 10),
          Text(
            'Do you have any screenshot or video?',
            style: AppTextStyles.medium(
              fontWeight: FontWeight.w600,
              size: 16.sp,
              color: AppColors.baseWhite.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'If you have any screenshot proof of the issue you are having, then please upload it.',
            style: AppTextStyles.medium(
              fontWeight: FontWeight.w400,
              size: 12.sp,
              color: AppColors.baseWhite.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 15.h),
          GestureDetector(
            onTap: pickFile,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.baseWhite.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.upload_file, size: 18.h, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    selectedFile?.name ?? 'Upload',
                    style: AppTextStyles.small(
                      fontWeight: FontWeight.w500,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Image.asset('assets/icons/info.png'),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'By submitting your issue, you can \nchat directly with our agents.',
                  style: AppTextStyles.small(
                    size: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.baseWhite.withOpacity(0.4),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 50), // Padding for bottom buttons
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required FormFieldSetter<String> onSaved,
    int maxLines = 1,
  }) {
    return Container(
      height: maxLines == 1 ? 50.h : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Color(0xFF2C232F)),
      ),
      child: TextFormField(
        cursorHeight: 14,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFF150B18),
          label: RichText(
            text: TextSpan(
              text: label,
              style: AppTextStyles.medium(
                fontWeight: FontWeight.w400,
                size: 14.sp,
                color: AppColors.baseWhite.withOpacity(0.6),
              ),
              children: const [
                TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          border: InputBorder.none,
        ),
        style: AppTextStyles.small(color: Color(0xFF948798), size: 14),
        validator: (value) => value!.isEmpty ? 'Required' : null,
        onSaved: onSaved,
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildCounter() {
    return Container(
      height: 44.h,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.baseWhite.withOpacity(0.1)),
        color: AppColors.baseWhite.withOpacity(0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Text(
              'How Many Times',
              style: AppTextStyles.medium(
                fontWeight: FontWeight.w400,
                size: 14.sp,
                color: AppColors.baseWhite.withOpacity(0.6),
              ),
            ),
            const SizedBox(width: 2),
            const Text('*', style: TextStyle(color: Colors.red)),
          ]),
          Row(
            children: [
              InkWell(
                onTap: () => setState(() {
                  howManyTimes = (howManyTimes - 1).clamp(0, 999);
                }),
                child: Image.asset(
                    height: 28.h, width: 30.w, 'assets/icons/minus_white.png'),
              ),
              Container(
                height: 28.h,
                width: 28.w,
                color: AppColors.baseWhite.withOpacity(0.1),
                child: Center(
                  child: Text(
                    '$howManyTimes',
                    style: AppTextStyles.small(
                        size: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () => setState(() {
                  howManyTimes++;
                }),
                child: Image.asset(
                    height: 28.h, width: 28.w, 'assets/icons/add_white.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF170D1A),
        border: Border(
          top: BorderSide(color: AppColors.baseWhite.withOpacity(0.1)),
        ),
      ),
      padding: const EdgeInsets.only(top: 16, left: 10, right: 10, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: PrimaryButton(
                label: 'Proceed',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: Colors.black,
                onPressed: () => ticketDialog(context),
                gradient: buttonGradience(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              child: PrimaryButton(
                label: 'Cancel',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
