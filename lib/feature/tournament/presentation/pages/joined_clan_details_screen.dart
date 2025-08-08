import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/tournament/presentation/widgets/floating_nav_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

class JoinedClanDetailsScreen extends StatefulWidget {
  const JoinedClanDetailsScreen({super.key});

  @override
  State<JoinedClanDetailsScreen> createState() => _JoinedClanDetailsScreenState();
}


class _JoinedClanDetailsScreenState extends State<JoinedClanDetailsScreen> {
  bool _isOverviewExpanded = false;
  bool _showMembersModal = false;
  bool _showInviteFriendsModal = false;
  bool _showChatDrawer = true; // Add chat drawer state
  
  // Search controller and filtered friends list
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _chatController = TextEditingController(); // Add chat controller
  List<Map<String, dynamic>> _filteredFriends = [];
  List<String> _selectedFriends = [];
  

  
  // Sample friends data
  final List<Map<String, dynamic>> _allFriends = [
    {
      'name': 'Jhon William',
      'username': 'jhon390',
      'avatar': 'assets/images/tournament/clan_image.png',
      'isOnline': true,
    },
    {
      'name': 'Jhon William',
      'username': 'jhon222222',
      'avatar': 'assets/images/tournament/clan_image.png',
      'isOnline': false,
    },
    {
      'name': 'Jhon William',
      'username': 'jhon234426',
      'avatar': 'assets/images/tournament/clan_image.png',
      'isOnline': true,
    },
    {
      'name': 'Sarah Connor',
      'username': 'sarah_t800',
      'avatar': 'assets/images/tournament/clan_image.png',
      'isOnline': true,
    },
    {
      'name': 'Mike Johnson',
      'username': 'mike_gamer',
      'avatar': 'assets/images/tournament/clan_image.png',
      'isOnline': false,
    },
    {
      'name': 'Alex Smith',
      'username': 'alex_pro',
      'avatar': 'assets/images/tournament/clan_image.png',
      'isOnline': true,
    },
  ];
  
  // Sample chat messages with time groups
final List<Map<String, dynamic>> _chatMessages = [
  {
    'type': 'time_header',
    'timestamp': 'Today At 02:32 pm',
  },
  {
    'type': 'message',
    'userName': 'Ali Haniah',
    'message': 'What\'s the plan for today?',
    'timestamp': '02:32',
    'avatar': 'assets/images/tournament/clan_image.png',
    'isOwnMessage': false,
  },
  {
    'type': 'message',
    'userName': 'Mousa al Khourey',
    'message': 'Hello!',
    'timestamp': '02:32',
    'avatar': 'assets/images/tournament/clan_image.png',
    'isOwnMessage': false,
  },
  {
    'type': 'message',
    'userName': 'Mousa al Khourey',
    'message': 'Yes, I was also thinking what\'s the plan for today?? can anyone please explain...',
    'timestamp': '02:32',
    'avatar': 'assets/images/tournament/clan_image.png',
    'isOwnMessage': false,
  },
  
  // Earlier time group
  {
    'type': 'time_header',
    'timestamp': 'Today At 02:06 pm',
  },
  {
    'type': 'message',
    'userName': 'Ali Haniah',
    'message': 'Yes, We are fine...What about you??',
    'timestamp': '02:06',
    'avatar': 'assets/images/tournament/clan_image.png',
    'isOwnMessage': false,
  },
  {
    'type': 'message',
    'userName': 'You',
    'message': 'Hello Everyone!',
    'timestamp': '02:06',
    'avatar': 'assets/images/tournament/clan_image.png',
    'isOwnMessage': true,
  },
  {
    'type': 'message',
    'userName': 'You',
    'message': 'How are you guys doing today??',
    'timestamp': '02:06',
    'avatar': 'assets/images/tournament/clan_image.png',
    'isOwnMessage': true,
  },
  
  // Even earlier time group
  {
    'type': 'time_header',
    'timestamp': 'Today At 01:45 pm',
  },
  {
    'type': 'message',
    'userName': 'Ali Haniah',
    'message': 'What\'s the plan for today?',
    'timestamp': '01:45',
    'avatar': 'assets/images/tournament/clan_image.png',
    'isOwnMessage': false,
  },
  {
    'type': 'message',
    'userName': 'Mousa al Khourey',
    'message': 'Hello!',
    'timestamp': '01:45',
    'avatar': 'assets/images/tournament/clan_image.png',
    'isOwnMessage': false,
  },
];
  
  @override
  void initState() {
    super.initState();
    _filteredFriends = List.from(_allFriends);
    _searchController.addListener(_filterFriends);
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _chatController.dispose(); // Dispose chat controller
    super.dispose();
  }
  
  void _filterFriends() {
    setState(() {
      String searchQuery = _searchController.text.toLowerCase();
      if (searchQuery.isEmpty) {
        _filteredFriends = List.from(_allFriends);
      } else {
        _filteredFriends = _allFriends.where((friend) {
          return friend['name'].toLowerCase().contains(searchQuery) ||
                 friend['username'].toLowerCase().contains(searchQuery);
        }).toList();
      }
    });
  }
  
  void _showMembersDialog() {
    setState(() {
      _showMembersModal = true;
    });
  }
  
  void _hideMembersDialog() {
    setState(() {
      _showMembersModal = false;
    });
  }
  
  void _showInviteFriendsDialog() {
    setState(() {
      _showInviteFriendsModal = true;
      _selectedFriends.clear();
      _searchController.clear();
      _filteredFriends = List.from(_allFriends);
    });
  }
  
  void _hideInviteFriendsDialog() {
    setState(() {
      _showInviteFriendsModal = false;
    });
  }
  
  void _toggleChatDrawer() {
    setState(() {
      _showChatDrawer = !_showChatDrawer;
    });
  }
  
