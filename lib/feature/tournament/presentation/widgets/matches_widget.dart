import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class TournamentBracketWidget extends StatelessWidget {
  final List<TournamentRound> rounds;
  final Color? backgroundColor;
  final Color? cardColor;
  final Color? textColor;
  final Color? vsColor;

  const TournamentBracketWidget({
    Key? key,
    required this.rounds,
    this.backgroundColor,
    this.cardColor,
    this.textColor,
    this.vsColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor ?? const Color(0xFF100613),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rounds.map((round) => _buildRound(round)).toList(),
        ),
      ),
    );
  }

  Widget _buildRound(TournamentRound round) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            round.title,
            style: AppTextStyles.small(
              color: textColor ?? Colors.white,
              size: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...round.matches.map((match) => _buildMatchTile(match)).toList(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMatchTile(Match match) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF170E1A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          // Left Player
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFF241B26),
                  child: Image.asset(
                    'assets/icons/3-user-icon-disabled.png', // 🔁 Replace with your image path
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    match.player1,
                    style: AppTextStyles.small(
                      color: textColor ?? Colors.white,
                      size: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // VS Section
          Column(
            children: [
              Text(
                'VS',
                style: AppTextStyles.small(
                  color: vsColor ?? Color(0xFFF71756),
                  size: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                match.matchLabel,
                style: AppTextStyles.small(
                  color: Colors.grey.shade400,
                  size: 12,
                ),
              ),
            ],
          ),

          // Right Player
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    match.player2,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.small(
                      color: textColor ?? Colors.white,
                      size: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  backgroundColor: Color(0xFF241B26),
                  child: Image.asset(
                    'assets/icons/3-user-icon-disabled.png', // 🔁 Replace with your image path
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
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

// Data Models
class TournamentRound {
  final String title;
  final List<Match> matches;

  TournamentRound({
    required this.title,
    required this.matches,
  });
}

class Match {
  final String player1;
  final String player2;
  final String matchLabel;

  Match({
    required this.player1,
    required this.player2,
    required this.matchLabel,
  });
}
