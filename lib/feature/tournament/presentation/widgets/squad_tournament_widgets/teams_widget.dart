import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class TeamListWidget extends StatelessWidget {
  const TeamListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF100613), // Dark background
      child: ListView(
        shrinkWrap: true, // ✅ Add this
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          // Team 1 - Avengers
          _buildTeamCard(
            teamName: 'Avengers',
            teamSubtitle: 'Team 1',
            members: [
              _TeamMember(
                name: 'Ali Haninah',
                isCaptain: true,
                avatarUrl: 'assets/icons/mousa-al-khourey.png',
              ),
              _TeamMember(
                name: 'Mousa al Khourey',
                isCaptain: false,
                avatarUrl: 'assets/icons/mousa-al-khourey.png',
              ),
            ],
            emptySlots: 2,
          ),

          const SizedBox(height: 16),

          // Team 2 - Avengers
          _buildTeamCard(
            teamName: 'Avengers',
            teamSubtitle: 'Team 2',
            members: [
              _TeamMember(
                name: 'Ali Haninah',
                isCaptain: true,
                avatarUrl: 'assets/icons/mousa-al-khourey.png',
              ),
              _TeamMember(
                name: 'Mousa al Khourey',
                isCaptain: false,
                avatarUrl: 'assets/icons/mousa-al-khourey.png',
              ),
              _TeamMember(
                name: 'Mousa al Khourey',
                isCaptain: false,
                avatarUrl: 'assets/icons/mousa-al-khourey.png',
              ),
              _TeamMember(
                name: 'Mousa al Khourey',
                isCaptain: false,
                avatarUrl: 'assets/icons/mousa-al-khourey.png',
              ),
            ],
            emptySlots: 0,
          ),

          const SizedBox(height: 16),

          // Empty Teams 3-7
          _buildEmptyTeam('Team 3'),
          const SizedBox(height: 16),
          _buildEmptyTeam('Team 4'),
          const SizedBox(height: 16),
          _buildEmptyTeam('Team 5'),
          const SizedBox(height: 16),
          _buildEmptyTeam('Team 6'),
          const SizedBox(height: 16),
          _buildEmptyTeam('Team 7'),
        ],
      ),
    );
  }

  Widget _buildTeamCard({
    required String teamName,
    required String teamSubtitle,
    required List<_TeamMember> members,
    required int emptySlots,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF170E1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF201723),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team Header
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                      6.0), // Optional: adjust for inner spacing
                  child: Image.asset(
                    'assets/icons/squad-avengers.png', // 🔁 Replace with your actual asset path
                    fit: BoxFit.contain,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teamName,
                      style: AppTextStyles.small(
                        color: Colors.white,
                        size: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      teamSubtitle,
                      style: AppTextStyles.small(
                        color: Color(0xFF8A8A8A),
                        size: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(
              color: Color(0xFF241B26),
              height: 0,
            ),
          ),

          // Team Members
          ...members.map((member) => _buildMemberRow(member)),

          // Empty Slots
          ...List.generate(emptySlots, (index) => _buildEmptySlot()),
        ],
      ),
    );
  }

  Widget _buildMemberRow(_TeamMember member) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF4A9B8E),
            child: member.avatarUrl != null
                ? ClipOval(
                    child: Image.asset(
                      member.avatarUrl!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        );
                      },
                    ),
                  )
                : const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              member.name,
              style: AppTextStyles.small(
                color: Colors.white,
                size: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (member.isCaptain)
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Color(0xFFD4AF37),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'Captain',
                  style: AppTextStyles.small(
                    color: Color(0xFFD4AF37),
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildEmptySlot() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF241B26),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: Color(0xFF7C767D),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Not Joined Yet',
            style: AppTextStyles.small(
                color: Color(0xFF8C878D),
                size: 14,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTeam(String teamName) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF170E1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF201723),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF241B26),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.group_outlined,
              color: Color(0xFF8A8A8A),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              teamName,
              style: AppTextStyles.small(
                color: Colors.white,
                size: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            'Not Joined',
            style: AppTextStyles.small(
              color: Color(0xFF8A8A8A),
              size: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamMember {
  final String name;
  final bool isCaptain;
  final String? avatarUrl;

  _TeamMember({
    required this.name,
    required this.isCaptain,
    this.avatarUrl,
  });
}