  void _sendChatMessage() {
    if (_chatController.text.trim().isNotEmpty) {
      setState(() {
        _chatMessages.insert(0, {
          'type': 'message',
          'userName': 'You',
          'message': _chatController.text.trim(),
          'timestamp': 'Now',
          'avatar': 'assets/images/tournament/clan_image.png',
          'isOwnMessage': true,
        });
        _chatController.clear();
      });
    }
  }
  
  void _toggleFriendSelection(String username) {
    setState(() {
      if (_selectedFriends.contains(username)) {
        _selectedFriends.remove(username);
      } else {
        _selectedFriends.add(username);
      }
    });
  }
  
  void _sendInvites() {
    // Handle sending invites logic here
    print('Sending invites to: $_selectedFriends');
    _hideInviteFriendsDialog();
    
    // Show success message or handle the invite logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invites sent to ${_selectedFriends.length} friends!'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }
  
Widget _buildChatMessage(String userName, String message, String timestamp, String avatar, bool isOwnMessage) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      // Avatar and message content positioning
      if (!isOwnMessage) ...[
        // Avatar for other users (left side)
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(avatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 8.w),
      ],
      
      // Message Content - Dynamic width based on content
      Flexible(
        child: IntrinsicWidth(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75, // Max 75% of screen width
              minWidth: 60.w, // Minimum width for very short messages
            ),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Color.fromRGBO(203, 148, 247, 0.11),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isOwnMessage ? 12.r : 4.r),
                topRight: Radius.circular(isOwnMessage ? 4.r : 12.r),
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(isOwnMessage ? 4.r : 12.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dimmed User Name (hide for own messages or show as "You")
                if (!isOwnMessage || userName != 'You')
                  Text(
                    isOwnMessage ? 'You' : userName,
                    style: AppTextStyles.medium(
                      color: Colors.white.withOpacity(0.6),
                      size: 11.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                if (!isOwnMessage || userName != 'You') SizedBox(height: 6.h),
                
                // Message Text
                Text(
                  message,
                  style: AppTextStyles.medium(
                    color: Colors.white,
                    size: 12.sp,
                  ),
                  softWrap: true,
                ),
                SizedBox(height: 8.h),
                
                // Timestamp at bottom right
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    timestamp,
                    style: AppTextStyles.medium(
                      color: Colors.white.withOpacity(0.4),
                      size: 9.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // Avatar for own messages (right side)
      if (isOwnMessage) ...[
        SizedBox(width: 8.w),
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(avatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ],
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(21, 11, 24, 1),

    appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: Container(
    margin: EdgeInsets.all(12.w), // Increased margin to make button smaller
    decoration: BoxDecoration(
      color: Color(0x12FFFFFF), // Using the exact color from second code
      borderRadius: BorderRadius.circular(100.r), // Circular border radius
    ),
    child: InkWell(
      onTap: () => Navigator.of(context).pop(),
 child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: const Color(0x12FFFFFF), // Semi-transparent white
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                              
                                child: Container(
                                  width: 15.w,
                                  height: 12.h,
                                 child: SvgPicture.asset(
  "assets/images/tournament/clans/Arrow-Left.svg",
  fit: BoxFit.fill,
),

                                ),
                              ),
    ),
  ),
  title: Text(
    'Clan Details',
    style: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 12.sp, // Using smaller font size from second code
    ),
  ),
  centerTitle: true, // Changed to center the title
  titleSpacing: 0, // Reset spacing since title is centered
),

      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/tournament/tournament_background.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Top Section with Background Image and Profile
               Padding(
  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 4.h),
  child: Stack(
    clipBehavior: Clip.none,
    children: [
      // Background Image Card
      Container(
        height: 90.h,
        width: double.infinity,
        padding: EdgeInsets.only(top: 6.h, bottom: 52.h, left: 6.w, right: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
         image: DecorationImage(
  image: AssetImage("assets/images/tournament/clans/clan_detail_backgound.png"), // Replace with your local PNG path
  fit: BoxFit.cover,
),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side - Member avatars and text
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                child: Row(
                  children: [
                    // Member avatars group
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      width: 62.w,
                      height: 24.h,
                    child: Image.asset(
  "assets/images/tournament/clans/clan_members_joined.png", 
    fit: BoxFit.fill,
),

                    ),
                    // "+29 Other Joined" text
                    Expanded(
                      child: Text(
                        '+29 Other Joined',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Right side - Invite Only badge
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                gradient: LinearGradient(
                  begin: Alignment(-1, 1),
                  end: Alignment(1, 1),
                  colors: [
                    Color(0xFFD72121),
                    Color(0xFF771515),
                  ],
                ),
              ),
              padding: EdgeInsets.only(top: 3.h, bottom: 3.h, left: 4.w, right: 8.w),
              margin: EdgeInsets.only(bottom: 1.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    margin: EdgeInsets.only(right: 4.w),
                    width: 14.w,
                    height: 14.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                     child: SvgPicture.asset(
  "assets/images/tournament/clans/invite_only.svg",
  fit: BoxFit.fill,
),

                    ),
                  ),
                  Text(
                    'Invite Only',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Profile Image - Positioned to overlap background and extend below
      Positioned(
        bottom: -50.h,
        left: 0,
        right: 0,
        child: Center(
          child: Transform.translate(
            offset: Offset(0, -10), // Using transform from second code
            child: Container(
              width: 80.w, // Using exact size from second code
              height: 80.h,
             child: Image.asset(
  "assets/images/tournament/clans/joined_clan_profile.png", 
    fit: BoxFit.fill,
),

            ),
          ),
        ),
      ),
    ],
  ),
),
                // Add spacing for the overlapping profile image
                SizedBox(height: 50.h),
                
                // Clan Name and Joined Status Row
                Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.w),
  child: Container(
    margin: EdgeInsets.only(bottom: 16.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 2.h),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 7.w),
                child: Text(
                  'Abyssal Templars',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  gradient: LinearGradient(
                    begin: Alignment(-1, 1),
                    end: Alignment(1, 1),
                    colors: [
                      Color(0xFF1CA82A),
                      Color(0xFF0B4210),
                    ],
                  ),
                ),
                padding: EdgeInsets.only(top: 3.h, bottom: 3.h, left: 4.w, right: 8.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      margin: EdgeInsets.only(right: 4.w),
                      width: 14.w,
                      height: 14.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: SvgPicture.asset(
  "assets/images/tournament/clans/checkmark-circle-02.svg",
  fit: BoxFit.fill,
),

                      ),
                    ),
                    Text(
                      'Joined',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          'ALTS',
          style: TextStyle(
            color: Color(0xFF8EC9ED),
            fontSize: 14.sp,
          ),
        ),
      ],
    ),
  ),
),

// Action Buttons Card
Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.w),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: Color(0x0DFFFFFF),
    ),
    padding: EdgeInsets.all(8.w),
    margin: EdgeInsets.only(bottom: 16.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Invite Friends Button
        Expanded(
          child: InkWell(
            onTap: _showInviteFriendsDialog,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0x4D8EC9ED),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0x1A8EC9ED),
              ),
              padding: EdgeInsets.symmetric(vertical: 7.h),
              margin: EdgeInsets.only(right: 57.w),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    margin: EdgeInsets.only(left: 10.w, right: 8.w),
                    width: 18.w,
                    height: 18.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: SvgPicture.asset(
  "assets/images/tournament/clans/invite_only.svg",
  color: Color(0xFF8EC9ED),
  fit: BoxFit.fill,
),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Invite Friends',
                      style: TextStyle(
                        color: Color(0xFF8EC9ED),
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Right side icon buttons
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Members Button
            InkWell(
              onTap: _showMembersDialog,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0x26F195FF),
                ),
                padding: EdgeInsets.all(8.w),
                margin: EdgeInsets.only(right: 10.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  width: 20.w,
                  height: 20.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                   child: SvgPicture.asset(
  "assets/images/tournament/clans/user-group.svg",
  color: Color.fromARGB(226, 241, 149, 255),
  fit: BoxFit.fill,
),

                  ),
                ),
              ),
            ),
            
            // Chat Button
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0x1A82DF57),
                ),
                padding: EdgeInsets.all(8.w),
                margin: EdgeInsets.only(right: 10.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  width: 20.w,
                  height: 20.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                   child: SvgPicture.asset(
  "assets/images/tournament/clans/bubble-chat.svg",
  fit: BoxFit.fill,
),

                  ),
                ),
              ),
            ),
            
            // More Options Button
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0x0DFFFFFF),
                ),
                padding: EdgeInsets.all(8.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  width: 20.w,
                  height: 20.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: SvgPicture.asset(
  "assets/images/tournament/clans/more-vertical-circle-01.svg",
  fit: BoxFit.fill,
),

                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),

