
abstract class TournamentAuthState  {
 
}

class TournamentAuthInitial extends TournamentAuthState {}

class TournamentAuthLoading extends TournamentAuthState {}

class TournamentAuthSuccess extends TournamentAuthState {}

class TournamentAuthFailure extends TournamentAuthState {
  final String message;

  TournamentAuthFailure(this.message);

}
