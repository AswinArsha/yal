import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalgamers/feature/tournament/data/repository/tournament_token_approve.dart';
import 'tournament_auth_event.dart';
import 'tournament_auth_state.dart';

class TournamentAuthBloc
    extends Bloc<TournamentAuthEvent, TournamentAuthState> {
  TournamentAuthBloc() : super(TournamentAuthInitial()) {
    on<AuthorizeTournamentRequested>(_onAuthorizeTournamentRequested);
  }

  Future<void> _onAuthorizeTournamentRequested(
    AuthorizeTournamentRequested event,
    Emitter<TournamentAuthState> emit,
  ) async {
    emit(TournamentAuthLoading());

    try {
      await authorizeWithTournamentService(
       
      );

      emit(TournamentAuthSuccess());
    } catch (e) {
      emit(TournamentAuthFailure(e.toString()));
    }
  }
}