// Horizontal line above overview
Container(
  color: Color(0x1AFFFFFF),
  margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 15.h ),
  height: 1.h,
  width: double.infinity,
),
                
            // Overview Section - Updated to match reference with working See more/less
Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.w),
  child: Container(
    margin: EdgeInsets.only(bottom: 16.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 4.h),
          child: Text(
            'Overview',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 14.sp, // Changed from 18.sp to 14.sp
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Color(0x99FFFFFF), // Changed from withOpacity(0.8) to full white
              fontSize: 12.sp, // Changed from 14.sp to 12.sp
            ),
            children: [
              TextSpan(
                text: _isOverviewExpanded
                    ? 'Welcome to the heart-pounding spectacle that is The Red Village Survival Championship – an eagerly anticipated annual event that unites adventurers and thrill-seekers from diverse backgrounds. Nestled in the breathtaking landscapes of the Red Village, this comprehensive competition showcases the ultimate survival skills and strategic thinking required to dominate in the competitive arena.'
                    : 'Welcome to the heart-pounding spectacle that is The Red Village Survival Championship – an eagerly anticipated annual event that unites adventurers and thrill-seekers from diverse backgrounds. Nestled in the breathtaking landscapes of the Red Village, this',
              ),
              TextSpan(
                text: _isOverviewExpanded ? ' See less' : ' See More...',
                style: TextStyle(
                  color: const Color(0xFFDAA520), // Golden color for clickable text
                  fontSize: 12.sp,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      _isOverviewExpanded = !_isOverviewExpanded;
                    });
                  },
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),



// Clan Stats Section - Updated to match reference styling
Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.w),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Clan Level Card
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Color(0x0DFFFFFF), // Using reference background color
        ),
        padding: EdgeInsets.all(8.w),
        margin: EdgeInsets.only(bottom: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 4.h),
                          child: Text(
                            'Clan Level',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.sp, // Smaller font size from reference
                            ),
                          ),
                        ),
                        Text(
                          '12',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14.sp, // Font size from reference
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 22.h),
                    child: Text(
                      '1200/380',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Progress bar with reference styling
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: Color(0x1AFFFFFF), // Reference background
              ),
              width: double.infinity,
              height: 6.h,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      gradient: LinearGradient(
                        begin: Alignment(1, 1),
                        end: Alignment(-1, 1),
                        colors: [
                          Color(0xFF539BFF), // Reference gradient colors
                          Color(0xFF1E5FBB),
                        ],
                      ),
                    ),
                    width: 84.w, // Fixed width from reference
                    height: 6.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Members Card
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Color(0x0DFFFFFF),
        ),
        padding: EdgeInsets.all(8.w),
        margin: EdgeInsets.only(bottom: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 4.h),
                    child: Text(
                      'Members',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  Text(
                    '32/50',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: Color(0x1AFFFFFF),
              ),
              width: double.infinity,
              height: 6.h,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      gradient: LinearGradient(
                        begin: Alignment(1, -1),
                        end: Alignment(-1, -1),
                        colors: [
                          Color(0xFF55FFF6), // Reference gradient colors
                          Color(0xFF1F8D88),
                        ],
                      ),
                    ),
                    width: 200.w, // Fixed width from reference
                    height: 6.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Active Mission Card
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Color(0x0DFFFFFF),
        ),
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 4.h),
                            child: Text(
                              'Active Mission',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          Text(
                            'Win 5 Tournaments in 30 day\'s.',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 22.h),
                    child: Text(
                      '01/05',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: Color(0x1AFFFFFF),
              ),
              width: double.infinity,
              height: 6.h,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      gradient: LinearGradient(
                        begin: Alignment(1, 1),
                        end: Alignment(-1, 1),
                        colors: [
                          Color(0xFFFF9253), // Reference gradient colors
                          Color(0xFFBB551E),
                        ],
                      ),
                    ),
                    width: 63.w, // Fixed width from reference
                    height: 6.h,
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

