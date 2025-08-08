import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/feature/tournament/presentation/bloc/tournament_auth_bloc.dart';
import 'package:yalgamers/feature/tournament/presentation/bloc/tournament_auth_event.dart';
import 'package:yalgamers/feature/tournament/presentation/bloc/tournament_auth_state.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_layout.dart';

void showYalGamersAccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.baseWhite.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Allow YalGamers Access?',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We need access to verify your activities and track task completion.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: AppColors.baseWhite.withOpacity(0.7),
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Deny',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: AppColors.baseWhite.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BlocConsumer<TournamentAuthBloc, TournamentAuthState>(
                    listener: (context, state) {
                      if (state is TournamentAuthSuccess) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const TournamentLayoutScreen()));
                      } else if (state is TournamentAuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed: ${state.message}")),
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is TournamentAuthLoading;

                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: buttonGradience(),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    context.read<TournamentAuthBloc>().add(
                                          AuthorizeTournamentRequested(),
                                        );
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Allow',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