SizedBox(height: 24.h),
                
                // Missions Card
              
Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.w),
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Color(0x00000000), // Transparent border
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8.r),
      gradient: LinearGradient(
        begin: Alignment(-1, 1),
        end: Alignment(1, 1),
        colors: [
          Color(0x1CFFFFFF), // Reference gradient colors
          Color(0x00FFFFFF),
        ],
      ),
    ),
    padding: EdgeInsets.symmetric(vertical: 12.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and count
        Container(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          margin: EdgeInsets.only(bottom: 12.h, left: 12.w, right: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 4.w),
                  child: Text(
                    'Missions',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16.sp, // Updated font size from reference
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '05',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        
        // Mission List
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active Mission (First Item) with special styling
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0x80E99CFF), // Purple border for active
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6.r),
                  color: Color(0x33EA9CFF), // Purple background for active
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                margin: EdgeInsets.only(bottom: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mission content row
                    Container(
                      margin: EdgeInsets.only(bottom: 12.h, left: 10.w, right: 10.w),
                      child: Row(
                        children: [
                          // Mission Icon
                          InkWell(
                            onTap: () { print('Pressed'); },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: Color(0x1AFDEB56), // Yellow background for icon
                              ),
                              padding: EdgeInsets.only(top: 9.h, bottom: 9.h, left: 13.w, right: 13.w),
                              margin: EdgeInsets.only(right: 12.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                width: 46.w,
                                height: 52.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.r),
                                  child: SvgPicture.asset(
  "assets/images/tournament/clans/mission.svg",
  fit: BoxFit.fill,
),

                                ),
                              ),
                            ),
                          ),
                          
                          // Mission Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 4.h),
                                  child: Text(
                                    'Active',
                                    style: TextStyle(
                                      color: Color(0xFF1FD030), // Green for active
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      child: Text(
                                        'Win 5 Tournaments in 30 Da...',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Make team using clan members and win 5 tournaments in 30 day...',
                                      style: TextStyle(
                                        color: Color(0x99FFFFFF),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Progress section for active mission
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 6.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tournament Win',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 3.w),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 3.w),
                                        child: Text(
                                          '03',
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 3.w),
                                        child: Text(
                                          '/',
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '05',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Progress Bar
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                  height: 4.h,
                                  width: double.infinity,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.r),
                                    color: Color(0x1AFFFFFF), // Background for progress bar
                                  ),
                                  width: double.infinity,
                                  height: 4.h,
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.r),
                                          gradient: LinearGradient(
                                            begin: Alignment(1, -1),
                                            end: Alignment(-1, -1),
                                            colors: [
                                              Color(0xFF55FFF6), // Cyan gradient
                                              Color(0xFF1F8D88),
                                            ],
                                          ),
                                        ),
                                        width: 183.w, // Fixed width from reference
                                        height: 4.h,
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
                  ],
                ),
              ),
              
              // Regular Mission Items (3 more items)
              ...List.generate(3, (index) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.r),
      color: Color.fromARGB(6, 248, 230, 230), // Light background for inactive
    ),
    padding: EdgeInsets.all(10.w),
    margin: EdgeInsets.only(bottom: index == 2 ? 0 : 10.h), // No margin for last item
    child: Row(
      children: [
        // Mission Icon
        InkWell(
          onTap: () { print('Pressed'); },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: Color(0x1AFDEB56),
            ),
            padding: EdgeInsets.only(top: 9.h, bottom: 9.h, left: 13.w, right: 13.w),
            margin: EdgeInsets.only(right: 16.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
              ),
              width: 46.w,
              height: 52.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: SvgPicture.asset( // Changed from Image.network to SvgPicture.asset
                  "assets/images/tournament/clans/mission.svg",
                  fit: BoxFit.contain, // Changed from BoxFit.fill to BoxFit.contain for better SVG rendering
                  width: 46.w,
                  height: 52.h,
                ),
              ),
            ),
          ),
        ),

                      
                      // Mission Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 2.h),
                              child: Text(
                                'Win 5 Tournaments in 30 Da...',
                                style: TextStyle(
                                  color: Color(0x99FFFFFF)
,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              'Make team using clan members and win 5 tournaments in 30 day...',
                              style: TextStyle(
                                color: Color(0x99FFFFFF),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    ),
  ),
),
                SizedBox(height: 100.h),
              ],
            ),
          ),
          
          // Floating Navigation
          const FloatingNavWidget(currentTabIndex: 3),
          
// Animated Chat Drawer Toggle Button - Synchronized with drawer
AnimatedPositioned(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  right: _showChatDrawer ? -20.w : 323.w,
  top: MediaQuery.of(context).size.height * 0.35,
  child: GestureDetector(
    onTap: _toggleChatDrawer,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 120.w,
      height:  160.h,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 70.w,
              height:  160.h,
              child: Stack(
                children: [
                  // SVG background shape (no transparency issues)
                  Positioned.fill(
                    child: SvgPicture.asset(
                      'assets/images/tournament/chat_drawer_toggle.svg', // SVG version
                      fit: BoxFit.contain,
                     
                    ),
                  ),
                  
                  // Animated Flutter Icon arrow overlay
                Positioned.fill(
  child: Center(
    child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return RotationTransition(
          turns: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 8.w), // Add padding to move icon right
        child: Icon(
          _showChatDrawer 
              ? Icons.keyboard_double_arrow_left
              : Icons.keyboard_double_arrow_right,
          key: ValueKey<bool>(_showChatDrawer),
          color: const Color.fromARGB(255, 5, 5, 5),
          size: 18.sp,
        ),
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

AnimatedPositioned(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  left: _showChatDrawer ? 380.w : 30.w,
  top: 0,
  bottom: 0,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(0), // No border radius to match design
    child: Container(
      width: 350.w,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/tournament/chat_drawer_background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
            ),
          ),
          
          // Backdrop filter applied only to this container
          BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 50.0, 
              sigmaY: 50.0,
              tileMode: TileMode.clamp, // Prevents edge artifacts
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF).withOpacity(0.01), // Very subtle white overlay, matching CSS
              ),
              child: Column(
                children: [
                  // Chat Header - Matches reference styling
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0x0DFFFFFF),
                          width: 1,
                        ),
                      ),
                      color: Color(0x0DFFFFFF), // Header background from reference
                    ),
                    padding: EdgeInsets.only(top: 60.h, bottom: 12.h, left: 12.w, right: 12.w),
                    margin: EdgeInsets.only(bottom: 24.h),
                    child: Row(
                      children: [
                        // Clan Info Section
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 12.w),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  width: 36.w,
                                  height: 36.h,
                                 child: Image.asset(
  "assets/images/tournament/clans/joined_clan_profile.png", 
    fit: BoxFit.fill,
),

                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 1.h),
                                      margin: EdgeInsets.only(bottom: 2.h),
                                      child: Text(
                                        'Abyssal Templars',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'ALTS',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Active Users Badge
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            gradient: LinearGradient(
                              begin: Alignment(-1, 1),
                              end: Alignment(1, 1),
                              colors: [
                                Color(0xFF29AD36),
                                Color(0xFF0A5512),
                              ],
                            ),
                          ),
                          padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 4.w, right: 5.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(100.r),
    color: Colors.white, // White background
  ),
  margin: EdgeInsets.only(right: 6.w),
  width: 4.w,
  height: 4.h,
),
                              Text(
                                '12 People Active',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Chat Messages Area - Scrollable
                   Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      // Time Header
                      Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        child: Center(
                          child: Text(
                            'Today At 02:32 pm',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ),
                      
                      // Chat Messages - Using reference styling
                      _buildChatMessageFromReference(
                        'Ali Haninah',
                        'What\'s the plan for today?',
                        'Today At 02:32 pm',
                        "assets/images/tournament/clans/chat_drawer_person_1.png",
                        false,
                      ),
                      
                      SizedBox(height: 12.h),
                      
                      // Multiple messages from same user
                      _buildMultipleChatMessages(
                        'Mousa al Khourey',
                        ['Hello!', 'Yes, I was also thinking what\'s the plan for today?? can anyone please explain..'],
                        'Today At 02:32 pm',
                        "assets/images/tournament/clans/chat_drawer_person_2.png",
                        false,
                      ),
                      
                      SizedBox(height: 12.h),
                      
                      _buildChatMessageFromReference(
                        'Ali Haninah',
                        'Yes, We are fine...What about you??',
                        'Today At 02:32 pm',
                        "assets/images/tournament/clans/chat_drawer_person_1.png",
                        false,
                      ),
                      
                      SizedBox(height: 12.h),
                      
                      // Time Header
                      Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        child: Center(
                          child: Text(
                            'Today At 02:45 pm',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ),
                      
                      // Own messages (right aligned with blue background)
                      _buildOwnMessages([
                        'Hello Everyone!',
                        'How are you guys doing today??'
                      ], 'Today At 02:32 pm'),
                      
                      SizedBox(height: 12.h),
                      
                      _buildChatMessageFromReference(
                        'Ali Haninah',
                        'What\'s the plan for today?',
                        'Today At 02:32 pm',
                        "assets/images/tournament/clans/chat_drawer_person_1.png",
                        false,
                      ),
                      
                      SizedBox(height: 12.h),
                      
                      _buildChatMessageFromReference(
                        'Mousa al Khourey',
                        'Hello!',
                        'Today At 02:32 pm',
                        "assets/images/tournament/clans/chat_drawer_person_2.png",
                        false,
                      ),
                      
                      SizedBox(height: 30.h), // Extra space at bottom
                    ],
                  ),
                ),
              ),
              

                  // Chat Input Area - Matches reference design
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Selector Button
                        InkWell(
                          onTap: () { print('Image selector pressed'); },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              gradient: LinearGradient(
                                begin: Alignment(-1, -1),
                                end: Alignment(1, 1),
                                colors: [
                                  Color(0x338EC9ED),
                                  Color(0x662D4452),
                                ],
                              ),
                            ),
                            padding: EdgeInsets.all(13.w),
                            margin: EdgeInsets.only(right: 10.w),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              width: 24.w,
                              height: 24.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: SvgPicture.asset(
  "assets/images/tournament/clans/chat-image-02.svg",
  fit: BoxFit.fill,
),

                              ),
                            ),
                          ),
                        ),
                        
                        // Emoji Selector Button
                        InkWell(
                          onTap: () { print('Emoji selector pressed'); },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              gradient: LinearGradient(
                                begin: Alignment(-1, -1),
                                end: Alignment(1, 1),
                                colors: [
                                  Color(0x33BC5AD7),
                                  Color(0x664E205A),
                                ],
                              ),
                            ),
                            padding: EdgeInsets.all(13.w),
                            margin: EdgeInsets.only(right: 10.w),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              width: 24.w,
                              height: 24.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                               child: SvgPicture.asset(
  "assets/images/tournament/clans/chat_wink.svg",
  fit: BoxFit.fill,
),

                              ),
                            ),
                          ),
                        ),
                        
                        // Text Input with Send Button
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0x1AFFFFFF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              color: Color(0x0DFFFFFF),
                            ),
                            margin: EdgeInsets.only(right: 10.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 16.w),
                                    child: TextField(
                                      controller: _chatController,
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 14.sp,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Type here...',
                                        hintStyle: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 14.sp,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ),
                                // Send Button
                                InkWell(
                                  onTap: _sendChatMessage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Color(0xFFFDEB56), // Yellow send button
                                    ),
                                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 8.w, right: 8.w),
                                    margin: EdgeInsets.only(right: 6.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      width: 20.w,
                                      height: 20.h,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.r),
                                      child: SvgPicture.asset(
  "assets/images/tournament/clans/sent.svg",
  fit: BoxFit.fill,
),

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
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),
// Updated Custom Members Modal
if (_showMembersModal)
  Positioned.fill(
    child: GestureDetector(
      onTap: _hideMembersDialog,
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              // Add padding to prevent clipping
              padding: EdgeInsets.only(top: 30.h), // Space for close button
              child: Stack(
                clipBehavior: Clip.none, // IMPORTANT: Prevent clipping
                children: [
                  // Main modal container
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.5,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0x00000000), // Transparent border
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.r), // Reference border radius
                      color: Color(0xFF1D161F), // Reference background color
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with title only
                        Container(
                          margin: EdgeInsets.only(bottom: 12.h, left: 12.w),
                          child: Text(
                            'Clan Members',
                            style: TextStyle(
                              color: Color(0xCCFFFFFF),
                              fontSize: 14.sp, // Reference font size
                            ),
                          ),
                        ),
                        
                        // Members list
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Leader member with special styling
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.h, left: 12.w, right: 12.w),
                                  child: Row(
                                    children: [
                                      Expanded( // Takes available width and avoids hardcoded spacing
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6.r),
                                            color: Color(0x08FFFFFF), // Reference background
                                          ),
                                          padding: EdgeInsets.all(8.w),
                                          margin: EdgeInsets.only(right: 4.w),
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(right: 10.w),
                                                width: 36.w,
                                                height: 36.h,
                                               child: Image.asset(
  "assets/images/tournament/leaderboard/solo_leaderboard.png", 
    fit: BoxFit.fill,
),

                                              ),
                                              Expanded( // Ensures text wraps and doesn't overflow
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Mouad el Khouray', // Updated to your clan member name
                                                      style: TextStyle(
                                                        color: Color(0xE5FFFFFF),
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      'mouad583', // Updated username
                                                      style: TextStyle(
                                                        color: Color(0x66FFFFFF),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 8.w), // Optional spacing between name and badge
                                              // Leader badge
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100.r),
                                                  color: Color(0x1A1FD031), // Green background
                                                ),
                                                padding: EdgeInsets.only(top: 3.h, bottom: 3.h, left: 4.w, right: 8.w),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(right: 4.w),
                                                      width: 12.w,
                                                      height: 12.h,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(100.r),
                                                      child: SvgPicture.asset(
  "assets/images/tournament/clans/clan_star.svg",
  fit: BoxFit.fill,
),

                                                      ),
                                                    ),
                                                    Text(
                                                      'Leader',
                                                      style: TextStyle(
                                                        color: Color(0xFF1FD030), // Green text
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Scrollbar indicator (vertical line)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100.r),
                                          color: Color(0x0DFFFFFF),
                                        ),
                                        width: 4.w,
                                        height: 48.h,
                                      ),
                                    ],
                                  ),
                                ),

                                // Regular members with your clan member names
                                ...List.generate(5, (index) {
                                  final List<String> names = [
                                    'Wael Alshamery',
                                    'Jhon William', 
                                    'Wael Alshamery',
                                    'Jhon William',
                                    'Jhon William'
                                  ];
                                  final List<String> usernames = [
                                    'wael455',
                                    'jhon390', // Updated to match your sample data
                                    'wael455', 
                                    'jhon390',
                                    'jhon390'
                                  ];
                                 return Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(6.r),
    color: Color(0x08FFFFFF),
  ),
  padding: EdgeInsets.all(8.w),
  margin: EdgeInsets.only(
    bottom: index == 4 ? 0 : 10.h, // No margin for last item
    left: 12.w, 
    right: 20.w
  ),
  child: Row(
    children: [
      Container(
        margin: EdgeInsets.only(right: 10.w),
        width: 36.w,
        height: 36.h,
        child: Image.asset( // Changed from Image.network to Image.asset
          "assets/images/tournament/leaderboard/solo_leaderboard.png",
          fit: BoxFit.fill,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            names[index],
            style: TextStyle(
              color: Color(0xE5FFFFFF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            usernames[index],
            style: TextStyle(
              color: Color(0x66FFFFFF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ],
  ),
);
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Close button positioned with higher z-index
                   Positioned(
  top: -10.h, // Position above the modal
  right: 10.w, // Align with modal's right edge  
  child: GestureDetector(
    onTap: _hideInviteFriendsDialog,
    child: Container(
      width: 20.w, // Updated size
      height: 20.h, // Updated size
      decoration: BoxDecoration(
        color: Color(0xFF342D35), // Background color
        shape: BoxShape.circle, // Makes it circular
      ),
      child: Center( // Center the SVG icon
        child: SvgPicture.asset(
          "assets/images/tournament/clans/close.svg",
          width: 8.w, // Adjust icon size as needed
          height: 8.h, // Adjust icon size as needed
          fit: BoxFit.contain,
        ),
      ),
    ),
  ),
),
              

                ],
              ),
            ),
          ),
        ),
      ),
    ),
  ),

// Fixed Invite Friends Modal - Updated to match reference styling
if (_showInviteFriendsModal)
  Positioned.fill(
    child: GestureDetector(
      onTap: _hideInviteFriendsDialog,
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              // Add padding to prevent clipping
              padding: EdgeInsets.only(top: 30.h), // Space for close button
              child: Stack(
                clipBehavior: Clip.none, // IMPORTANT: Prevent clipping
                children: [
                  // Main modal container
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0x00000000), // Transparent border
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      color: Color(0xFF1D161F), // Reference background color
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Important: fit content
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header and Search Section
                        Container(
                          margin: EdgeInsets.only(bottom: 24.h, left: 14.w, right: 14.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Container(
                                margin: EdgeInsets.only(bottom: 12.h),
                                child: Text(
                                  'Invite Friend',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              
                              // Search Bar
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0x40FFFFFF),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(6.r),
                                      color: Color(0x40100613),
                                    ),
                                    padding: EdgeInsets.only(top: 11.h, bottom: 11.h, left: 12.w, right: 12.w),
                                    margin: EdgeInsets.only(bottom: 8.h),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6.r),
                                          ),
                                          margin: EdgeInsets.only(right: 10.w),
                                          width: 20.w,
                                          height: 20.h,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(6.r),
                                            child: SvgPicture.asset(
  "assets/images/tournament/clans/search-01.svg",
  fit: BoxFit.fill,
),

                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: TextField(
                                              controller: _searchController,
                                              style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'Jhon William',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFFFFFFFF).withOpacity(0.5),
                                                  fontSize: 14.sp,
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
                                  
                                  // Friends List
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Selected Friend (Green background with checkmark)
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0x261FD030),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(6.r),
                                          color: Color(0x261FD030),
                                        ),
                                        padding: EdgeInsets.all(6.w),
                                        margin: EdgeInsets.only(bottom: 6.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(right: 12.w),
                                                  width: 32.w,
                                                  height: 32.h,
                                                 child: Image.asset(
  "assets/images/tournament/leaderboard/solo_leaderboard.png", 
    fit: BoxFit.fill,
),

                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(bottom: 2.h),
                                                      child: Text(
                                                        'Jhon William',
                                                        style: TextStyle(
                                                          color: Color(0xFFFFFFFF),
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      'jhon890',
                                                      style: TextStyle(
                                                        color: Color(0xFFFFFFFF),
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6.r),
                                              ),
                                              width: 16.w,
                                              height: 16.h,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(6.r),
                                                child: SvgPicture.asset(
  "assets/images/tournament/clans/check_invite_friend.svg",
  fit: BoxFit.fill,
),

                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      
                                      // Regular Friends List
...List.generate(2, (index) {
  final List<String> usernames = ['jhon1222222', 'jhon234442'];
  final List<String> imageUrls = [
    'assets/images/tournament/clans/invite_friend_1.png',
    'assets/images/tournament/clans/invite_friend_2.png'
 
  ];
  
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6.r),
      color: Color(0x08FFFFFF),
    ),
    padding: EdgeInsets.only(top: 6.h, bottom: 6.h, left: 6.w),
    margin: EdgeInsets.only(bottom: index == 1 ? 0 : 6.h),
    child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 12.w),
          width: 32.w,
          height: 32.h,
          child: Image.asset( // Changed from Image.network to Image.asset
            imageUrls[index],
            fit: BoxFit.fill,
          ),
        ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(bottom: 2.h),
                                                    child: Text(
                                                      'Jhon William',
                                                      style: TextStyle(
                                                        color: Color(0xFFFFFFFF),
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    usernames[index],
                                                    style: TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Bottom Buttons
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Cancel Button
                              Expanded(
                                child: InkWell(
                                  onTap: _hideInviteFriendsDialog,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Color(0x12FFFFFF),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    margin: EdgeInsets.only(right: 14.w),
                                    child: Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Invite Button
                              Expanded(
                                child: InkWell(
                                  onTap: _sendInvites,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0x26FFFFFF),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                      gradient: LinearGradient(
                                        begin: Alignment(1, -1),
                                        end: Alignment(1, 1),
                                        colors: [
                                          Color(0xFFFDEB56), // Reference gradient colors
                                          Color(0xFFAA9E39),
                                        ],
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 10.h),
                                    child: Center(
                                      child: Text(
                                        'Invite',
                                        style: TextStyle(
                                          color: Color(0xFF24210A), // Dark text on yellow background
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
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
                  
                  // Close button positioned with higher z-index
                 
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  ),
        ],
      ),
    );
  }

  // Helper method to build chat messages from reference
Widget _buildChatMessageFromReference(String userName, String message, String timestamp, String avatarUrl, bool isOwnMessage) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (!isOwnMessage) ...[
        Container(
          margin: EdgeInsets.only(right: 10.w),
          width: 30.w,
          height: 30.h,
          child: Image.asset(
            avatarUrl,
            fit: BoxFit.fill,
          ),
        ),
      ],
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
              topLeft: isOwnMessage ? Radius.circular(12.r) : Radius.circular(4.r),
            ),
            color: isOwnMessage ? Color(0x1A8EC9ED) : Color(0x0DFFFFFF),
            border: isOwnMessage ? Border.all(color: Color(0x1A8EC9ED), width: 1) : null,
          ),
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isOwnMessage) ...[
                        Container(
                          margin: EdgeInsets.only(bottom: 6.h),
                          child: Text(
                            userName,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ],
                      Container(
                        margin: EdgeInsets.only(bottom: 1.h),
                        child: Text(
                          message,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: isOwnMessage ? 8.h : 23.h, right: 1.w),
                child: Text(
                  timestamp,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// Helper method for multiple messages from same user
Widget _buildMultipleChatMessages(String userName, List<String> messages, String timestamp, String avatarUrl, bool isOwnMessage) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (!isOwnMessage) ...[
        Container(
          margin: EdgeInsets.only(right: 10.w),
          width: 30.w,
          height: 30.h,
         child: Image.asset(
            avatarUrl,
            fit: BoxFit.fill,
          ),
        ),
      ],
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First message
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                color: Color(0x0DFFFFFF),
              ),
              padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 12.w, right: 12.w),
              margin: EdgeInsets.only(bottom: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 6.h),
                            child: Text(
                              userName,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.sp,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: Text(
                              messages[0],
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 23.h),
                    child: Text(
                      timestamp,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Second message
            if (messages.length > 1) ...[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r),
                  ),
                  color: Color(0x0DFFFFFF),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 6.h, left: 12.w, right: 12.w),
                      child: Text(
                        messages[1],
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12.w),
                      child: Text(
                        timestamp,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    ],
  );
}

// Helper method for own messages (right aligned)
Widget _buildOwnMessages(List<String> messages, String timestamp) {
  return Container(
    margin: EdgeInsets.only(bottom: 12.h, left: 35.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // First message
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0x1A8EC9ED),
              width: 1,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
            color: Color(0x1A8EC9ED),
          ),
          padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 12.w, right: 12.w),
          margin: EdgeInsets.only(bottom: 6.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 1.h),
                margin: EdgeInsets.only(right: 14.w),
                child: Text(
                  messages[0],
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Text(
                timestamp,
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
        // Second message
        if (messages.length > 1) ...[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0x1A8EC9ED),
                width: 1,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              color: Color(0x1A8EC9ED),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 1.h),
                  margin: EdgeInsets.only(bottom: 6.h, left: 69.w),
                  child: Text(
                    messages[1],
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    timestamp,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}
  
  Widget _buildIconOnlyButton(String iconAsset, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Image.asset(
            iconAsset,
            width: 22.sp,
            height: 22.sp,
            color: color,
          ),
        ),
      ),
    );
  }
  
  Widget _buildFullWidthStatCard(String title, String value, String rightValue, double progress, Color progressColor, bool isTransparent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isTransparent ? const Color(0xFF3D2B5F).withOpacity(0.3) : const Color(0xFF3D2B5F),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.7),
                  size: 10.sp,
                ),
              ),
              if (rightValue.isNotEmpty)
                Text(
                  rightValue,
                  style: AppTextStyles.medium(
                    color: AppColors.baseWhite.withOpacity(0.7),
                    size: 10.sp,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.largeBold(
              color: AppColors.baseWhite,
              size: 16.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMissionStatCard(String title, String missionText, String progress, double progressValue, Color progressColor, bool isTransparent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isTransparent ? const Color(0xFF3D2B5F).withOpacity(0.3) : const Color(0xFF3D2B5F),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.7),
                  size: 10.sp,
                ),
              ),
              Text(
                progress,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.7),
                  size: 10.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            missionText,
            style: AppTextStyles.largeBold(
              color: AppColors.baseWhite,
              size: 14.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progressValue,
                  child: Container(
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMemberItem(String name, String role, String username, String imagePath, int index) {
    return Row(
      children: [
        // Member Avatar
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        
        // Member Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite,
                  size: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                username,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.6),
                  size: 12.sp,
                ),
              ),
            ],
          ),
        ),
        
        // Leader Badge (only for leader)
        if (role == 'Leader')
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.3),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: const Color(0xFF81C784),
                  size: 14.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Leader',
                  style: AppTextStyles.medium(
                    color: const Color(0xFF81C784),
                    size: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
  
  Widget _buildFriendItem(String name, String username, String imagePath, bool isOnline, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF4CAF50).withOpacity(0.3) // More transparent green background when selected
              : Colors.white.withOpacity(0.04), // Default background
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected 
              ? Border.all(
                  color: const Color(0xFF4CAF50).withOpacity(0.6), // Green border when selected
                  width: 0.3,
                )
              : null, // No border when not selected
        ),
        child: Row(
          children: [
            // Friend Avatar
            Container(
              width: 45.w,
              height: 45.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            
            // Friend Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.medium(
                      color: AppColors.baseWhite,
                      size: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    username,
                    style: AppTextStyles.medium(
                      color: AppColors.baseWhite.withOpacity(0.6),
                      size: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            
            // Selection indicator (green circle with black check when selected)
            if (isSelected)
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50), // Green circle background
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.black, // Black tick symbol
                  size: 14.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMissionItem(String title, String description, String type, String progress, double progressValue, bool isActive) {
    return Opacity(
      opacity: isActive ? 1.0 : 0.6,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mission Icon
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                 color: const Color(0x1AFDEB56),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/tournament/clan_missions.png',
                    width: 30.w,
                    height: 30.w,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              
              // Mission Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Active text (left-aligned, simple text)
                    if (isActive)
                      Text(
                        'Active',
                        style: AppTextStyles.medium(
                          color: const Color(0xFF4CAF50),
                          size: 10.sp,
                          fontWeight: FontWeight.normal, // Removed bold
                        ),
                      ),
                    if (isActive) SizedBox(height: 4.h),
                    
                    // Mission title
                    Text(
                      title,
                      style: AppTextStyles.medium(
                        color: AppColors.baseWhite,
                        size: 12.sp,
                        fontWeight: FontWeight.normal, // Removed bold
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    
                    // Description
                    Text(
                      description,
                      style: AppTextStyles.medium(
                        color: AppColors.baseWhite.withOpacity(0.7),
                        size: 10.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12.h),
          
          // Progress section (below icon and content)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: AppTextStyles.medium(
                  color: const Color(0xFF64B5F6),
                  size: 10.sp,
                  fontWeight: FontWeight.normal, // Removed bold
                ),
              ),
              Text(
                progress,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.7),
                  size: 10.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          
          // Progress bar (full width)
          Container(
            height: 4.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: Stack(
              children: [
                if (isActive)
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF00BCD4),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}